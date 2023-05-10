import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final _instance = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> getCollectionsSnapshot(
      String collection) {
    return _instance.collection(collection);
  }

  static DocumentReference<Map<String, dynamic>> getDocumentReference(
      String collection, String doc) {
    return FirebaseService.getCollectionsSnapshot('Categories').doc(doc);
  }

  static Future<void> saveSpot(
    String collection,
    String docName,
    Map<String, dynamic> data,
  ) async {
    await getCollectionsSnapshot(collection).doc(docName).set(data);
  }

  static Future<void> newCategory(
    String docName,
    Map<String, dynamic> data,
  ) async {
    await getCollectionsSnapshot('Categories')
        .doc(docName.toUpperCase())
        .set(data);
  }
}
