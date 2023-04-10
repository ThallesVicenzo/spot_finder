import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    super.key,
    required this.icon,
    required this.style,
    required this.function,
    required this.title,
    this.backGroundColor = Colors.transparent,
  });

  final String icon;
  final TextStyle? style;
  final Color backGroundColor;
  final Function() function;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  icon,
                  scale: 4,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
