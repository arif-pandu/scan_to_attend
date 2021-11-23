import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String usernameLogin = 'blank';
  String? passwordLogin;
  int? userID;

  bool isUsernameFilled = false;

  String usernameInput = '';

  bool? isPresence;
}
