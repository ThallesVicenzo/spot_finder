import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton(
      {super.key,
      required this.title,
      required this.function,
      required this.fontSize});

  final String title;
  final Function() function;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: function,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.82,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                      fontSize: fontSize,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
