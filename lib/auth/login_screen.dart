
import 'package:mitsubishi_app/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:mitsubishi_app/service/api_service.dart';
import 'package:mitsubishi_app/widget/static_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'auth_verification.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final ApiService apiService = ApiService();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;



  Future<void> login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      final response = await widget.apiService.login(email, password);

      if (response.statusCode == 200) {
        _openHomeScreen();
      } else {
        // TODO: Show error message
      }
    } catch (e) {
      print('Login failed: $e');
    }
  }

  void _openHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => TabsScreen()), // Navigate to HomeScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.of(context).viewInsets.bottom,
      body: _initLoginPage(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _initLoginPage() {
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
                      child: FaIcon(
                          FontAwesomeIcons.envelope,
                          color: Colors.white,
                      ),

                    ),
                    hintText: '輸入信箱',
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white), // 設置標籤文字的顏色
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)), // 設置提示文字的顏色
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.white),
                    )),
              ),
              const SizedBox(height: 30), // 添加间距
              TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: '輸入密碼',
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white), // 設置標籤文字的顏色
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)), // 設置提示文字的顏色
                  prefixIcon: Transform.translate(
                    offset: Offset(1, 1),
                    child: Icon(
                        Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Theam.login_Buttons('登入', context, login),
              SizedBox(height: 16),
              buildDividerWithText(1.0, Colors.white, 16.0, 16.0, "OR"),
          ElevatedButton.icon(
            onPressed: signInWithGoogle,
            icon: FaIcon(FontAwesomeIcons.googlePlusG),
            label: Text('Sign In with Google'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // 設定背景色為紅色
            ),
          ),
              ElevatedButton.icon(
                onPressed: signInWithApple,
                icon: FaIcon(FontAwesomeIcons.apple),
                label: Text('Sign In with Apple'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // 設定背景色為紅色
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
