import 'package:flutter/material.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/constants/appBar_view.dart';

import '../constants/routes.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Verificação de email'),
      body: AlertDialog(
        title: const Center(child: Text('Email não verificado')),
        content: const Text(
            'Um email de verificação foi enviado para seu email (pode estar na caixa de spam). Quer enviar o link de verificação novamente?'),
        actions: [
          Center(
            child: TextButton(
                onPressed: () async {
                  await AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifEmailSentRoute,
                    (_) => false,
                  );
                },
                child: const Text('Enviar email de verificação novamente')),
          ),
          Center(
            child: TextButton(
                onPressed: () async {
                  await AuthService.firebase().logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    userRoute,
                    (_) => false,
                  );
                },
                child: const Text('Já fiz a verificação pelo link')),
          )
        ],
      ),
    );
  }
}
