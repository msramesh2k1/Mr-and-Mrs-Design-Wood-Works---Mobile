import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_and_mrs/models/category_model.dart';

class DBService {
  Stream<List<CategoryModel>> getCategoryList() {
    return FirebaseFirestore.instance.collection('category').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => CategoryModel.fromJson(document.data()))
            .toList());
  }
}
