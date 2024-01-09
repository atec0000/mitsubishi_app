import 'package:flutter/material.dart';
import 'package:mitsubishi_app/service/api_service.dart';
import 'package:flutter_blufi/flutter_blufi.dart';

import '../model/family.dart';
import '../screens/tabs.dart';
import '../service/secure_storage_service.dart';
import '../bluetooth_pair/family_widget.dart';
import '../widget/static_style.dart';

class Addfamily extends StatefulWidget {
  Addfamily({Key? key}) : super(key: key);

  final ApiService apiService = ApiService();

  @override
  _AddfamilyState createState() => _AddfamilyState();
}

class _AddfamilyState extends State<Addfamily> {
  bool isLoading = false;
  final SecureStorageService secureStorageService = SecureStorageService();
  Set<Home> selectedHomes = Set<Home>();
  int? selectedHomeId;
  final ApiService _apiService = ApiService();
  TextEditingController _familyNameController = TextEditingController();

  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('新增家庭'),
          content: Container(
            width: 300.0, // Set your desired width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Use min to wrap content
              children: [
                const Text('請輸入家庭名稱'),
                TextField(
                  controller: _familyNameController,
                  decoration: InputDecoration(labelText: '家庭名稱'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 關閉對話框
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                await _apiService.creatfamily(_familyNameController.text);
                Navigator.of(context).pop(); // 關閉對話框
              },
              child: const Text('確定'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFamilyList(List<Home> homes) {
    return ListView.builder(
      itemCount: homes.length,
      itemBuilder: (context, index) {
        Home home = homes[index];

        return MyCheckbox(
          label: home.name,
          isSelected: selectedHomeId == home.id,
          onToggle: (bool isChecked) {
            setState(() {
              if (isChecked) {
                selectedHomeId = home.id;
                print(selectedHomeId);
              } else {
                selectedHomeId = null;
              }
            });
          },
        );
      },
    );
  }

  void _adddevice() async {
    try {
      var familyId = selectedHomeId;
      var espBlufi = EspBlufi.instance.getMac();
      print('ID: $familyId');
      print('MAC: $espBlufi');

      await widget.apiService.no_time_refreshTokenIfNeeded();
      await widget.apiService.addDevice(familyId!, espBlufi);

      // Navigate to TabsScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TabsScreen(),
        ),
      );
    } catch (error) {
      print('Error connecting device: $error');
      // Handle errors
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('新增設備'),
        ),
        body: content());
  }

  Widget content() {
    return Center(
      child: Column(
        children: [
          const Text(
            '配對完成',
            style: TextStyle(fontSize: 24),
          ),
          const Text(
            ' 您現在可以修改設備名稱',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            '請選擇欲加入的家庭',
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 30.0,
                    color: Colors.green, // You can customize the color
                  ),
                  Text(
                    '新增裝置',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                _showDeleteDialog(
                    context); // Add parentheses to call the method
              },
            ),
          ),
          FutureBuilder<List<Home>>(
            future: widget.apiService.getfamily(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Expanded(
                  child: _buildFamilyList(snapshot.data!),
                );
              } else {
                return Text('No families found.');
              }
            },
          ),
          // FloatingActionButton(
          //    onPressed: () {
          //      _showDeleteDialog(context);
          //    },
          //    tooltip: '新增家庭',
          //    child: Icon(Icons.add),
          //  ),
          const SizedBox(
            height: 20,
          ),
          Theam().next_step_Buttons('完成', context, () {
            _adddevice();
          }),
        ],
      ),
    );
  }
}
