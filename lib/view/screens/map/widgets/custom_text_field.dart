import 'package:flutter/material.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';
import 'package:spot_finder/view-model/shared/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.title, this.sufixIcon});

  final String title;
  final IconData? sufixIcon;

  @override
  Widget build(BuildContext context) {
    SaveSpotProvider textFieldProvider = SaveSpotProvider();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: textFieldProvider.textController,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: Theme.of(context).primaryTextTheme.bodySmall,
          suffixIcon: Icon(
            sufixIcon,
            color: Theme.of(context).primaryColor,
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
        onChanged: (value) {
          textFieldProvider.onChanged(value);
        },
      ),
    );
  }
}
