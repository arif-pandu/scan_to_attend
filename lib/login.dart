import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/user_validaton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    UserValidation userValidation = Get.put(UserValidation());
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('user');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: user
                  .where('username', isEqualTo: usernameController.value)
                  .get(),
              builder: (context, snapshot) {
                userValidation.usernameLogin =
                    snapshot.data!.runtimeType.toString();
                return Text(userValidation.usernameLogin!);
              },
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Username",
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                if (usernameController.value == null) {
                  Get.snackbar("WARNING", "WRONG USERNAME OR PASSWORD");
                } else {
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
