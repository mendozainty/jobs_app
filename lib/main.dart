import 'package:flutter/material.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/views/jobs_view.dart';
import 'package:jobs_app/views/login_email.dart';
import 'package:jobs_app/views/login_view.dart';
import 'package:jobs_app/views/register_view.dart';
import 'package:jobs_app/views/user_view.dart';
import 'package:jobs_app/views/verificationSent_view.dart';
import 'package:jobs_app/views/verifyEmail_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo.shade400,
        primarySwatch: Colors.blue,
        fontFamily: 'Mukta',
        textTheme: GoogleFonts.muktaTextTheme(),
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyRoute: (context) => const VerifyEmailView(),
        jobsRoute: (context) => const Jobs(),
        homeRoute: (context) => const HomePage(),
        verifEmailSentRoute: (context) => const VerificationSent(),
        loginEmailRoute: (context) => const LoginEmailView(),
        userRoute: (context) => const UserView(),
      }));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthService.firebase().initilize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const UserView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
