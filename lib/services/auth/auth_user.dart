import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/services/auth/firebase_auth_provider.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? uid;

  const AuthUser(this.name, this.isEmailVerified, this.email, this.phone,
      this.photoUrl, this.uid);

  factory AuthUser.fromFirebase(User user) => AuthUser(
      user.displayName,
      user.emailVerified,
      user.email,
      user.phoneNumber,
      user.photoURL,
      user.uid);
}
