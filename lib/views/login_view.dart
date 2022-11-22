import 'package:flutter/material.dart';
import 'package:jobs_app/constants/routes.dart';
import 'package:jobs_app/services/auth/auth_exceptions.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
                  .pushNamedAndRemoveUntil(loginEmailRoute, (_) => false);
            }),
            SignInButton(Buttons.Google, onPressed: () async {
              try {
                final credential =
                    await AuthService.firebase().signInGoogle(context: context);
                if (credential != null) {
                  try {
                    await AuthService.firebase()
                        .sigInCredential(credential)
                        .then((value) {
                      final user = AuthService.firebase().currentUser;
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
              final credential =
                  await AuthService.firebase().signInFB(context: context);
              if (credential != null) {
                try {
                  await AuthService.firebase()
                      .sigInCredential(credential)
                      .then((value) {
                    final user = AuthService.firebase().currentUser;
                    if (user != null) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(jobsRoute, (_) => false);
                    } else {
                      throw GenericAuthException();
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
