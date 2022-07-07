import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode emailLogInFocusNode = FocusNode();
  FocusNode passwordLogInFocusNode = FocusNode();
  RxBool showPass = false.obs;

  Future logInData() async {
    try {
      if (emailController.text.isNotEmpty &
          passwordController.text.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      }
    } catch (e) {
      print(e);
    }
  }
}
