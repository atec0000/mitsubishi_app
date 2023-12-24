import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mitsubishi_app/auth_test/constants.dart';
import 'package:mitsubishi_app/auth_test/verify_email.dart';

class RegisterPage extends StatefulWidget {
  final String email;
  const RegisterPage(this.email, {super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String password = '';
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
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
                      '設定密碼，來完成註冊步驟',
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
                height: 60.0,
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
                onPressed: () async {
                  // HttpRequests requests = HttpRequests();
                  // final response = await requests.registerUser(widget.email, password);
                  // if (response != null) {
                  //
                  // }
                  if (password != '') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyPage(widget.email)));
                  }
                  //print('-=-=-==-=--=-$response');
                },
                child: const Text('註冊'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
