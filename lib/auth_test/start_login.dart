import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/common/components/index.dart';
import 'package:mitsubishi_app/common/widgets/index.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'auth_verifivation.dart';
import 'constants.dart';
import 'next_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = 'mm6@aifa.com';
  String password = 'aaaaaaa1';
  bool showSpinner = false;
  String accessToken = '';
  String refreshToken = '';

  void readPreferences() async {
    //Navigator.pushNamed(context, DevicesList.id, arguments: accessToken);
  }

  @override
  void initState() {
    super.initState();

    readPreferences();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                '註冊上洋智慧空調帳號，開啟智慧生活新一步',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color3,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  minimumSize: const Size(200, 42),
                  backgroundColor: backgroundColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(0),
                ),
                child: const Text(EMAIL),
                onPressed: () {
                  Get.to(() => const NextLoginScreen());
                },
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                child: const Text('手機號碼'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundButton(
                text: 'Login with Google',
                color: const Color(0xfffe9200),
                onPressed: () async {
                  await signInWithGoogle();
                },
              ),
              RoundButton(
                text: 'Login with Apple',
                color: const Color(0xff888177),
                onPressed: () async {
                  await signInWithApple();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
