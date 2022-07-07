import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/input_field.dart';
import '../../controller/forgetpassword_controller.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  final forgetController = Get.put<ForgetController>(ForgetController());

@override
  void dispose() {
    // TODO: implement dispose
  forgetController.forgetEmailController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: GetBuilder<ForgetController>(
          init: forgetController,
          builder: (controller) =>Padding(
          padding: const EdgeInsets.all(17.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Enter Your Email and we will send you a password reset link.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(
                  height: 25,
                ),

                InputField(
                  controller: forgetController.forgetEmailController,
                  focusNode: forgetController.forgetEmailFocusNode,
                  hint: "Email",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email";
                    } else if (!ValidationUtils.validateEmail(val)) {
                      return "Please enter a valid e-mail";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                /// LOG IN BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(width / 1.1, height / 15)),
                  onPressed: (){
                    if (formKey.currentState!.validate()) {
                      forgetController.resetPassword(context);
                    }
                  },
                  child: const Text("Reset Password"),
                ),
              ],
            ),
          ),
        ),
    ),
      ),
    );
  }

}
