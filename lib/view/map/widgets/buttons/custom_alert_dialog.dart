import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.function});

  final String title;
  final Widget content;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).primaryTextTheme.bodyMedium,
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: function,
          child: Text(
            'Confirmar',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
