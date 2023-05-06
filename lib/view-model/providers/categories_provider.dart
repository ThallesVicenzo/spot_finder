import 'package:flutter/material.dart';

import '../../model/models/categories.dart';
import '../repository/firebase_repository.dart';

class CategoriesProvider with ChangeNotifier {
  List<CategoriesModel> categoriesModel = [];

  int pressedIndex = -1;

  late List<bool> categoriesBoolList =
      categoriesModel.map((e) => false).toList();

  Future<void> getCategories() async {
    final response = FirebaseRepository.getCategoriesList();
    categoriesModel = await response;
    notifyListeners();
  }

  void onCategoryButtonTap(index) {
    pressedIndex = index;
    notifyListeners();
  }

  Color changeCategorieButtonColor(context, int index) {
    final isPressed = pressedIndex == index;
    if (!isPressed) {
      return Theme.of(context).primaryColor;
    } else {
      return Theme.of(context).focusColor;
    }
  }
}
