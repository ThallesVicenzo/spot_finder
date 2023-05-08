import 'dart:convert';

import 'package:spot_finder/model/models/predictions.dart';

class PlacesAutoCompleteModel {
  final String? status;
  final List<PredictionsModel>? predictions;

  PlacesAutoCompleteModel({this.status, this.predictions});

  factory PlacesAutoCompleteModel.fromJson(Map<String, dynamic> json) {
    return PlacesAutoCompleteModel(
        status: json['status'] as String?,
        predictions: List<PredictionsModel>.from(
          json['predictions']?.map<PredictionsModel>(
            (args) => PredictionsModel.fromJson(args),
          ),
        ));
  }
  static PlacesAutoCompleteModel parseAutoCompleteModel(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlacesAutoCompleteModel.fromJson(parsed);
  }
}
