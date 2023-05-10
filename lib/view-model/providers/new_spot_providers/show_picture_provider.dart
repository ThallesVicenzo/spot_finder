import 'package:flutter/material.dart';

class ShowPictureProvider with ChangeNotifier {
  ImageProvider<Object>? picture;
  bool isPictureTaken = false;
  @override
  void notifyListeners() {
    picture;
    isPictureTaken;
    super.notifyListeners();
  }
}
