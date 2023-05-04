import 'package:flutter/material.dart';

class TextFieldProvider with ChangeNotifier {
  final textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  String? returnError;

  void clearControllers() {
    for (int i = 0; i < textEditingControllers.length; i++) {
      textEditingControllers[i].clear();
    }
  }

  Future<String?> errorText() async {
    for (int i = 0; i < textEditingControllers.length; i++) {
      String text = textEditingControllers[i].value.text;
      if (text.isEmpty) {
        return 'Não pode ser vazio!';
      }
      if (text.length <= 2) {
        return 'Não pode ter menos que 3 caracteres.';
      }
      if (text.length > 10) {
        return 'Não pode ter mais que 9 caracteres.';
      }
    }

    return null;
  }

  void updateFieldValue(String value, int index) {
    textEditingControllers[index].text = value;
    notifyListeners();
  }
}
