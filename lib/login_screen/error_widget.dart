import 'package:flutter/material.dart';

class LoginErrorDialog extends StatelessWidget {
  final String message ;

  const LoginErrorDialog({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Login Error'),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), 
        child: Text(" Ok !"))
      ],

    );
  }
}