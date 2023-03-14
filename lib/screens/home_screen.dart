import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/screens/signin_screen.dart';
import 'package:flutter_catalog/utils/helper.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Service service = Get.put(Service());
  Service controller = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Log Out"),
          onPressed: () {
            _auth.signOut().then((value) => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()))
                });
          },
        ),
      ),
    );
  }
}
