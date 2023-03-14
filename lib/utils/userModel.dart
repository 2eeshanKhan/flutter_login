import 'package:firebase_auth/firebase_auth.dart';

class UserDetail {
  final String name;
  final String email;
  final String phone;
  final String image;

  UserDetail({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });
}
