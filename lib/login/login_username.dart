import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/login/login_password.dart';
import 'package:scan_to_attend/user_validaton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserValidation userValidation = Get.put(UserValidation());

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                    fillColor: Colors.green[200],
                    focusColor: Colors.green[200],
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text("Login"),
                onPressed: () {
                  if (usernameController.text == "") {
                    Get.snackbar("Warning", "Username required");
                  } else {
                    setState(() {
                      userValidation.usernameLogin = usernameController.text;
                      Get.to(LoginPassword());
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
