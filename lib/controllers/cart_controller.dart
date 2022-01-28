import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mr_and_mrs/Helper.dart';

class CartController extends ChangeNotifier {
  int _cartvalue = 0;
  int get cartvalue => _cartvalue;

  void cartvaluefinder() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot);
      _cartvalue = querySnapshot.docs.length;
      print(_cartvalue);
      notifyListeners();
    });
  }
}
