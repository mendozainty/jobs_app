import 'package:flutter/material.dart';
import 'package:jobs_app/constants/appBar_view.dart';
import '../constants/routes.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_services.dart';
import '../services/db/db_exceptions.dart';
import '../services/db/db_service.dart';
import '../utilities/show_error_dialog.dart';

class LoginEmailView extends StatefulWidget {
  const LoginEmailView({super.key});

  @override
  State<LoginEmailView> createState() => _LoginEmailViewState();
}

class _LoginEmailViewState extends State<LoginEmailView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom('Login Email'),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Entre seu email'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Entre sua senha'),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase()
                      .logIn(email: email, password: password)
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
                  await showErrDialog(
                      context, 'Usuário não cadastrado ou deletado');
                } on WrongPasswordAuthException {
                  await showErrDialog(context,
                      'Senha incorreta ou usuário sem senha. Você já é cadastrado?');
                } on GenericAuthException {
                  await showErrDialog(context, 'Erro de Autenticação');
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: const Text('Não registrado ainda? Registre-se aqui!')),
          ],
        ));
  }
}
