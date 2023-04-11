import 'package:flutter/material.dart';

class SaveSpotProvider with ChangeNotifier {
  TextEditingController textController = TextEditingController();

  void onChanged(String value) {
    value = textController.text;
    notifyListeners();
  }
}
