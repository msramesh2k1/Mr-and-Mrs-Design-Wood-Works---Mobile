import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_and_mrs/models/category_model.dart';
import 'package:mr_and_mrs/models/product_model.dart';

class DBService {
  Stream<List<CategoryModel>> getCategoryList() {
    return FirebaseFirestore.instance.collection('rooms').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => CategoryModel.fromJson(document.data()))
            .toList());
  }

  Stream<List<ProductModel>> getProductList() {
    return FirebaseFirestore.instance.collection('products').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => ProductModel.fromJson(document.data()))
            .toList());
  }
}
