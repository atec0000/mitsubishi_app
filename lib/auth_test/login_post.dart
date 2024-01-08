import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:mitsubishi_app/service/api_service.dart';
import 'package:mitsubishi_app/auth_test/constants.dart';

import '../screens/tabs.dart';

class LoginPostScreen extends StatefulWidget {
  final String email;
  const LoginPostScreen(this.email, {super.key});
  @override
  _LoginPostScreenState createState() => _LoginPostScreenState();
}

class _LoginPostScreenState extends State<LoginPostScreen> {
  String email = '';
  String password = '';
  bool showSpinner = false;

  //SecureStorageService secureStorage = SecureStorageService();

  void goToNext() async {
    try {
      
      final response = await ApiService().login(widget.email, password);
      //final response = await apiService.login('mm4@aifa.com', 'aa');
      if (kDebugMode) {
        Get.off(() => const TabsScreen());
        print('Login OK');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(LOGIN_SINUP),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      EMAIL,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: color3,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: TextEditingController()..text = widget.email,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '輸入密碼，來登入您的帳號',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: color3,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: TextEditingController()..text = password,
                textAlign: TextAlign.center,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  minimumSize: const Size(100, 42),
                  backgroundColor: backgroundColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () {
                  goToNext();
                },
                child: const Text('登入'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
