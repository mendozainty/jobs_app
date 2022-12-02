import 'package:flutter/material.dart';
import 'package:jobs_app/constants/routes.dart';
import 'package:jobs_app/services/auth/auth_services.dart';

import '../enums/menu_action.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  AppBarCustom(
    this.title, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(45.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.indigo.shade500,
      actions: [
        PopupMenuButton<MenuAction>(
          onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogoutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
                break;
              default:
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                  value: MenuAction.config, child: Text('Configurações')),
              PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text('Logout')),
            ];
          },
        )
      ],
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Tem certeza?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sair')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
