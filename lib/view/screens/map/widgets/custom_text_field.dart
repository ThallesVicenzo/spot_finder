import 'package:flutter/material.dart';
import 'package:spot_finder/view-model/providers/custom_text_field_provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.title, this.sufixIcon});

  final String title;
  final IconData? sufixIcon;

  @override
  Widget build(BuildContext context) {
    TextFieldProvider textFieldProvider = TextFieldProvider();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: textFieldProvider.textController,
        decoration: InputDecoration(
          labelText: title,
          suffixIcon: Icon(
            sufixIcon,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
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
