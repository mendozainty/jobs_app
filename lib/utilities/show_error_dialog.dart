import 'package:flutter/material.dart';

Future<void> showErrDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("Ocorreu um erro..."),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: const Text("OK"))
          ],
        );
      }));
}
