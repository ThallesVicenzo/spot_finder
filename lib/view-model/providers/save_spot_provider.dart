import 'package:flutter/material.dart';

class SaveSpotProvider with ChangeNotifier {
  TextEditingController textController = TextEditingController();
  Color currentColor = const Color(0xFFF40B0B);

  Future<String?> errorText() async {
    final text = textController.value.text;
    if (text.isEmpty) {
      return 'Não pode ser vazio!';
    }
    if (text.length <= 2) {
      return 'Não pode ter menos que 3 caracteres.';
    }
    notifyListeners();

    return null;
  }

  void onChanged(String value) {
    value = textController.text;
    notifyListeners();
  }

  void selectColor(Color selectedColor) {
    currentColor = selectedColor;
    notifyListeners();
  }
}
