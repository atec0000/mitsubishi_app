import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mitsubishi_app/common/index.dart';
import 'package:mitsubishi_app/global.dart';
import 'package:mitsubishi_app/screens/tabs.dart';
import 'package:mitsubishi_app/service/secure_storage_service.dart';
import 'auth_test/start_login.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // 多语言
      translations: Translation(), // 词典
      localizationsDelegates: Translation.localizationsDelegates, // 代理
      supportedLocales: Translation.supportedLocales, // 支持的语言种类
      locale: ConfigService.to.locale, // 当前语言种类
      fallbackLocale: Translation.fallbackLocale, // 默认语言种类
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SecureStorageService _secureStorageService = SecureStorageService();
  @override
  void initState() {
    super.initState();

    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final accessToken = await _secureStorageService.getAccessToken();

    if (accessToken != '') {
      // Use Future.delayed to wait for the current build phase to complete.
      Future.delayed(Duration.zero, () {
        // Automatically navigate to the HomeScreen.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen()),
        );
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
