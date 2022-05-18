// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../home/home.dart';
import '../shared/shared_components.dart';
import 'signup_components.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // final AuthController authController = Get.find<AuthController>();
  // final UserController userController = Get.find<UserController>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    Future signUp() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: simpleAppBar(
        onPressLeading: () {
          Navigator.of(context).pop();
        },
      ),
      body: mainContainerWidelySpread(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: roundedWidget(
              height: 750.h,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    signupText(),
                    SizedBox(
                      height: 5.h,
                    ),
                    textBeforeEachTextFormField(text: "Name"),
                    textFormField(
                        // controller: authController.name,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a username!';
                          } else if (value.length < 6) {
                            return "Please provide a username of 5+ character";
                          }
                          return null;
                        },
                        labelText: "Name",
                        hintText: "Enter your name",
                        prefixWidget: Icon(Icons.person)),
                    textBeforeEachTextFormField(text: "Email"),
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
                      hintText: "Enter your name",
                      prefixWidget: Icon(Icons.email),
                    ),
                    textBeforeEachTextFormField(text: "Password"),
                    textFormField(
                      controller: passwordController,
                      // controller: authController.password,
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
                      prefixWidget: Icon(Icons.lock),
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
                      height: 20.h,
                    ),
                    Center(
                      child: defaultButton(
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            // authController.createUser();
                            signUp();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }),
                            );
                          }
                        },
                        text: "Sign up",
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a member? ",
                          style: TextStyle(
                            // color: Colors.grey.shade900,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.back();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
