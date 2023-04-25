import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> getCollectionsSnapshot(
      String collection) {
    return instance.collection(collection);
  }
}
