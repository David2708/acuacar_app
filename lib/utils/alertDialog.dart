import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Resultado de la petición"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
