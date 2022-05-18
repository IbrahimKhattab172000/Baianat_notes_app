// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:baianat/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../shared/shared_components.dart';
import 'login_components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: simpleAppBar(showLeading: false),
      body: mainContainerWidelySpread(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 75.h),
            child: roundedWidget(
              height: 690.h,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loginText(),
                    SizedBox(
                      height: 8.h,
                    ),
                    textBeforeEachTextFormField(
                      text: "Email",
                    ),
                    textFormField(
                      // controller: authController.email,
                      controller: emailController,
                      validator: (value) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      labelText: "Email",
                      hintText: "Enter your email",
                      prefixWidget: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    textBeforeEachTextFormField(
                      text: "Password",
                    ),
                    textFormField(
                      // controller: authController.password,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a password!';
                        } else if (value.length < 6) {
                          return "Please provide password of 5+ character ";
                        }
                        return null;
                      },
                      labelText: "Password",
                      hintText: "Enter your Password",
                      isPassword: isPassword,
                      prefixWidget: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.lock,
                          color: Colors.black38,
                        ),
                      ),
                      suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        icon: isPassword
                            ? Icon(Icons.remove_red_eye_sharp)
                            : Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    forgetPassword(context),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: defaultButton(
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            signIn();
                            navigateTo(context, HomePage());
                          }
                        },
                        text: "Log in",
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          dontHaveAccText(),
                          SizedBox(
                            width: 10.w,
                          ),
                          signupHere(context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          smallLine(),
                          orLoginWithText(),
                          smallLine(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    otherLoginApproachs(),
                    SizedBox(
                      height: 10.h,
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
