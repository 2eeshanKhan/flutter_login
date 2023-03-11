import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/signin_screen.dart';
import '../screens/userinfo_screen.dart';

class Service {
  final auth = FirebaseAuth.instance;

  createUser(email, password, context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfoScreen()))
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'Email is already in use.Login to continue');
      } else {
        error(context, e);
      }
    }
  }

  loginUser(email, password, context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User Not Found,Please Sign Up');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Please Enter correct Password');
      } else {
        error(context, e);
      }
    }
  }

  error(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
          );
        });
  }
}
