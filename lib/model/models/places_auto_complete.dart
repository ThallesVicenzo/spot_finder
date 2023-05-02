import 'dart:convert';

class PlacesAutoCompleteModel {
  final String? status;
  final List<PlaceModel>? predictions;

  PlacesAutoCompleteModel({this.status, this.predictions});

  factory PlacesAutoCompleteModel.fromJson(Map<String, dynamic> json) {
    return PlacesAutoCompleteModel(
        status: json['status'] as String?,
        predictions: json['predictions'] != null
            ? json['predictions']
                .map<PlacesModel>((json) => PlacesModel.fromJson(json).toList())
            : null);
  }
  static PlacesAutoCompleteModel placesAutoCompleteModel(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlacesAutoCompleteModel.fromJson(parsed);
  }
}
