// ignore_for_file: prefer_const_constructors

import 'package:baianat/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///* Using ScreenUtilInit to handle all sorts of responsivety

    return ScreenUtilInit(
      designSize: Size(375, 838),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bainat Notes',
        theme: ThemeData(
          fontFamily: "Dosis",
        ),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        home: InitialScreen(),
      ),
    );
  }
}
