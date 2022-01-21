// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mr_and_mrs/DetailedScreen.dart';
// import 'package:mr_and_mrs/Helper.dart';
// import 'package:mr_and_mrs/HomScreen.dart';
// import 'package:mr_and_mrs/constants.dart';

// import 'Address.dart';

// class Orders extends StatefulWidget {
//   //final int Ordersno;

//   const Orders({Key key,}) : super(key: key);

//   @override
//   _OrdersState createState() => _OrdersState();
// }

// class _OrdersState extends State<Orders> {
//   int totalAmount = 0;
//   int quanity = 1;
//   int Ordersno = 0;

//   int Ordersvalueno() {
//     FirebaseFirestore.instance
//         .collection("orders")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("items")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         Ordersno = querySnapshot.docs.length;
//       });
//     });
//     return Ordersno;
//   }

//   @override
//   void initState() {
//     FirebaseFirestore.instance
//                                 .collection("orders")
//                                 .doc(MRANDMRS.sharedprefs.getString("uid"))
//                                 .collection("items")
//                                 .snapshots();
//     // TODO: implement initState
//     super.initState();
//       FirebaseFirestore.instance
//         .collection("orders")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("items")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         Ordersno = querySnapshot.docs.length;
//       });});
//     FirebaseFirestore.instance
//         .collection("orders")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("items")
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {

//         setState(() {
//           MRANDMRS.sharedprefs.setInt(element.data()['id'], element.data()['quanity']);
//           totalAmount = totalAmount + element.data()["price"] * element.data()['quanity'];
//         });
//       });
//     });

//   }

//   @override
//   Widget build(BuildContext context) {
//         return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_ios_sharp,
//                   color: Colors.white, size: 12)),
//           leadingWidth: 25,
//           title: Text(
//             "Orders",
//         style: GoogleFonts.josefinSans(
//               textStyle: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                   fontSize: 18,
//                   letterSpacing: 1),
//             ),
//           ),
//           backgroundColor: kBackgroundColor,
//         ),

//         floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
//         floatingActionButton: FloatingActionButton.extended(

//           onPressed: () {
//             Ordersno == 0 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
//               return HomeScreen();
//             })) :Navigator.push(context, MaterialPageRoute(builder: (c){
//               return Address(

//                 // FirebaseFirestore.instance
//                 //                 .collection("users")
//                 //                 .doc(MRANDMRS.sharedprefs.getString("uid"))
//                 //                 .collection("cart")
//                 //                 .snapshots() ,
//                ////////////////// totalAmount: totalAmount.toDouble()
//                 );
//             }));

//           },

//           label:
//           Ordersno == 0?  Text(
//                                     "Countiue Shopping",
//                                     style: GoogleFonts.josefinSans(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                           fontSize: 13,
//                                           letterSpacing: 1),
//                                     ),
//                                   ):Text(
//                                 "Place Order",
//                                     style: GoogleFonts.josefinSans(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                           fontSize: 13,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//           backgroundColor: kBackgroundColor,
//           //  icon: Icon(Icons.navigate_next)
//         ),
//         body: Ordersno == 0
//             ? Container(

//                 color: Colors.white,
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                                     "Oops!",
//                                     style: GoogleFonts.josefinSans(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.blueGrey,
//                                           fontSize: 24,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                   SizedBox(height: 20,),
//                       Text(
//                                     "Orders is Empty",
//                                     style: GoogleFonts.josefinSans(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.blueGrey[700],
//                                           fontSize: 24,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                     ],
//                   ),
//                 ),
//               )
//             : SingleChildScrollView(
//                 child: Container(
//                   child: Column(
//                     children: [

//                       SizedBox(height: 10),
//                       // Row(
//                       //   children: [

//                       //     Padding(
//                       //       padding: const EdgeInsets.only(left: 10.0),
//                       //       child: Text(
//                       //         "Total No of Items : " +
//                       //            Ordersno.toString(),
//                       //         style: GoogleFonts.josefinSans(
//                       //           textStyle: TextStyle(
//                       //               fontWeight: FontWeight.w700,
//                       //               color: Colors.black,
//                       //               fontSize: 14,
//                       //               letterSpacing: 1),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(height: 10),
//                       // Row(
//                       //   children: [
//                       //     Padding(
//                       //       padding: const EdgeInsets.only(left: 10.0),
//                       //       child: Text(
//                       //         "Total Amount : " + totalAmount.toString(),
//                       //         style: GoogleFonts.josefinSans(
//                       //           textStyle: TextStyle(
//                       //               fontWeight: FontWeight.w700,
//                       //               color: Colors.black,
//                       //               fontSize: 14,
//                       //               letterSpacing: 1),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.only(left:10.0,right:10,bottom: 10),
//                         child: SingleChildScrollView(
//                                                   child: Container(
//                             color: Colors.white,
//                             height:MediaQuery.of(context).size.height - 235,
//                             child: StreamBuilder(
//                                 stream: FirebaseFirestore.instance
//                                     .collection("orders")
//                                     .doc(MRANDMRS.sharedprefs.getString("uid"))
//                                     .collection("items")
//                                     .snapshots(),
//                                 builder: (context, snapshot) {
//                                   if (!snapshot.hasData) {
//                                     return Text(
//                                       'Loading...',
//                                     );
//                                   } else {

//                                     return Scrollbar(
//                                     //  isAlwaysShown: true,
//                                     //  thickness: 10,

//                                       //  controller: _s`crollController,
//                                       child: ListView.builder(
//                                           // gridDelegate:
//                                           //     SliverGridDelegateWithFixedCrossAxisCount(
//                                           //         crossAxisCount: 1),
//                                           //   controller: _scrollController,
//                                           itemCount: snapshot.data.docs.length,
//                                           itemBuilder:
//                                               (BuildContext context, int index) {
//                                             return Padding(
//                                               padding: const EdgeInsets.all(10.0),
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               DetailScreen(
//                                                                 queryDocumentSnapshot:
//                                                                     snapshot.data
//                                                                             .docs[
//                                                                         index],
//                                                               )));
//                                                 },
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius:
//                                                           BorderRadius.circular(5)),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment.start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Container(
//                                                             height: 120,
//                                                             width: 120,
//                                                             decoration: BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             5),
//                                                                 color: Colors
//                                                                     .grey[200],
//                                                                 image: DecorationImage(
//                                                                     image: NetworkImage(snapshot
//                                                                                 .data
//                                                                                 .docs[
//                                                                             index][
//                                                                         'mainimage']),
//                                                                     fit: BoxFit
//                                                                         .cover)),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .only(
//                                                                     left: 8.0,
//                                                                     top: 12),
//                                                             child: Center(
//                                                               child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Text(
//                                                                     snapshot
//                                                                         .data
//                                                                         .docs[index]
//                                                                             ['name']
//                                                                         .toUpperCase(),
//                                                                     style:
//                                                                         GoogleFonts
//                                                                             .lato(
//                                                                       textStyle: TextStyle(
//                                                                           fontWeight:
//                                                                               FontWeight
//                                                                                   .w700,
//                                                                           color: Colors
//                                                                               .black,
//                                                                           fontSize:
//                                                                               14,
//                                                                           letterSpacing:
//                                                                               1),
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                                 .only(
//                                                                             right:
//                                                                                 8.0),
//                                                                     child: Center(
//                                                                       child: Text(
//                                                                         "₹ " +
//                                                                             snapshot
//                                                                                 .data
//                                                                                 .docs[index]['price']
//                                                                                 .toString(),
//                                                                         style:
//                                                                             GoogleFonts
//                                                                                 .lato(
//                                                                           textStyle: TextStyle(
//                                                                               fontWeight: FontWeight
//                                                                                   .w700,
//                                                                               color: Colors
//                                                                                   .black,
//                                                                               fontSize:
//                                                                                   15,
//                                                                               letterSpacing:
//                                                                                   1),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                                 .only(
//                                                                             right:
//                                                                                 10.0),
//                                                                     child: Text(
//                                                                       "₹ " +
//                                                                           snapshot
//                                                                               .data
//                                                                               .docs[
//                                                                                   index]
//                                                                                   [
//                                                                                   "oprice"]
//                                                                               .toString(),
//                                                                       style:
//                                                                           GoogleFonts
//                                                                               .lato(
//                                                                         textStyle: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight
//                                                                                     .bold,
//                                                                             decoration:
//                                                                                 TextDecoration
//                                                                                     .lineThrough,
//                                                                             color: Colors
//                                                                                 .black54,
//                                                                             fontSize:
//                                                                                 12,
//                                                                             letterSpacing:
//                                                                                 0),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Center(
//                                                                     child: Text(
//                                                                       snapshot
//                                                                           .data
//                                                                           .docs[
//                                                                               index]
//                                                                               [
//                                                                               'category']
//                                                                           .toUpperCase(),
//                                                                       style:
//                                                                           GoogleFonts
//                                                                               .lato(
//                                                                         textStyle: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight
//                                                                                     .w700,
//                                                                             color: Colors
//                                                                                 .black54,
//                                                                             fontSize:
//                                                                                 12,
//                                                                             letterSpacing:
//                                                                                 1),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .only(),
//                                                                     child: Center(
//                                                                       child: Text(
//                                                                         "PRODUCT NO : " +
//                                                                             snapshot
//                                                                                 .data
//                                                                                 .docs[index]['id']
//                                                                                 .toUpperCase(),
//                                                                         style:
//                                                                             GoogleFonts
//                                                                                 .lato(
//                                                                           textStyle: TextStyle(
//                                                                               fontWeight: FontWeight
//                                                                                   .w700,
//                                                                               color: Colors
//                                                                                   .black54,
//                                                                               fontSize:
//                                                                                   10,
//                                                                               letterSpacing:
//                                                                                   1),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Center(
//                                                                     child: Text(
//                                                                       "WOOD : " +
//                                                                           snapshot
//                                                                               .data
//                                                                               .docs[
//                                                                                   index]
//                                                                                   [
//                                                                                   'wood']
//                                                                               .toUpperCase(),
//                                                                       style:
//                                                                           GoogleFonts
//                                                                               .lato(
//                                                                         textStyle: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight
//                                                                                     .w700,
//                                                                             color: Colors
//                                                                                 .black54,
//                                                                             fontSize:
//                                                                                 12,
//                                                                             letterSpacing:
//                                                                                 1),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Container(
//                                                                     child: Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         Center(
//                                                                           child:
//                                                                               Text(
//                                                                             "QUANTITY : ",
//                                                                             style: GoogleFonts
//                                                                                 .lato(
//                                                                               textStyle: TextStyle(
//                                                                                   fontWeight: FontWeight.w700,
//                                                                                   color: Colors.black54,
//                                                                                   fontSize: 12,
//                                                                                   letterSpacing: 1),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         // IconButton(
//                                                                         //     onPressed:
//                                                                         //         () {
//                                                                         //       setState(
//                                                                         //           () {
//                                                                         //        MRANDMRS.sharedprefs.setString(snapshot.data.docs[index]['id'], (snapshot.data.docs[index]['id']++).toString());
//                                                                         //       });
//                                                                         //     },
//                                                                         //     icon: Icon(
//                                                                         //         Icons.add_circle_outline)),
//                                                                         Container(
//                                                                             child:
//                                                                                 Center(
//                                                                               child:
//                                                                                   Text(
//                                                                               snapshot.data.docs[index]['quanity'].toString(),
//                                                                                 style:
//                                                                                     GoogleFonts.lato(
//                                                                                   textStyle: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 14, letterSpacing: 1),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                             decoration: BoxDecoration(
//                                                                                 color: Colors.grey[
//                                                                                     300],
//                                                                                 borderRadius: BorderRadius.circular(
//                                                                                     2)),
//                                                                             height:
//                                                                                 30,
//                                                                             width:
//                                                                                 30),
//                                                                         // IconButton(
//                                                                         //     onPressed:
//                                                                         //         () {
//                                                                         //       setState(
//                                                                         //           () {
//                                                                         //         if (
//                                                                         //           snapshot.data.docs[index]['quanity'] >=
//                                                                         //             2) {
//                                                                         //           snapshot.data.docs[index]['quanity']--;
//                                                                         //         }
//                                                                         //       });
//                                                                         //     },
//                                                                         //     icon: Icon(
//                                                                         //         Icons.remove_circle_outline)),
//                                                                       ],
//                                                                     ),
//                                                                     height: 60,
//                                                                     width: 200,
//                                                                     decoration: BoxDecoration(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(
//                                                                                 5)),
//                                                                   ),
//                                                                     Center(
//                                                                     child: Text(
//                                                                       "STATUS : " +
//                                                                           snapshot
//                                                                               .data
//                                                                               .docs[
//                                                                                   index]
//                                                                                   [
//                                                                                   'wood']
//                                                                               .toUpperCase(),
//                                                                       style:
//                                                                           GoogleFonts
//                                                                               .lato(
//                                                                         textStyle: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight
//                                                                                     .w900,
//                                                                             color: Colors
//                                                                                 .black,
//                                                                             fontSize:
//                                                                                 12,
//                                                                             letterSpacing:
//                                                                                 1),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   SizedBox(height: 10,)
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),

//                                                         ],
//                                                       ),
//                                                       Container(
//                                                         height: 50,
//                                                         decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.only(
//                                                                   bottomLeft: Radius
//                                                                       .circular(5),
//                                                                   bottomRight:
//                                                                       Radius
//                                                                           .circular(
//                                                                               5)),
//                                                           color: Colors.grey[200],
//                                                         ),
//                                                         child: Column(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Container(
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius: BorderRadius.only(
//                                                                     bottomLeft: Radius
//                                                                         .circular(
//                                                                             5),
//                                                                     bottomRight:
//                                                                         Radius
//                                                                             .circular(
//                                                                                 5)),
//                                                                 color: kBackgroundColor,
//                                                               ),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceAround,
//                                                                 children: [
//                                                                   Center(
//                                                                     child:
//                                                                         IconButton(
//                                                                             onPressed:
//                                                                                 () {

//                                                                               // FirebaseFirestore
//                                                                               //     .instance
//                                                                               //     .collection("users")
//                                                                               //     .doc(MRANDMRS.sharedprefs.getString("uid"))
//                                                                               //     .collection("cart")
//                                                                               //     .doc(snapshot.data.docs[index]["id"]).delete();

//                                                                               //   setState(() {
//                                                                               //    cartno = cartvalueno();
//                                                                               //    totalAmount = totalAmount - snapshot.data.docs[index]['price'] * snapshot.data.docs[index]['quanity'];
//                                                                               //   });

//                                                                                 //   .get()
//                                                                                 //   .then((value) {
//                                                                                 // if (value.exists) {
//                                                                                 //   print("Already In Cart");
//                                                                                 // } else {
//                                                                                 //   FirebaseFirestore.instance.collection("users").doc(MRANDMRS.sharedprefs.getString("uid")).collection("cart").doc(snapshot.data.docs[index]['id']).set({
//                                                                                 //     "Description": snapshot.data.docs[index]['Description'],
//                                                                                 //     "price": snapshot.data.docs[index]['price'],
//                                                                                 //     "oprice": snapshot.data.docs[index]['oprice'],
//                                                                                 //     "category": snapshot.data.docs[index]['category'],
//                                                                                 //     "name": snapshot.data.docs[index]['name'],
//                                                                                 //     "id": snapshot.data.docs[index]['id'],
//                                                                                 //     "mainimage": snapshot.data.docs[index]['mainimage'],
//                                                                                 //     "quanity": 1,
//                                                                                 //     "wood": ""
//                                                                                 //   });
//                                                                                 // }
//                                                                               // }
//                                                                               // );
//                                                                             },
//                                                                             icon: Icon(
//                                                                                 Icons.remove_shopping_cart_outlined,color: Colors.white,)),
//                                                                   ),
//                                                                   Center(
//                                                                     child:
//                                                                         IconButton(
//                                                                             onPressed:
//                                                                                 () {
//                                                                               FirebaseFirestore
//                                                                                   .instance
//                                                                                   .collection("users")
//                                                                                   .doc(MRANDMRS.sharedprefs.getString("uid"))
//                                                                                   .collection("wishlist")
//                                                                                   .doc(snapshot.data.docs[index]['id'])
//                                                                                   .set({
//   "height":snapshot.data.docs[index]['height'],
//                             'width':snapshot.data.docs[index]['width'],
//                             "depth":snapshot.data.docs[index]['depth'],
//                             "weight":snapshot.data.docs[index]['weight'],
//                             "warranty":snapshot.data.docs[index]['warranty'],

//                                                                                 "Description":
//                                                                                     snapshot.data.docs[index]['Description'],
//                                                                                 "price":
//                                                                                     snapshot.data.docs[index]['price'],
//                                                                                 "oprice":
//                                                                                     snapshot.data.docs[index]['oprice'],
//                                                                                 "category":
//                                                                                     snapshot.data.docs[index]['category'],
//                                                                                 "name":
//                                                                                     snapshot.data.docs[index]['name'],
//                                                                                 "id":
//                                                                                     snapshot.data.docs[index]['id'],
//                                                                                 "mainimage":
//                                                                                     snapshot.data.docs[index]['mainimage'],
//                                                                                 "quanity":
//                                                                                     1,
//                                                                                 "wood":
//                                                                                     ""
//                                                                               });
//                                                                             },
//                                                                             icon: Icon(
//                                                                                 Icons.favorite_outline_sharp,color: Colors.white,)),
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                     );
//                                   }
//                                 }),
//                           ),
//                         ),
//                       ),

//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/Helper.dart';

import 'DetailedScreen.dart';

class Orders extends StatefulWidget {
  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 10,
        title: Text(
                                          "Orders"
                                          ,
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  letterSpacing: 0),
                                            ),
                                          ),
      ),
          body: SingleChildScrollView(
                      child: Container(
        color: Colors.white,
        // height: 1050,
        child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("orders").doc(MRANDMRS.sharedprefs.getString("uid")).collection("items")
                  
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Loading',
                  );
                } else {
                  return Scrollbar(
                    //   isAlwaysShown: true,
                    //
                    //

                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 20),
                      child: Container(
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                           // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            //                     gridDelegate:
                            // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),

                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => DetailScreen(
                                  //               queryDocumentSnapshot:
                                  //                   snapshot.data.docs[index],
                                  //             )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.teal[200].withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:8.0,top:8.0),
                                          child: Container(
                                            color: Colors.grey[200],
                                            height: 20,
                                            child: Center(
                                              child: Text("ORDER ID : "+
                                                snapshot.data.docs[index]["id"]
                                                    .toUpperCase(),
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 3),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
  Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                                          child: Container(
                                            color: Colors.grey[200],
                                            height: 20,
                                            child: Center(
                                              child: Text("ORDER STATUS : "+
                                                snapshot.data.docs[index]["status"]
                                                    .toUpperCase(),
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      letterSpacing: 3),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                                          child: Container(
                                            color: Colors.grey[200],
                                            height: 20,
                                            // child: Center(
                                            //   child: Text("PAYMENT : "+
                                            //     snapshot.data.docs[index]["payment"]
                                            //         .toUpperCase(),
                                            //     style: GoogleFonts.lato(
                                            //       textStyle: TextStyle(
                                            //           fontWeight: FontWeight.w600,
                                            //           color: Colors.black,
                                            //           fontSize: 12,
                                            //           letterSpacing: 3),
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                        ),
  Padding(
    padding: const EdgeInsets.only(left:8.0,right:8.0,top: 8,bottom: 0),
    child: Container(
     
      child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(MRANDMRS.sharedprefs.getString("uid"))
                          .collection("address")
                          .where("id", isEqualTo: snapshot.data.docs[index]["address"].toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : snapshot.data.docs.length == 0
                                ? SizedBox()
                                : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 1.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 6,),                                         
                                                Text(snapshot.data.docs[index]['name'] + "  :  "+snapshot.data.docs[index]
                                                            ['flatNumber'] +
                                                        " " +
                                                        snapshot.data.docs[index]
                                                            ['street1']+" , "+snapshot.data.docs[index]['street2'],
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.josefinSans(
                                                        textStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration.none,
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.normal))),
                                               
                                               
                                                Text(
                                                    snapshot.data.docs[index]['city'] +
                                                        "  -  " + snapshot.data.docs[index]['state'] +
                                                        "  -  "+" "+
                                                        snapshot.data.docs[index]
                                                            ['pincode'],
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.josefinSans(
                                                        textStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration.none,
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.normal))),
                                              
                                                Text(
                                                    snapshot.data.docs[index]
                                                        ['country']+ " / "+snapshot.data.docs[index]
                                                        ['phoneNumber'] ,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.josefinSans(
                                                        textStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration.none,
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.normal))),
                                               
                                              ],
                                            ),
                                            
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //   color: Colors.black
                                              //   ,width: 0.5
                                              // ),
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data.docs.length,
                                    shrinkWrap: true,
                                  );
                      }),
    ),
  ),
  
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                           decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(5)),
                                            height: 500,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1.0, right: 1.0),
                                              child: Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Container(
                                                  height: 150,
                                                  child: StreamBuilder<QuerySnapshot>(
                                                      stream:
                                                      
                                                      FirebaseFirestore.instance.
                                     collection("orders").doc(MRANDMRS.sharedprefs.getString("uid")).collection("items")                  
                                                    .doc(snapshot.data.docs[index]
                                                                ["id"]).collection("items").snapshots()
                                                     ,
                                                      builder: (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            'Loading',
                                                          );
                                                        } else {
                                                          return Scrollbar(
                                                            //   isAlwaysShown: true,

                                                            child: ListView.builder(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                //                     gridDelegate:
                                                                // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),

                                                                itemCount: snapshot
                                                                    .data.docs.length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(10.0),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    DetailScreen(
                                                                                      queryDocumentSnapshot: snapshot.data.docs[index],
                                                                                    )));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                                    5)),
                                                                        height: 162,
                                                
                                                                        child: Row(
                                                                          children: [
                                                                            SizedBox(width: 10,),
                                                                            Container(
                                                                              height:
                                                                                  100,
                                                                              width:
                                                                                  100,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(
                                                                                      5),
                                                                                  color: Colors
                                                                                      .white,
                                                                                  image: DecorationImage(
                                                                                      image: NetworkImage(snapshot.data.docs[index]['mainimage']),
                                                                                      fit: BoxFit.cover)),
                                                                            )
                                                                            ,
                                                                            SizedBox(width: 10,),
                                                                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(height: 20,),
                                                                                Center(
                                                                                  child:
                                                                                      Text(
                                                                                    snapshot
                                                                                        .data
                                                                                        .docs[index]['name']
                                                                                        .toUpperCase(),
                                                                                    style: GoogleFonts
                                                                                        .lato(
                                                                                      textStyle: TextStyle(
                                                                                          fontWeight: FontWeight.w700,
                                                                                          color: Colors.black,
                                                                                          fontSize: 10,
                                                                                          letterSpacing: 1),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                 Center(
                                                                                   child: Text("QUANTITY : "+
                                                                                snapshot
                                                                                     .data
                                                                                     .docs[index]['quanity'].toString()
                                                                                     ,
                                                                                style: GoogleFonts
                                                                                     .lato(
                                                                                   textStyle: TextStyle(
                                                                                       fontWeight: FontWeight.w700,
                                                                                       color: Colors.black,
                                                                                       fontSize: 10,
                                                                                       letterSpacing: 1),
                                                                                ),
                                                                              ),
                                                                                 ),
                                                                                  Center(
                                                                              child:
                                                                                  Text(
                                                                                snapshot
                                                                                    .data
                                                                                    .docs[index]['price'].toString(),
                                                                         
                                                                                style: GoogleFonts
                                                                                    .lato(
                                                                                  textStyle: TextStyle(
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: Colors.black,
                                                                                      fontSize: 10,
                                                                                      letterSpacing: 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                             Center(
                                                                              child:
                                                                                  Text(
                                                                                snapshot
                                                                                    .data
                                                                                    .docs[index]['Description']
                                                                                    .toUpperCase(),
                                                                                style: GoogleFonts
                                                                                    .lato(
                                                                                  textStyle: TextStyle(
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: Colors.black,
                                                                                      fontSize: 10,
                                                                                      letterSpacing: 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                             Center(
                                                                              child:
                                                                                  Text(
                                                                                snapshot
                                                                                    .data
                                                                                    .docs[index]['category']
                                                                                    .toUpperCase(),
                                                                                style: GoogleFonts
                                                                                    .lato(
                                                                                  textStyle: TextStyle(
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: Colors.black,
                                                                                      fontSize: 10,
                                                                                      letterSpacing: 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                             Center(
                                                                              child:
                                                                                  Text(
                                                                                snapshot
                                                                                    .data
                                                                                    .docs[index]['wood']
                                                                                    .toUpperCase(),
                                                                                style: GoogleFonts
                                                                                    .lato(
                                                                                  textStyle: TextStyle(
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: Colors.black,
                                                                                      fontSize: 10,
                                                                                      letterSpacing: 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                             
                                                                            
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          );
                                                        }
                                                      }),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ////
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  );
                }
              }),
      ),
          ),
    );
  }
}
