import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ManageData extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future fetchData(String collection) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(collection).
        get();
    return querySnapshot.docs;
  }
 
  // Future UsersFavData(BuildContext context,String collection) async {
  //   QuerySnapshot querySnapshot = await firebaseFirestore
  //       .collection(collection)
  //       .doc(Provider.of<Authentication>(context, listen: false)
  //           .firebaseAuth
  //           .currentUser
  //           .uid).collection("FavItems")
  //       .get();
  //   return querySnapshot.docs;
  // }

  // Future submitData(BuildContext context, dynamic data) async {
  //   return FirebaseFirestore.instance
  //       .collection("MyOrders")
  //       .doc(Provider.of<Authentication>(context, listen: false)
  //           .firebaseAuth
  //           .currentUser
  //           .uid)
  //       .set(data);
  // }

  // Future favData(BuildContext context, dynamic data) async {
  //   return Pizzazo.firestore
  //       .collection("Users")
  //       .doc(Provider.of<Authentication>(context, listen: false)
  //           .firebaseAuth
  //           .currentUser
  //           .uid)
  //       .collection("FavItems")
  //       .add(data);
//  }



  // Future getSearchData(String queryString) async {
  //   return Pizzazo.firestore
  //       .collection("burger")
  //       .where('name', isGreaterThanOrEqualTo: queryString)
  //       .get();
  // }
}
