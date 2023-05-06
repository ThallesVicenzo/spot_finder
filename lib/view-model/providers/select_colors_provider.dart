import 'package:flutter/material.dart';

class SelectColorsProvider with ChangeNotifier {
  Color currentColor = const Color(0xFFF40B0B);

  void selectColor(Color selectedColor) {
    currentColor = selectedColor;
    notifyListeners();
  }
}
