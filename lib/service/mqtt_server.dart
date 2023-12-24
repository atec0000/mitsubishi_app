import 'dart:convert';

import 'package:mitsubishi_app/service/secure_storage_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final SecureStorageService _secureStorageService = SecureStorageService();

Future<MqttServerClient> connect() async {
  MqttServerClient client = MqttServerClient.withPort(
      'broker.wificontrolbox.com',
      'Selina_${DateTime.now().millisecondsSinceEpoch}',
      1883);
  client.logging(on: true);
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;
  client.onUnsubscribed = onUnsubscribed;
  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;
  client.keepAlivePeriod = 60;
  client.setProtocolV311();
  String userEmail = await _secureStorageService.getEmail();
  print(userEmail);
  String accesstoken = await _secureStorageService.getAccessToken();
  print(accesstoken);

  final connMessage = MqttConnectMessage()
      .authenticateAs(userEmail, accesstoken)
      // .withWillTopic('willtopic') //遺屬主題
      // .withWillMessage('Will message')  //遺屬訊息
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMessage;
  try {
    await client.connect();
    print("connected");
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      var recv = event[0].payload as MqttPublishMessage;
      var topicName = recv.variableHeader?.topicName;

      // Check if the payload is JSON
      try {
        var jsonMessage =
            json.decode(const Utf8Decoder().convert(recv.payload.message));
        print("接收到的主题: $topicName, 消息 (JSON): $jsonMessage");
        // Handle the JSON message here
      } catch (_) {
        // If parsing as JSON fails, check if it's a string
        try {
          var stringMessage = const Utf8Decoder().convert(recv.payload.message);
          print("接收到的主题: $topicName, 消息 (String): $stringMessage");
          // Handle the string message here
        } catch (_) {
          // If parsing as a string also fails, treat it as hexadecimal
          var hexMessage = recv.payload.message;
          print("接收到的主题: $topicName, 消息 (Hex): $hexMessage");
          // Handle the hexadecimal message here
        }
      }
    });
  } else {
    print(
        'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
  }

  return client;
}

void onConnected() {
  print('Connected');
}

// 斷開
void onDisconnected() {
  print('Disconnected');
}

// 訂閱主题成功
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// 訂閱主题失败
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// 成功取消訂閱
void onUnsubscribed(String? topic) {
  print('Unsubscribed topic: $topic');
}

// 收到 PING 響應
void pong() {
  print('Ping response client callback invoked');
}
