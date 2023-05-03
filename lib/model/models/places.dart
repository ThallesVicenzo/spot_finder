class PlacesModel {
  final String? description;
  final String? reference;

  PlacesModel({this.reference, this.description});

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      description: json['description'] as String?,
      reference: json['reference'] as String?,
    );
  }
  @override
  String toString() {
    return '$description, $reference';
  }
}
