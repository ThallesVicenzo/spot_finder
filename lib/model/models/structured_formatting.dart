class StructuredFormattingModel {
  final String? mainText;

  final String? secondaryText;

  StructuredFormattingModel({this.mainText, this.secondaryText});

  factory StructuredFormattingModel.fromJson(Map<String, dynamic> json) {
    return StructuredFormattingModel(
        mainText: json['main_text'] as String?,
        secondaryText: json['secondary_text'] as String?);
  }
}
