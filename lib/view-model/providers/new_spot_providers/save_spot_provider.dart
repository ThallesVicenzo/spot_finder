import 'package:flutter/material.dart';
import 'package:spot_finder/view-model/providers/new_spot_providers/text_field_provider.dart';

class SaveSpotProvider with ChangeNotifier {
  String placeName = '';
  String category = '';
  String address = '';
  String markerColor = '';

  void validation(
      {required SaveSpotProvider saveSpotProvider,
      required TextFieldProvider textFieldProvider,
      context,
      required Widget widget}) {
    textFieldProvider.errorText().then((text) {
      textFieldProvider.updateErrorText(text);

      if (text == null) {
        saveSpotProvider.savePlace();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return widget;
            });
      } else {
        notifyListeners();
      }
    });
  }

  Future<void> savePlace() async {
    print('viiiiixe');
  }
}
