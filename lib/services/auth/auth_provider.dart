import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<AuthUser> sigInCredential(userCredential);
  Future<AuthCredential?> signInGoogle({required BuildContext context});
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<void> initilize();
  Future<AuthCredential?> signInFB({required BuildContext context});
}
