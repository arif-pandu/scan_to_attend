import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/const/const.dart';
import 'package:scan_to_attend/controller/login_controller.dart';

class UsernameInput extends StatefulWidget {
  const UsernameInput({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  State<UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 230,
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 3, color: blackColor),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            controller: widget.controller,
            onChanged: (value) {
              LoginController loginController = Get.put(LoginController());
              setState(() {
                loginController.usernameLogin = value;
              });
            },
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "LesliesHand",
            ),
            decoration: InputDecoration(
              hintText: "USERNAME",
              hintStyle: TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: "LesliesHand",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
