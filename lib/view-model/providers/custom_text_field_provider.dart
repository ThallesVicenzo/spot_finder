import 'package:flutter/material.dart';

class TextFieldProvider with ChangeNotifier {
  TextEditingController textController = TextEditingController();

  void onChanged(String value) {
    value = textController.text;
    notifyListeners();
  }
}
