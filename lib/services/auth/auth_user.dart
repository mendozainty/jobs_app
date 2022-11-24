import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? phoneNumber;
  final bool isEmailVerified;
  final String? uid;

  const AuthUser(
    this.displayName,
    this.isEmailVerified,
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
