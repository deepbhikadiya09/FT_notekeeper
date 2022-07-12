import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../common/input_field.dart';
import '../../controller/signup_controller.dart';


class SignUpScreen extends StatefulWidget {
  final VoidCallback showSigUpScreen;

  const SignUpScreen({Key? key, required this.showSigUpScreen})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  final signUpController = Get.put<SignUpController>(SignUpController());

  @override
  void dispose() {
    // TODO: implement dispose
    signUpController.emailSignUpController.clear();
    signUpController.passwordSignUpController.clear();
    signUpController.confirmPasswordSignUpController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        /// APP BAR
        appBar: AppBar(
          backgroundColor: Colors.black,
          // automaticallyImplyLeading: true,
          title: const Text("Sign Up"),
          centerTitle: true,
        ),

        body: Form(
          key: formKey,
          child: GetBuilder<SignUpController>(
            init: signUpController,
            builder: (controller) => Container(
              margin: const EdgeInsets.all(17),
              width: width,
              height: height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    InputField(

                      controller: signUpController.emailSignUpController,
                      focusNode: signUpController.emailSignUpFocusNode,
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
                      height: 15,
                    ),

                    InputField(
                      controller: signUpController.passwordSignUpController,
                      focusNode: signUpController.passwordSignUpFocusNode,
                      hint: "Password",
                      obscureText: !signUpController.shoPass.value,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signUpController.shoPass.value =
                              !signUpController.shoPass.value;

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Icon(
                          signUpController.shoPass.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: Colors.black,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Password";
                        } else if(val.length>6){
                          return "Please less then 6 character";

                        }else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    InputField(
                      obscureText: !signUpController.showConfirmPass.value,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signUpController.showConfirmPass.value =
                              !signUpController.showConfirmPass.value;

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Icon(
                          signUpController.showConfirmPass.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: Colors.black,

                        ),
                      ),
                      controller:
                          signUpController.confirmPasswordSignUpController,
                      focusNode:
                          signUpController.confirmPasswordSignUpFocusNode,
                      hint: "confirmPassword",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Confirm Password";
                        } else if (val !=
                            signUpController.passwordSignUpController.text) {
                          return "Enter Same Password";
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signUpController.signUpData();
                          }
                        },
                        child: const Text("Sign Up"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// LOGIN TEXT
                    GestureDetector(
                      onTap: widget.showSigUpScreen,
                      child: RichText(
                        text: TextSpan(
                          text: "Have an account?",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                                text: " Log in",
                                style: TextStyle(
                                    color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
