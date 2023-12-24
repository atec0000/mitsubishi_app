import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/auth_test//constants.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  const VerifyPage(this.email, {super.key});

  @override
  _VerifyPageState createState() => _VerifyPageState(email);
}

class _VerifyPageState extends State<VerifyPage> {
  _VerifyPageState(this.email);
  final String email;
  bool _buttonEnabled = true;
  int _countdownSeconds = 30;
  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(LOGIN_SINUP),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              '歡迎使用上洋空調APP',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color3,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              '我們已傳送驗證信到$email⋯⋯',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color3,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ElevatedButton(
              onPressed: _buttonEnabled ? _startCountdown : null,
              child: Text('$_countdownSeconds秒後可重發驗證信'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                Get.until((route) => route.isFirst);
                //navigator!.popUntil(context, ModalRoute.withName('/'));
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.black,
                ),
                minimumSize: const Size(100, 42),
                backgroundColor: backgroundColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(0),
              ),
              child: const Text('返回首頁'),
            ),
          ],
        ),
      ),
    );
  }

  void _startCountdown() {
    setState(() {
      _buttonEnabled = false;
    });
    // Start the countdown
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdownSeconds == 0) {
          setState(() {
            _buttonEnabled = true;
            _countdownSeconds = 30;
            timer.cancel();
          });
        } else {
          setState(() {
            _countdownSeconds--;
          });
        }
      },
    );

    // Future.delayed(Duration(seconds: 30), () {
    //   setState(() {
    //     _buttonEnabled = true;
    //   });
    // });
  }
}
