import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:login_design2/app.dart';
import 'package:login_design2/features/authentication/Login/login_page.dart';
import 'package:login_design2/features/authentication/signUp/signup_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: App(),
      initialRoute: "/login",
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => SignupPage(),
      },
    ),
  );
}


  // This widget is the root of your application.
 

