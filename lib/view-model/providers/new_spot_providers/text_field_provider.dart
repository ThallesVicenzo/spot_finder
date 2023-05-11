import 'package:flutter/material.dart';
import 'package:spot_finder/view-model/repository/firebase_repository.dart';

class TextFieldProvider with ChangeNotifier {
  final textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  String? returnError;
  String? errorForUpdateCategory;

  void clearControllers() {
    returnError = null;
    errorForUpdateCategory = null;

    for (int i = 0; i < textEditingControllers.length; i++) {
      textEditingControllers[i].text = '';
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
      if (textEditingControllers[1].text.length > 10) {
        return 'Uma categoria não pode ter mais que 9 caracteres.';
      }
      if (textEditingControllers[3].text.length > 500) {
        return 'A descrição não pode ter mais do que 500 caractéres';
      }
    }

    return null;
  }

  Future<String?> returnErrorForUpdateCategory() async {
    String text = textEditingControllers[1].value.text;
    final result =
        await FirebaseRepository.validateNewCategory(text.toUpperCase());

    if (result.exists) {
      return 'Essa categoria já existe!';
    }
    if (text.length <= 2) {
      return 'Não pode ter menos que 3 caracteres.';
    }
    if (textEditingControllers[1].text.length > 10) {
      return 'Uma categoria não pode ter mais que 9 caracteres.';
    }

    return null;
  }

  void updateFieldValue(String value, int index) {
    textEditingControllers[index].text = value;
    notifyListeners();
  }

  void updateErrorText(String? text) {
    returnError = text;
    notifyListeners();
  }

  void updateReturnErrorForUpdateCategory(String? text) {
    errorForUpdateCategory = text;
    notifyListeners();
  }
}
