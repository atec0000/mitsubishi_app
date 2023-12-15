import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../service/mqtt_server.dart';

class MqttConnectionScreen extends StatefulWidget {
  @override
  _MqttConnectionScreenState createState() => _MqttConnectionScreenState();
}

class _MqttConnectionScreenState extends State<MqttConnectionScreen> {
  MqttServerClient? _mqttClient;
  String _connectionStatus = 'Disconnected';

  @override
  void initState() {
    super.initState();
    _connectToMqttServer();
  }

  Future<void> _connectToMqttServer() async {
    try {
      _mqttClient = await connect();
      setState(() {
        _connectionStatus = 'Connected';
      });
    } catch (e) {
      setState(() {
        _connectionStatus = 'Connection Failed';
      });
    }
  }

  Future<void> _disconnectFromMqttServer() async {
    // 断开 MQTT 服务器连接的逻辑
    // 请替换成你的实际逻辑
    if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
      _mqttClient!.disconnect();
      setState(() {
        _connectionStatus = 'Disconnected';
      });
    }
  }
  Future<void> _subscribeToTopic() async {
    final topic = 'devices/112233445566';
    if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
      _mqttClient!.subscribe(topic, MqttQos.atMostOnce);
      print('Subscribed to topic: $topic');
    } else {
      print('Not connected to MQTT broker');
    }
  }

  Future<void> _publishMessage(String message) async {
    final topic = 'devices/112233445566';
    final message = 'Selina say,Hello.';
    if (_mqttClient != null && _mqttClient!.connectionStatus!.state == MqttConnectionState.connected) {
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(message);

      _mqttClient!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
      print('Published to topic: $topic, message: $message');
    } else {
      print('Not connected to MQTT broker');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MQTT Connection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connection Status: $_connectionStatus', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _connectToMqttServer,
              child: Text('Connect'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _disconnectFromMqttServer,
              child: Text('Disconnect'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _subscribeToTopic,
              child: Text('Subscribe'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _publishMessage,
              child: Text('Publish Message'),
            ),
          ],
        ),
      ),
    );
  }
}