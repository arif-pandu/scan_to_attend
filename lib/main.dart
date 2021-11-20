import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/home.dart';
import 'package:scan_to_attend/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Scan to Attend",
      debugShowCheckedModeBanner: false,
      // home: QRViewExample(),
      home: LoginPage(),
    );
  }
}
