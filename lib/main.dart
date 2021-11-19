import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Scan to Attend",
      debugShowCheckedModeBanner: false,
      home: QRViewExample(),
    );
  }
}
