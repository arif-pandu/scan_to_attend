import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/pages/home.dart';
import 'package:scan_to_attend/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool("LOGGEDIN") == null ? false : true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Scan to Attend",
      debugShowCheckedModeBanner: false,
      // home: QRViewExample(),
      home: isLoggedIn == false ? LoginPage() : HomePage(),
    );
  }
}
