import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  const CategoriesModel({required this.categories});
  final String categories;

  factory CategoriesModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> map,
  ) =>
      CategoriesModel(categories: map['Categoria']);
}
