import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_catalog/screens/signin_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_catalog/utils/helper.dart';
import 'package:flutter_catalog/utils/userModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Service service = Get.put(Service());

  Service controller = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color(0xFF26CBE6),
              const Color(0xFF26CBC0),
            ], begin: Alignment.topCenter, end: Alignment.center)),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: _height / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //     Image.network(
                          //       "${controller.userProfileData['image']}"),
                          CircleAvatar(
                              /*                     backgroundImage: new AssetImage(
                                controller.userProfileData['image']),
                            radius: _height / 10,
                            */
                              /* backgroundImage: NetworkImage(
                              '${controller.userProfileData['image']}',
                            ),
                            radius: _height / 10,
                            */
                              ),
                          SizedBox(
                            height: _height / 30,
                          ),
                          Text(
                            'Welcome ${controller.userProfileData['name']}',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _height / 2.2),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height / 2.6,
                        left: _width / 20,
                        right: _width / 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 2.0,
                                    offset: Offset(0.0, 2.0))
                              ]),
                          child: Padding(
                            padding: EdgeInsets.all(_width / 20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  headerChild('Photos', 1),
                                  headerChild('Followers', 0),
                                  headerChild('Following', 0),
                                ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _height / 20),
                          child: Column(
                            children: <Widget>[
                              infoChild(_width, Icons.email,
                                  '${controller.userProfileData['email']}'),
                              infoChild(_width, Icons.call,
                                  '${controller.userProfileData['phone']}'),
                              Padding(
                                padding: EdgeInsets.only(top: _height / 30),
                                child: Container(
                                  width: _width / 3,
                                  height: _height / 20,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF26CBE6),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_height / 40)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black87,
                                            blurRadius: 2.0,
                                            offset: Offset(0.0, 1.0))
                                      ]),
                                  child: Center(
                                    /*
                                    child: Text('Signout',
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                            */
                                    child: ElevatedButton(
                                      child: const Text(
                                        'Logout',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        _auth.signOut().then((value) => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignInScreen()))
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerChild(String header, int value) => new Expanded(
          child: Column(
        children: <Widget>[
          Text(header),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$value',
            style: TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF26CBE6),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width / 10,
              ),
              Icon(
                icon,
                color: const Color(0xFF26CBE6),
                size: 36.0,
              ),
              SizedBox(
                width: width / 20,
              ),
              Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}
