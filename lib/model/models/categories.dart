import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  const Categories({required this.categories});
  final String categories;

  factory Categories.fromJson(
    DocumentSnapshot<Map<String, dynamic>> map,
  ) =>
      Categories(categories: map['Categoria']);
}
