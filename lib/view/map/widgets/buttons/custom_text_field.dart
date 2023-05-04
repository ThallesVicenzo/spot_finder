import 'package:flutter/material.dart';
import 'package:spot_finder/shared/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.onChangedValue,
    required this.controller,
    this.onTap,
    this.sufixIcon,
    this.iconColor = const Color(0xFFF44336),
    this.readOnly = false,
    this.errorText,
    this.action = TextInputAction.done,
  });

  final String title;
  final String onChangedValue;
  final TextEditingController? controller;
  final String? errorText;
  final IconData? sufixIcon;
  final Color iconColor;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextInputAction action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        textInputAction: action,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: Theme.of(context).primaryTextTheme.bodySmall,
          errorText: errorText,
          suffixIcon: Icon(
            sufixIcon,
            color: iconColor,
            size: 30,
          ),
          border: kInputBorder.copyWith(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: kInputBorder.copyWith(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
