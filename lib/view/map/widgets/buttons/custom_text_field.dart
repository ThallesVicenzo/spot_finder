import 'package:flutter/material.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';
import 'package:spot_finder/shared/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.onTap,
    this.sufixIcon,
    this.iconColor = const Color(0xFFF44336),
    this.readOnly = false,
  });

  final String title;
  final IconData? sufixIcon;
  final Color iconColor;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    SaveSpotProvider provider = SaveSpotProvider();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: provider.textController,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: Theme.of(context).primaryTextTheme.bodySmall,
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
          provider.onChanged(value);
        },
      ),
    );
  }
}
