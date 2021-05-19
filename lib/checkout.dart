// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'Helper.dart';

// class checkout extends StatefulWidget {
//   @override
//   _checkoutState createState() => _checkoutState();
// }

// class _checkoutState extends State<checkout> {
//   var currentStep = 0;
//   int totalAmount = 0;
//   int quanity = 1;
//   int cartno = 0;
//   int addressno = 0;
//   int cartvalueno() {
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("cart")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         cartno = querySnapshot.docs.length;
//       });
//     });
//      return cartno;
//   }

//  int addressvalueno() {
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("address")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         addressno = querySnapshot.docs.length;
//       });
//     });
//     return addressno;
//   }
 
//   @override
//   void initState() {
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("address")
//         .snapshots();
//     // TODO: implement initState

//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("address")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         addressno = querySnapshot.docs.length;
//       });
//     });
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("cart")
//         .snapshots();
//     // TODO: implement initState
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("cart")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         cartno = querySnapshot.docs.length;
//       });
//     });
   

//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("cart")
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         setState(() {
//           MRANDMRS.sharedprefs
//               .setInt(element.data()['id'], element.data()['quanity']);
//           totalAmount =
//               totalAmount + element.data()["price"] * element.data()['quanity'];
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
