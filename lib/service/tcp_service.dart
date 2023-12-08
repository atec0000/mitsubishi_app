import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mitsubishi_app/service/secure_storage_service.dart';

class TcpService {
  Socket? _socket;
  final SecureStorageService _secureStorageService = SecureStorageService();
  bool _authenticationDone = false;

  final List<void Function(Uint8List)> _responseListeners = [];
  Uint8List? receivedData;

  Future<bool> connectToServer(String mac) async {
    final Completer<bool> completer = Completer<
        bool>(); //異步操作時，滿足條件時，會標記成功completer.complete(true)。相反則為失敗false
    bool connectionSuccess = false;

    try {
      final socket = await SecureSocket.connect(
        'beta.aifaremote.com', //test server
        8751,
        timeout: const Duration(seconds: 5),
        onBadCertificate: (certificate) {
          print('Bad certificate');
          completer.complete(false);
          return false;
        },
      );
      _socket = socket;

      print('Connected to aifaremote.com:8751');
      connectionSuccess = true;

      // Send initial data (0xaa, 0xbb)
      final accessToken = await _secureStorageService.getAccessToken();
      final json = {
        'mac': mac,
        'token': accessToken,
      };
      final encodedJson = utf8.encode(jsonEncode(json));
      socket.add([
        0xa1,
        0xfa,
        0xd7,
        0xc0,
        ...encodedJson,
      ]);

      // Listen for responses
      _socket?.listen((Uint8List data) {
        handleServerResponse(data, completer);
      });

      // Handle errors
      _socket?.addError((error) {
        print('Socket error: $error');
        disconnect();
        completer.complete(false);
      });
    } catch (e) {
      print('Connection error: $e');
    }

    if (!connectionSuccess) {
      completer.complete(false);
    }

    return completer.future; //這裡會知道最終是true or false
  }

  List<Uint8List> receivedDataList = [];
  void storeReceivedData(Uint8List data) {
    // 存储接收的数据
    receivedDataList.add(data);
  }

  String uint8ListToHexString(Uint8List uint8list) {
    var hex = "";
    for (var i in uint8list) {
      var x = i.toRadixString(16);
      if (x.length == 1) {
        x = "0$x";
      }
      hex += x;
    }
    return hex;
  }

  List<int> convertHexToBytes(String hexString) {
    List<int> bytes = [];

    // Remove any leading "0x" if present
    if (hexString.startsWith("0x")) {
      hexString = hexString.substring(2);
    }

    // Ensure the hexString has an even number of characters
    if (hexString.length % 2 != 0) {
      hexString = '0' + hexString;
    }

    for (int i = 0; i < hexString.length; i += 2) {
      String hexPair = hexString.substring(i, i + 2);
      int byteValue = int.parse(hexPair, radix: 16);
      bytes.add(byteValue);
    }

    return bytes;
  }

  void handleServerResponse(Uint8List data, Completer<bool> completer) {
    // Handle the received data
    print('Received ${data.length} bytes: ${uint8ListToHexString(data)}');

    if (data.isNotEmpty && data[0] == 0x00 && !_authenticationDone) {
      _authenticationDone = true;
      if (!completer.isCompleted) {
        completer.complete(true);
      }
    } else if (!_authenticationDone) {
      _socket!.close();
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    } else {
      try {
        final jsonString = utf8.decode(data);
        print('Received JSON data: $jsonString');
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    }
    _notifyResponseListeners(data);
  }

  // Notify response listeners with the received data

  void sendCommand(List<int> command) {
    if (_socket != null) {
      print(
          'Sending ${command.length} bytes: ${uint8ListToHexString(Uint8List.fromList(command))}');
      _socket!.add(Uint8List.fromList(command));
    } else {
      print('Socket is not connected.');
    }
  }

  void disconnect() {
    if (_socket != null) {
      _socket!.close();
      print('Disconnected from server.');
    }
  }

  void startListening(void Function(String response) onResponseReceived) {
    _socket?.listen((Uint8List data) {
      String response = uint8ListToHexString(data);
      onResponseReceived(response);
    });
  }

  void addResponseListener(void Function(Uint8List) listener) {
    _responseListeners.add(listener);
  }

  void removeResponseListener(void Function(String) listener) {
    _responseListeners.remove(listener);
  }

  void _notifyResponseListeners(Uint8List response) {
    for (final listener in _responseListeners) {
      listener(response);
    }
  }
}
