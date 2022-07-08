import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/input_field.dart';
import '../../controller/login_controller.dart';
import 'forgetpassword_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showLoginScreen;

  const LoginScreen({Key? key, required this.showLoginScreen})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put<LoginController>(LoginController());
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    loginController.emailController.clear();
    loginController.passwordController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // title: const Text("Log In"),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: GetBuilder<LoginController>(
            init: loginController,
            builder: (controller) => Container(
              margin: const EdgeInsets.all(20),
              width: width,
              height: height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      "NotesApp",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InputField(
                      controller: loginController.emailController,
                      focusNode: loginController.emailLogInFocusNode,
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
                      obscureText: !loginController.showPass.value,
                      controller: loginController.passwordController,
                      focusNode: loginController.passwordLogInFocusNode,
                      hint: "Password",
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          loginController.showPass.value =
                              !loginController.showPass.value;

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Icon(
                          loginController.showPass.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          ),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(width / 1.1, height / 15)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          loginController.logInData();
                        }
                      },
                      child: const Text("Log In"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: widget.showLoginScreen,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: " Register",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
