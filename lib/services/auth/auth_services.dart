import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/services/auth/auth_provider.dart';
import 'package:jobs_app/services/auth/auth_user.dart';
import 'package:jobs_app/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(
        FirebaseAuthProvider(),
      );

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initilize() => provider.initilize();

  @override
  Future<AuthUser> sigInCredential(userCredential) =>
      provider.sigInCredential(userCredential);

  @override
  Future<AuthCredential?> signInGoogle({required BuildContext context}) =>
      provider.signInGoogle(context: context);

  @override
  Future<AuthCredential?> signInFB({required BuildContext context}) =>
      provider.signInFB(context: context);
}
