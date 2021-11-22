// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scan_to_attend/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/home.dart';
import 'package:scan_to_attend/login_controller.dart';
import 'package:scan_to_attend/widget/login_widget/password_input.dart';
import 'package:scan_to_attend/widget/login_widget/username_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BG-SVG
          Container(
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset(
              'assets/image/bg.svg',
              fit: BoxFit.cover,
            ),
          ),
          // USERNAME WELCOME
          Align(
            alignment: Alignment(0, -0.5),
            child: Text(
              loginController.isUsernameFilled == false
                  ? ''
                  : "WELCOME, " + usernameInputController.text,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: "LesliesHand"),
            ),
          ),
          //
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UsernameInput(
                  controller: usernameInputController,
                ),
                SizedBox(height: 15),
                Visibility(
                  visible:
                      loginController.isUsernameFilled == true ? true : false,
                  child: PasswordInput(
                    controller: passwordInputController,
                  ),
                ),
                SizedBox(height: 15),
                //
                // NextLoginButton
                loginController.isUsernameFilled == false
                    // KALO BELUM ISI NAMA
                    ? GestureDetector(
                        onTap: () {
                          if (usernameInputController.text != '') {
                            // FIREBASE BUAT STORE DATA USER AWAL SINI
                            setState(() {
                              loginController.isUsernameFilled = true;
                            });
                          } else {
                            WarningUsername();
                          }
                        },
                        child: Container(
                          height: 56,
                          width: 120,
                          decoration: BoxDecoration(
                            color: yellowColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3, color: blackColor),
                          ),
                          child: Center(
                            child: Text(
                              "NEXT",
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                fontFamily: "LesliesHand",
                                color: blackColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    // KALO UDAH ISI NAMA
                    : GestureDetector(
                        onTap: () {
                          if (passwordInputController.text != '') {
                            Get.to(HomePage());
                          } else {
                            WarningPassword();
                          }
                        },
                        child: Container(
                          height: 56,
                          width: 120,
                          decoration: BoxDecoration(
                            color: yellowColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3, color: blackColor),
                          ),
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                fontFamily: "LesliesHand",
                                color: blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void WarningUsername() {
    return Get.snackbar(
      "Warning",
      "Username required",
      margin: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      snackStyle: SnackStyle.FLOATING,
      colorText: Colors.white,
      titleText: Text(
        "Hey Dude!",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        'You Have a Name Right?',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      backgroundColor: redColor,
      borderRadius: 10,
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      reverseAnimationCurve: Curves.linearToEaseOut,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void WarningPassword() {
    return Get.snackbar(
      "Warning",
      "Username required",
      margin: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      snackStyle: SnackStyle.FLOATING,
      colorText: Colors.white,
      titleText: Text(
        "Hey Dude!",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        'Your password or username was wrong',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      backgroundColor: redColor,
      borderRadius: 10,
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      reverseAnimationCurve: Curves.linearToEaseOut,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    );
  }
}
