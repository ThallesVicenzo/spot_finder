import '../../model/models/categories.dart';
import '../../model/services/firebase_service.dart';

class FirebaseRepository {
  static int? collectionLength;

  static Future<List<CategoriesModel>> getCategoriesList() async {
    try {
      final data =
          await FirebaseService.getCollectionsSnapshot('Categories').get();
      return data.docs.map((docData) {
        return CategoriesModel.fromJson(docData);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
