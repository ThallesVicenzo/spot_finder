import 'package:spot_finder/model/models/structured_formatting.dart';

class PlacesModel {
  final String? description;
  final StructuredFormattingModel? structuredFormating;
  final String? placeId;
  final String? reference;

  PlacesModel(
      {this.structuredFormating,
      this.placeId,
      this.reference,
      this.description});

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormating: json['strutured_formatting'] != null
          ? StructuredFormattingModel.fromJson(json['strutured_formatting'])
          : null,
    );
  }
}
