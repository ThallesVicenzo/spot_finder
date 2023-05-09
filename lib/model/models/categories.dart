class CategoriesModel {
  const CategoriesModel({required this.categories});
  final String categories;

  factory CategoriesModel.fromJson(
    Map<String, dynamic> map,
  ) =>
      CategoriesModel(categories: map['Categoria']);

  Map<String, dynamic> toJson() => {
        'Categoria': categories,
      };
}
