// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:scan_to_attend/login/login_password.dart';
// import 'package:scan_to_attend/login_controller.dart';

// class LoginUsername extends StatefulWidget {
//   const LoginUsername({Key? key}) : super(key: key);

//   @override
//   _LoginUsernameState createState() => _LoginUsernameState();
// }

// class _LoginUsernameState extends State<LoginUsername> {
//   TextEditingController usernameController = TextEditingController();

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     usernameController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     LoginController loginController = Get.put(LoginController());

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: TextField(
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     hintText: "Username",
//                     hintStyle: TextStyle(
//                       color: Colors.black,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Colors.green[200],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         if (usernameController.text == "") {
//                           Get.snackbar(
//                             "Warning",
//                             "Username required",
//                             margin: EdgeInsets.only(
//                               top: 15,
//                               left: 15,
//                               right: 15,
//                             ),
//                             snackStyle: SnackStyle.FLOATING,
//                             colorText: Colors.black,
//                             titleText: Text(
//                               "Hey Dude!",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             messageText: Text(
//                               'You Have a Name Right?',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16,
//                                 // color: Colors.red[500],
//                               ),
//                             ),
//                             backgroundColor: Colors.amber[200],
//                             borderRadius: 10,
//                             duration: Duration(seconds: 3),
//                             snackPosition: SnackPosition.TOP,
//                             reverseAnimationCurve: Curves.linearToEaseOut,
//                             forwardAnimationCurve:
//                                 Curves.fastLinearToSlowEaseIn,
//                           );
//                         } else {
//                           setState(() {
//                             loginController.usernameLogin =
//                                 usernameController.text;
//                             Get.to(LoginPassword());
//                           });
//                         }
//                       },
//                       child: SizedBox(
//                         child: Row(
//                           children: const [
//                             Text(
//                               'Next',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_right_alt_rounded,
//                               size: 29,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
