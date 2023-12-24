import 'package:flutter/material.dart';

import '../bluetooth_pair/pageswitch_blufi.dart';
import '../service/mqtt_service.dart';

class MqttConnectionScreen extends StatefulWidget {
  final String deviceMac;

  const MqttConnectionScreen({super.key, required this.deviceMac});

  @override
  _MqttConnectionScreenState createState() => _MqttConnectionScreenState();
}

class _MqttConnectionScreenState extends State<MqttConnectionScreen> {
  final poweron =
      'AA0007B299B6FF0000000000FFFFFFFF0F0207C200110A0000000000FFFFFFFFA2';
  final poweroff =
      'AA0007B399B6FF0000800000FFFFFFFF0F02084300110A0000000000FFFFFFFFA5';

  @override
  void initState() {
    super.initState();
    connectToMqttServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const ElevatedButton(
              onPressed: connectToMqttServer,
              child: Text('Connect'),
            ),
            const SizedBox(height: 20),
            const ElevatedButton(
              onPressed: disconnectFromMqttServer,
              child: Text('Disconnect'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await subscribeToTopic(widget.deviceMac);
              },
              child: const Text('Recived response'),
            ),
            ElevatedButton(
              onPressed: () async {
                await subscribecontrol(widget.deviceMac);
              },
              child: const Text('Subscribe'),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    publishHexMessage(poweron, widget.deviceMac);
                  },
                  child: const Text('電源開'),
                ),
                ElevatedButton(
                  onPressed: () {
                    publishHexMessage(poweroff, widget.deviceMac);
                  },
                  child: const Text('電源關'),
                ),
              ],
            ),
            FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.bluetooth),
                          title: const Text('Bluetooth Pairing'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PageSwitcher(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Pair',
              icon: const Icon(Icons.add),
              label: const Text('Pair'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Colors.purpleAccent),
              ),
              backgroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
