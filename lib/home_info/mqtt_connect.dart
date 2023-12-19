import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../bluetooth_pair/pageswitch_blufi.dart';
import '../service/mqtt_service.dart';

class MqttConnectionScreen extends StatefulWidget {
  final String deviceMac;

  MqttConnectionScreen({required this.deviceMac});

  @override
  _MqttConnectionScreenState createState() => _MqttConnectionScreenState();
}

class _MqttConnectionScreenState extends State<MqttConnectionScreen> {
  final poweron = 'AA0007B299B6FF0000000000FFFFFFFF0F0207C200110A0000000000FFFFFFFFA2';
  final poweroff = 'AA0007B399B6FF0000800000FFFFFFFF0F02084300110A0000000000FFFFFFFFA5';

  @override
  void initState() {
    super.initState();
    connectToMqttServer();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: connectToMqttServer,
              child: Text('Connect'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: disconnectFromMqttServer,
              child: Text('Disconnect'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await subscribeToTopic(widget.deviceMac);
              } ,
              child: Text('Recived response'),
            ),
            ElevatedButton(
              onPressed: () async {
                await subscribecontrol(widget.deviceMac);
              },
              child: Text('Subscribe'),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: ()  {
                    publishHexMessage(poweron,widget.deviceMac);
                  },
                  child: Text('電源開'),
                ),
                ElevatedButton(
                  onPressed: ()  {
                    publishHexMessage(poweroff,widget.deviceMac);
                  },
                  child: Text('電源關'),
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
                              leading: Icon(Icons.bluetooth),
                              title: Text('Bluetooth Pairing'),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PageSwitcher(),
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
                  icon: Icon(Icons.add),
                  label: Text('Pair'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.purpleAccent),
                  ),
                  backgroundColor: Colors.white,
                )

          ],
        ),
      ),
    );
  }
}