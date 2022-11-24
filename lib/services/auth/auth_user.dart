import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthUser {
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? phoneNumber;
  late bool? emailVerified;
  final String? uid;

  AuthUser(
    this.displayName,
    this.emailVerified,
    this.email,
    this.photoURL,
    this.phoneNumber,
    this.uid,
  );

  factory AuthUser.fromFirebase(User user) => AuthUser(
        user.displayName,
        user.emailVerified,
        user.photoURL,
        user.phoneNumber,
        user.email,
        user.uid,
      );
}
