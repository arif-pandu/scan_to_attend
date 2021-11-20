import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_to_attend/user_validaton.dart';

class LoginPassword extends StatefulWidget {
  const LoginPassword({Key? key}) : super(key: key);

  @override
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserValidation userValidation = Get.put(UserValidation());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('user');
    String userInput = userValidation.usernameLogin!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: user.doc(userInput).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                userValidation.usernameLogin = data['username'];

                print(data['username']);
                print(data['password']);

                return Text(
                  data['username'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
