import 'package:flutter/material.dart';
import 'package:jobs_app/constants/routes.dart';
import 'package:jobs_app/services/auth/auth_exceptions.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/constants/appBar_view.dart';

import '../utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBarCustom('Registre-se'),
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
                    .createUser(email: email, password: password);
                AuthService.firebase().sendEmailVerification();

                Navigator.of(context).pushNamed(verifyRoute);
                final currentUser = AuthService.firebase().currentUser;
                print(currentUser);
              } on WeakPasswordAuthException {
                await showErrDialog(context, 'Senha franca');
              } on EmailAlreadyInUseAuthException {
                await showErrDialog(context, 'Email já cadastrado');
              } on InvalidEmailAuthException {
                await showErrDialog(context, 'Email inválido');
              } on GenericAuthException {
                await showErrDialog(context, 'Problema de Autenticação');
              }
            },
            child: const Text('Registre'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Já se registrou? Faça o login aqui!'))
        ],
      ),
    );
  }
}
