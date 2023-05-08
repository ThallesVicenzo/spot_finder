class PredictionsModel {
  final String? description;
  final String? reference;

  PredictionsModel({this.reference, this.description});

  factory PredictionsModel.fromJson(Map<String, dynamic> json) {
    return PredictionsModel(
      description: json['description'] as String?,
      reference: json['reference'] as String?,
    );
  }
  @override
  String toString() {
    return '$description, $reference';
  }
}
