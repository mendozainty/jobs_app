import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<GoogleSignInAccount?> logInGoogle({required BuildContext context});
  Future<AuthCredential?> oAuthGoogle(googleSignInAccount);
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<void> initilize();
  Future<AuthCredential?> oAuthFB(token);
  Future<FacebookAccessToken?> logInFB({required BuildContext context});
}
