import 'package:flutter/material.dart';
import 'package:spot_finder/model/models/categories.dart';
import 'package:spot_finder/view-model/repository/firebase_repository.dart';

class SaveSpotProvider with ChangeNotifier {
  TextEditingController textController = TextEditingController();
  Color currentColor = const Color(0xFFF40B0B);
  List<Categories> categoriesModel = [];
  bool isPressed = false;

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

  Future<void> getCategories() async {
    final response = FirebaseRepository.getCategoriesList();
    categoriesModel = await response;
    notifyListeners();
  }

  void changeCategorieButtonColor() {
    isPressed = !isPressed;
    notifyListeners();
  }
}
