import 'package:spot_finder/model/models/spots.dart';

import '../../model/models/categories.dart';
import '../../model/services/firebase_service.dart';

class FirebaseRepository {
  static int? collectionLength;

  static Future<List<CategoriesModel>> getCategoriesList() async {
    try {
      final data =
          await FirebaseService.getCollectionsSnapshot('Categories').get();
      return data.docs.map((docData) {
        return CategoriesModel.fromJson(
          docData.data(),
        );
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<TouristSpotModel>>? getTouristSpotsDocuments() async {
    try {
      final data =
          await FirebaseService.getCollectionsSnapshot('TouristSpot').get();
      return data.docs
          .map((docData) => TouristSpotModel.fromJson(
                docData.data(),
              ))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> callSavePlace(
      {required String collection,
      required String docName,
      required String title,
      required String location,
      required String description,
      required String category,
      required String mainPicture,
      required String pinColor}) async {
    try {
      Map<String, dynamic> data = TouristSpotModel(
        title: title,
        location: location,
        description: description,
        category: category,
        mainPicture: mainPicture,
        pinColor: pinColor,
      ).toJson();

      await FirebaseService.saveSpot(collection, docName, data);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> updateCategories({
    required String category,
    required String docName,
  }) async {
    try {
      Map<String, dynamic> data =
          CategoriesModel(categories: category.toUpperCase()).toJson();

      await FirebaseService.newCategory(docName, data);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String>? validateNewCategory(String category) async {
    return FirebaseService.getCollectionsSnapshot('Categories')
        .where(category, isEqualTo: category)
        .get()
        .toString();
  }
}
