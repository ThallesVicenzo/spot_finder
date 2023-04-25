import '../../model/models/categories.dart';
import '../../model/services/firebase_service.dart';

class FirebaseRepository {
  static int? collectionLength;

  static Future<List<Categories>> getCategoriesList() async {
    try {
      final data =
          await FirebaseService.getCollectionsSnapshot('Categories').get();
      return data.docs.map((docData) {
        return Categories.fromJson(docData);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
