// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unrelated_type_equality_checks

import 'dart:async';

import 'package:baianat/controllers/deepLinkService.dart';
import 'package:baianat/login/login_screen.dart';
import 'package:baianat/signup/signup_screen.dart';
import 'package:baianat/utils/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'home/home.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState) {
                return Center(
                  child: LinearProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                    body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Something went wrong!"),
                  ],
                ));
              } else if (snapshot.hasData) {
                return HomePage();
              } else {
                return LoginScreen();
              }
            },
          ),
        ),
      );
      Get.putAsync<DeepLinkService>(() => DeepLinkService().init());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.kMaindarkColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                MyColors.kMaindarkColor,
                MyColors.kMaindarkColor,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/baianat.png",
                height: 196.h,
                width: 196.w,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Baianat Notes",
                style: TextStyle(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60.h,
              ),
              SpinKitSpinningLines(
                color: Colors.white,
                duration: Duration(seconds: 5),
                size: 150.r,
                lineWidth: 5.w,
                itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
