import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController {
  final forgetEmailController = TextEditingController();
  FocusNode forgetEmailFocusNode = FocusNode();

  Future resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgetEmailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password reset link sent! Check your Email"),
      ));

      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
    } catch (e) {
      print(e);
    }
  }
}
