import 'dart:convert';

import 'package:spot_finder/model/models/places.dart';

class PlacesAutoCompleteModel {
  final String? status;
  final List<PlacesModel>? predictions;

  PlacesAutoCompleteModel({this.status, this.predictions});

  factory PlacesAutoCompleteModel.fromJson(Map<String, dynamic> json) {
    return PlacesAutoCompleteModel(
        status: json['status'] as String?,
        predictions: List<PlacesModel>.from(
          json['predictions']?.map<PlacesModel>(
            (args) => PlacesModel.fromJson(args),
          ),
        ));
  }
  static PlacesAutoCompleteModel parseAutoCompleteModel(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlacesAutoCompleteModel.fromJson(parsed);
  }
}
