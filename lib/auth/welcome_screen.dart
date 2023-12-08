import 'package:mitsubishi_app/auth/registration_screen.dart';
import 'package:mitsubishi_app/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:mitsubishi_app/service/secure_storage_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final SecureStorageService _secureStorageService = SecureStorageService();
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TabsScreen()),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _navigateToRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    // Simulate checking for a saved token and its expiration status.
    final accessToken = await _secureStorageService.getAccessToken();

    if (accessToken != '') {
      // Use Future.delayed to wait for the current build phase to complete.
      Future.delayed(Duration.zero, () {
        // Automatically navigate to the HomeScreen.
        _navigateToHome(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _navigateToLogin(context);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _navigateToRegistration(context);
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
