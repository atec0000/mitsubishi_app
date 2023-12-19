

import 'dart:typed_data';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_buffers.dart';

import 'mqtt_server.dart';

MqttServerClient? _mqttClient;


Future<void> connectToMqttServer() async {
  try {
    _mqttClient = await connect();
  } catch (e) {
    print("fail to $e");
  }
}

// Future<void> publishMessage(String message,String mac) async {
//   final topic = 'devices/' + mac+ '/control/raw';
//   if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
//     final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
//     builder.addString(message);
//
//     _mqttClient!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//     print('Published to topic: $topic, message: $message');
//   } else {
//     print('Not connected to MQTT broker');
//   }
// }

Future<void> publishHexMessage(String hexString, String deviceMac) async {
  final topic = 'devices/' + deviceMac + '/control/raw';

  // Convert the hexadecimal string to a list of integers
  List<int> hexData = hexString
      .replaceAll(' ', '') // Remove any spaces in the hex string
      .split('')
      .map((e) => int.parse(e, radix: 16))
      .toList();

  if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    Uint8Buffer buffer = Uint8Buffer();
    buffer.addAll(Uint8List.fromList(hexData));

    builder.addBuffer(buffer);

    _mqttClient!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
    print('Published to topic: $topic, message: $hexString');
  } else {
    print('Not connected to MQTT broker');
  }
}

Future<void> disconnectFromMqttServer() async {
  if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
    _mqttClient!.disconnect();
    print("disconnect");
  }
}
Future<void> subscribecontrol(String mac) async {
  final topic = 'devices/' + mac+ '/control/raw';
  if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
    _mqttClient!.subscribe(topic, MqttQos.atMostOnce);
    print('Subscribed to topic: $topic');
  } else {
    print('Not connected to MQTT broker');
  }
}
Future<void> subscribeToTopic(String mac) async {
  final topic = 'devices/' + mac+ '/status/raw';
  print(topic);
  if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
    _mqttClient!.subscribe(topic, MqttQos.atMostOnce);
    print('Subscribed to topic: $topic');
  } else {
    print('Not connected to MQTT broker');
  }
}