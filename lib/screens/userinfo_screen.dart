import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_catalog/screens/signin_screen.dart';
import 'package:flutter_catalog/screens/signup_screen.dart';
import 'package:flutter_catalog/utils/helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  Service service = Service();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';
  String image = '';

  File? pickedImage;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final fireStore = FirebaseFirestore.instance.collection('UserInfo');
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('UserInfo');

  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
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
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.indigo, width: 5),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: ClipOval(
                                  child: pickedImage != null
                                      ? Image.file(
                                          pickedImage!,
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/profilepic.png",
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Your Name", Icons.person_outline,
                        false, _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Enter Your Phone Number",
                        Icons.phone_android_outlined,
                        false,
                        _phoneTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            imagePickerOption();
                          },
                          icon: const Icon(Icons.add_a_photo_sharp),
                          label: const Text('UPLOAD PHOTO')),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String id = DateTime.now().millisecond.toString();

                        firebase_storage.Reference ref = firebase_storage
                            .FirebaseStorage.instance
                            .ref('UserInfo' +
                                DateTime.now().millisecond.toString());

                        firebase_storage.UploadTask uploadTask =
                            ref.putFile(pickedImage!.absolute);

                        var newUrl =
                            await (await uploadTask).ref.getDownloadURL();

                        String? uniqueId = service.getEmail();

                        await fireStore.doc(uniqueId).set({
                          'uniqueId': service.getEmail(),
                          'name': _userNameTextController.text.toString(),
                          'phone': _phoneTextController.text.toString(),
                          'email': service.getEmail(),
                          'dateOfJoining':
                              DateTime.now().millisecond.toString(),
                          'image ': newUrl.toString()
                        }).then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        }).onError((error, stackTrace) {
                          service.error(context, error);
                        });
                      },
                      child: Text(
                        ' SUBMIT ',
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
