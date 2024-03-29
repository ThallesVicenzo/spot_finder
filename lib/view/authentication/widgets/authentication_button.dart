import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    super.key,
    required this.icon,
    required this.style,
    required this.function,
    required this.title,
    this.backGroundColor = Colors.transparent,
    this.disable = false,
  });

  final String icon;
  final TextStyle? style;
  final Color backGroundColor;
  final Function() function;
  final String title;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disable,
      child: TextButton(
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
            padding: const EdgeInsets.only(left: 8),
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Text(
                      title,
                      style: style,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
