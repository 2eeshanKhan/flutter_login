import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/screens/profile_screen.dart';

import 'package:flutter_catalog/screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static final String keyLogin = "login";

  @override
  void initState() {
    super.initState();
    whereToGo(context as BuildContext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
            child: Text(
          'Fuerte',
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
        )),
      ),
    );
  }

  void whereToGo(BuildContext context) async {
    var sharedPref = await SharedPreferences.getInstance();
    // ignore: unused_local_variable

    var isLoggedIn = sharedPref.getBool(keyLogin);

    Timer(Duration(seconds: 2), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ));
        }
      } else {
        Navigator.pushReplacement(
            context as BuildContext,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ));
      }
    });
  }
}
