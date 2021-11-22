// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scan_to_attend/home.dart';
// import 'package:scan_to_attend/login_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPassword extends StatefulWidget {
//   const LoginPassword({Key? key}) : super(key: key);

//   @override
//   _LoginPasswordState createState() => _LoginPasswordState();
// }

// class _LoginPasswordState extends State<LoginPassword> {
//   TextEditingController passwordController = TextEditingController();

//   saveData(int source) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt('USERID', source);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     LoginController loginController = Get.put(LoginController());
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference user = firestore.collection('user');
//     String userInput = loginController.usernameLogin!;
//     Future<DocumentSnapshot<Object?>>? userData = user.doc(userInput).get();

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FutureBuilder(
//               future: userData,
//               builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if (snapshot.data!.data() == null) {
//                   String userInput = 'Who Are You';
//                   print(userInput);
//                 } else if (snapshot.data!.data() != null) {
//                   Map<String, dynamic> data =
//                       snapshot.data!.data() as Map<String, dynamic>;
//                   String userInput = data['username'];
//                   int userId = data['id'];

//                   loginController.passwordLogin = data['password'];
//                   loginController.userID = data['id'];

//                   print(userInput);
//                   print(userId.toString());

//                   //
//                 } else if (snapshot.hasError) {
//                   print('ERROR');
//                 }
//                 return Column(
//                   children: [
//                     Text(
//                       'Welcome, $userInput',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 40),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: TextField(
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         controller: passwordController,
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           hintStyle: TextStyle(
//                             color: Colors.black,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.green[200],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 40),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: SizedBox(
//                               child: Row(
//                                 children: const [
//                                   Icon(
//                                     Icons.arrow_back_rounded,
//                                     size: 18,
//                                   ),
//                                   Text(
//                                     'Back',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               if (passwordController.text ==
//                                   loginController.passwordLogin) {
//                                 saveData(loginController.userID!);
//                                 Get.to(HomePage());
//                               } else {
//                                 Get.snackbar(
//                                   "",
//                                   "Wrong Password Or Username",
//                                   margin: EdgeInsets.only(
//                                     top: 15,
//                                     left: 15,
//                                     right: 15,
//                                   ),
//                                   snackStyle: SnackStyle.FLOATING,
//                                   colorText: Colors.black,
//                                   titleText: Text(
//                                     "😱",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                   messageText: Text(
//                                     'Wrong Username or Password',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16,
//                                       // color: Colors.red[500],
//                                     ),
//                                   ),
//                                   backgroundColor: Colors.amber[200],
//                                   borderRadius: 10,
//                                   duration: Duration(seconds: 3),
//                                   snackPosition: SnackPosition.TOP,
//                                   reverseAnimationCurve: Curves.linearToEaseOut,
//                                   forwardAnimationCurve:
//                                       Curves.fastLinearToSlowEaseIn,
//                                 );
//                                 print(loginController.passwordLogin);
//                               }
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: 8,
//                                 horizontal: 15,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue[300],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
