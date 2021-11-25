// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/const/const.dart';
import 'package:scan_to_attend/pages/home.dart';
import 'package:scan_to_attend/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
bool isPresence = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool("LOGGEDIN") == null ? false : true;
  isPresence = prefs.getBool("ISPRESENCE") == null ? false : true;
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
      home: isLoggedIn == false
          ? LoginPage()
          : isPresence == false
              ? HomePage()
              : Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.miniEndTop,
                  floatingActionButton: GestureDetector(
                    onTap: () {
                      LogOut();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20, right: 7.5),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 20,
                          color: blueColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: "LesliesHand",
                        ),
                      ),
                    ),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You've already presence",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 20,
                            color: blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "LesliesHand",
                          ),
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            exit(0);
                          },
                          child: Container(
                            width: 200,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 3, color: blackColor),
                              color: yellowColor,
                            ),
                            child: Center(
                              child: Text(
                                "Continue To Work :)",
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "LesliesHand",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  void LogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.to(LoginPage());
  }
}
