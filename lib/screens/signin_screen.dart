import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/reusable_widgets/reusable_widget.dart';
import 'package:flutter_catalog/screens/forgot_password.dart';

import 'package:flutter_catalog/screens/profile_screen.dart';
import 'package:flutter_catalog/screens/signup_screen.dart';
import 'package:flutter_catalog/screens/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../utils/helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/color_utils.dart';
import 'insta_ui.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Service service = Service();

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo1.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Your Email", Icons.person_outline,
                    false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Your Password", Icons.person_outline,
                    true, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () async {
                  var sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool(SplashScreenState.keyLogin, true);

                  if (_emailTextController.text.isNotEmpty &&
                      _passwordTextController.text.isNotEmpty) {
                    service.loginUser(_emailTextController.text,
                        _passwordTextController.text, context);
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      service.getCurrentUserEmail();
                      print("current user email");
                      print(service.getCurrentUserEmail());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    });
                  } else {
                    service.error(context, "Field must not be empty");
                  }
                }),
                signUpOption(),
                forgetPass(),
                MaterialButton(
                  onPressed: () {
                    _googleSignIn.signIn().then((value) {
                      String name = value!.displayName!;
                      String image = value!.photoUrl!;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    });
                  },
                  color: Colors.blueAccent,
                  height: 50,
                  child: const Text(
                    'Google SignIn',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't Have Account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row forgetPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Forget Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen()));
          },
          child: const Text(
            "??",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
