import 'package:flutter/material.dart';
import 'package:spot_finder/view-model/providers/new_spot_providers/text_field_provider.dart';

import '../../../model/models/categories.dart';
import '../../repository/firebase_repository.dart';

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

  Future<void> updateCategories(
      TextFieldProvider textFieldProvider, context) async {
    await textFieldProvider.returnErrorForUpdateCategory().then((text) async {
      textFieldProvider.updateReturnErrorForUpdateCategory(text);
      if (text == null) {
        await FirebaseRepository.updateCategories(
          category: textFieldProvider.textEditingControllers[1].value.text,
          docName: textFieldProvider.textEditingControllers[1].value.text
              .toUpperCase(),
        ).then((_) {
          Navigator.pop(context);
        });
      }
    });
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
