import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobs_app/constants/routes.dart';
import 'package:jobs_app/services/auth/auth_exceptions.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:jobs_app/services/db/db_service.dart';
import 'package:jobs_app/services/db/user_schema.dart';
import '../utilities/show_error_dialog.dart';
import '../constants/appBar_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Login'),
      body: Center(
        child: Column(
          children: [
            SignInButton(Buttons.Email, onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (_) => false);
            }),
            SignInButton(Buttons.Google, onPressed: () async {
              // TODO implement android settings
              try {
                final GoogleSignInAccount? googleSignInAccount =
                    await AuthService.firebase().logInGoogle(context: context);
                final credential = await AuthService.firebase()
                    .oAuthGoogle(googleSignInAccount);
                if (credential != null) {
                  try {
                    await AuthService.firebase()
                        .sigInCredential(credential)
                        .then((value) {
                      final user = AuthService.firebase().currentUser;
                      DbService.firestore().initializeDb();
                      final dbUser = DbUser(
                          uid: user?.uid,
                          name: user?.displayName,
                          email: user?.email,
                          phone: user?.phoneNumber,
                          photoUrl: user?.photoURL);
                      try {
                        final docRef =
                            DbService.firestore().addUser('users', dbUser);
                        if (docRef != null) {
                          return docRef;
                        } else {
                          return null;
                        }
                      } catch (e) {
                        print(e);
                      }

                      if (user != null) {
                        if (user.isEmailVerified) {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(jobsRoute, (_) => false);
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyRoute, (_) => false);
                        }
                      }
                    });
                  } on UserNotFoundAuthException {
                    // ignore: use_build_context_synchronously
                    await showErrDialog(
                        context, 'Usuário não cadastrado ou deletado');
                  } on WrongPasswordAuthException {
                    // ignore: use_build_context_synchronously
                    await showErrDialog(context,
                        'Senha incorreta ou usuário sem senha. Você já é cadastrado?');
                  } on GenericAuthException {
                    // ignore: use_build_context_synchronously
                    await showErrDialog(context, 'Erro de Autenticação');
                  }
                }
              } catch (e) {
                showErrDialog(context, 'Erro de Autenticação');
              }
            }),
            // SignInButton(Buttons.Apple, onPressed: () {}),
            SignInButton(Buttons.Facebook, onPressed: () async {
              // TODO implement android settings
              final token =
                  await AuthService.firebase().logInFB(context: context);
              final credential =
                  await AuthService.firebase().oAuthFB(token?.token);
              if (credential != null) {
                try {
                  await AuthService.firebase()
                      .sigInCredential(credential)
                      .then((value) {
                    final user = AuthService.firebase().currentUser;
                    AuthService.firebase().sendEmailVerification();

                    if (user != null) {
                      if (user.isEmailVerified) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(jobsRoute, (_) => false);
                      } else {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(verifyRoute, (_) => false);
                      }
                    }
                  });
                } on UserNotFoundAuthException {
                  // ignore: use_build_context_synchronously
                  await showErrDialog(
                      context, 'Usuário não cadastrado ou deletado');
                } on WrongPasswordAuthException {
                  // ignore: use_build_context_synchronously
                  await showErrDialog(context,
                      'Senha incorreta ou usuário sem senha. Você já é cadastrado?');
                } on GenericAuthException {
                  // ignore: use_build_context_synchronously
                  await showErrDialog(context, 'Erro de Autenticação');
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  await showErrDialog(context, 'Erro de Autenticação');
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
