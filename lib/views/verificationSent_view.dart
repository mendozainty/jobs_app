import 'package:flutter/material.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/constants/appBar_view.dart';

import '../constants/routes.dart';

class VerificationSent extends StatelessWidget {
  const VerificationSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Home'),
      body: AlertDialog(
        title: const Center(child: Text('Email enviado.')),
        content: const Text(
            'Verifique sua caixa de entrada (ou spam) e clique no link de verificação.'),
        actions: [
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  homeRoute,
                  (_) => false,
                );
              },
              child: const Text('Já fiz a verificação pelo link'))
        ],
      ),
    );
  }
}
