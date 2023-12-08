import 'package:flutter/material.dart';
import 'package:mitsubishi_app/auth/login_screen.dart';
import 'package:mitsubishi_app/widget/static_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  bool _acceptTerms = false;

  void register() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    bool registrationSuccess = true; // Replace with actual logic

    if (registrationSuccess) {
      List<String> registrationDetails = [email, password]; //這裡建立一個list
      _SignuptoLogin();
    }
  }

  void _SignuptoLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.of(context).viewInsets.bottom,
      body: _initSignupPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = "";
    _passwordController.text = "";
  }

  Widget _initSignupPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: Theam().buildGradient(
          Color.fromARGB(255, 13, 102, 204),
          Color.fromARGB(255, 0, 39, 73),
          Alignment.topLeft,
          Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    prefixIcon: Transform.translate(
                      offset: Offset(10, 12),
                      child: FaIcon(FontAwesomeIcons.envelope),
                    ),
                    hintText: '輸入信箱',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
              const SizedBox(height: 30), // 添加间距
              TextField(
                obscureText: !_passwordVisible,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: '輸入密碼',
                  labelText: 'Password',
                  prefixIcon: Transform.translate(
                    offset: Offset(1, 1),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: !_passwordVisible,
                controller: _checkpasswordController,
                decoration: InputDecoration(
                  hintText: '確認密碼',
                  labelText: 'Checkpassword',
                  prefixIcon: Transform.translate(
                    offset: Offset(1, 1),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value!;
                      });
                    },
                  ),
                  Text('I accept the terms and conditions'),
                ],
              ),
              SizedBox(height: 16),
              Theam.signup_Buttons('註冊', context, register),
            ],
          ),
        ),
      ),
    );
  }
}
