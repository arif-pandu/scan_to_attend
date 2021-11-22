import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String? usernameLogin;
  String? passwordLogin;

  int? userID;

  bool isUsernameFilled = false;
  bool isUsernameValid = false;
  bool isUsernameMatchPassword = false;

  String usernameInput = '';
}
