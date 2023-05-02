import 'package:flutter/material.dart';
import 'package:spot_finder/shared/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.value,
    required this.controller,
    this.onTap,
    this.sufixIcon,
    this.iconColor = const Color(0xFFF44336),
    this.readOnly = false,
    this.errorText,
    this.onChanged,
    this.action = TextInputAction.done,
  });

  final String title;
  final String value;
  final TextEditingController? controller;
  final String? errorText;
  final IconData? sufixIcon;
  final Color iconColor;
  final VoidCallback? onTap;
  final VoidCallback? onChanged;
  final bool readOnly;
  final TextInputAction action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
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
        onChanged: (value) {
          onChanged;
        },
      ),
    );
  }
}
