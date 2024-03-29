import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobs_app/constants/routes.dart';
import 'package:jobs_app/services/auth/auth_exceptions.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:jobs_app/services/db/db_exceptions.dart';
import 'package:jobs_app/services/db/db_service.dart';
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

                      if (user != null) {
                        try {
                          final Object docRef =
                              DbService.firestore().addUser('users');
                        } on AlreadyExistsFirestoreExcetions {
                          showErrDialog(
                              context, 'Dado já existente no Banco de Dados');
                        } on OperationCancelledFirestoreExceptions {
                          showErrDialog(context, 'Operação Cancelada');
                        } on DocNotFoundFirestoreExceptions {
                          showErrDialog(context, 'Dado não encontrado');
                        } on PermissionDeniedFirestoreExceptions {
                          showErrDialog(
                              context, 'Sem permissão para esse operação');
                        } on UnauthenticatedFirestoreExceptions {
                          showErrDialog(
                              context, 'Você não está autenticado no sistema');
                        } on UnavailableFirestoreExceptios {
                          showErrDialog(
                              context, 'Serviço temporariamente indisponível');
                        } catch (err) {
                          showErrDialog(context, 'Erro na operação');
                        }

                        if (user.isEmailVerified) {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(userRoute, (_) => false);
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

                    if (user != null) {
                      try {
                        final Object docRef =
                            DbService.firestore().addUser('users');
                      } on AlreadyExistsFirestoreExcetions {
                        showErrDialog(
                            context, 'Dado já existente no Banco de Dados');
                      } on OperationCancelledFirestoreExceptions {
                        showErrDialog(context, 'Operação Cancelada');
                      } on DocNotFoundFirestoreExceptions {
                        showErrDialog(context, 'Dado não encontrado');
                      } on PermissionDeniedFirestoreExceptions {
                        showErrDialog(
                            context, 'Sem permissão para esse operação');
                      } on UnauthenticatedFirestoreExceptions {
                        showErrDialog(
                            context, 'Você não está autenticado no sistema');
                      } on UnavailableFirestoreExceptios {
                        showErrDialog(
                            context, 'Serviço temporariamente indisponível');
                      } catch (err) {
                        showErrDialog(context, 'Erro na operação');
                      }

                      if (user.isEmailVerified) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(userRoute, (_) => false);
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
