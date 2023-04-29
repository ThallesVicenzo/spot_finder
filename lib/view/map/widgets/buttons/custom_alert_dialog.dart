import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.function});

  final String title;
  final Widget? content;
  final VoidCallback function;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: Theme.of(context).primaryTextTheme.bodyMedium,
      ),
      content: widget.content,
      actions: [
        TextButton(
          onPressed: widget.function,
          child: Text(
            'Confirmar',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
