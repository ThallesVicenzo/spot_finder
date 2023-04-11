import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.title, required this.function});

  final String title;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: function,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodySmall!
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
