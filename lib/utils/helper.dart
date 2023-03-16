import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../screens/userinfo_screen.dart';

class Service extends GetxController {
  String name = '';
  String email = '';
  String phone = '';
  String image = '';
  final firebaseInstance = FirebaseFirestore.instance;

  Map userProfileData = {
    'name': '',
    'email': '',
    'phone': '',
    'image': '',
    'dateOfJoining': '',
  };
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();

    getCurrentUserEmail();
    getUserProfileData();
    // getUserImage;
  }

  createUser(email, password, context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.pushReplacement(context,
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

  String? getEmail() {
    User? user = auth.currentUser;
    String? email = user?.email;
    return email;
  }

  String? getCurrentUserEmail() {
    User? currentUser = auth.currentUser;
    String? email = currentUser?.email;
    return email;
  }

  Future<void> getUserProfileData() async {
    try {
      var response = await firebaseInstance
          .collection('UserInfo')
          .where('email', isEqualTo: getCurrentUserEmail())
          .get();
      print(getEmail());
      print(getCurrentUserEmail());

      if (response.docs.length > 0) {
        userProfileData['name'] = response.docs[0]['name'];
        userProfileData['email'] = response.docs[0]['email'];
        userProfileData['phone'] = response.docs[0]['phone'];
        userProfileData['dateOfJoining'] =
            response.docs[0]['dateOfJoining'].toDate();
        userProfileData['image'] = response.docs[0]['image'];
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

/*
  Future<Stream<QuerySnapshot>> getUserImage() async {
    return FirebaseFirestore.instance
        .collection("UserInfo")
        .where("email", isEqualTo: getCurrentUserEmail())
        .snapshots();
  }
  */
  /*
  Future<String> get getUserImage async {
    var collection = FirebaseFirestore.instance.collection('UserInfo');
    var docSnapshot = await collection.doc(getCurrentUserEmail()).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = await data!['image']; // <-- The value you want to retrieve.
      // Call setState if needed.
      print("printing image value");
      print(value);
      return value;
    } else {
      return "No Image Found";
    }
  }
  */
}
