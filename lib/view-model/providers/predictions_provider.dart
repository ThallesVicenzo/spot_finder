import 'package:flutter/material.dart';
import 'package:spot_finder/model/models/predictions.dart';
import 'package:spot_finder/view-model/repository/places_repository.dart';

class PredictionsProvider with ChangeNotifier {
  final PlacesRepository _repository = PlacesRepository();
  List<PredictionsModel>? list = [];
  final _visibility = false;

  Future<void> showPredictions(String query) async {
    await _repository.defineUri(query).then(
      (value) {
        list = value;
        notifyListeners();
      },
    );
  }

  bool returnVisibility() {
    return list!.isEmpty ? _visibility : !_visibility;
  }

  void onClickVisibility() {
    list!.clear();
    notifyListeners();
  }
}
