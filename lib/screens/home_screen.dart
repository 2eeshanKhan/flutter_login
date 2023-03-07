import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_catalog/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Log Out"),
          onPressed: () {
            /*  FirebaseAuth.instance.signOut().then((value) => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()))
                });
                */
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
