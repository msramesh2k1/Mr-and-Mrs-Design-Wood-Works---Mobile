// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mr_and_mrs/DetailedScreen.dart';
// import 'package:mr_and_mrs/Helper.dart';

// import 'Address.dart';

// class cart extends StatefulWidget {
//   final int cartno;

//   const cart({Key key, this.cartno}) : super(key: key);

//   @override
//   _cartState createState() => _cartState();
// }

// class _cartState extends State<cart> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,        
//       floatingActionButton:FloatingActionButton.extended(
        
//         onPressed: ()
//       {
    
//         Route route = MaterialPageRoute(builder: (c) => Address(totalAmount: 2));
//         Navigator.push(context,route);
//       },
     
//               label: Text("PLACE ORDER"),
//       backgroundColor: Colors.black,
//     //  icon: Icon(Icons.navigate_next)
//       ),
//       body:widget.cartno == 0 ? Container(color: Colors.red[900],)
//       :
//       SingleChildScrollView(
//         child: Container(
       
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   SizedBox(width: 5),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(Icons.arrow_back_ios_sharp,
//                           color: Colors.black, size: 15)),
//                   Text(
//                     "MY CART" ,
                       
//                     style: GoogleFonts.lato(
//                       textStyle: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           color: Colors.black,
//                           fontSize: 18,
//                           letterSpacing: 1),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height:10),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left:10.0),
//                     child: Text(
//                           "Toatal No of Items : "+widget.cartno.toString() ,
                             
//                           style: GoogleFonts.lato(
//                             textStyle: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 letterSpacing: 1),
//                           ),
//                         ),
//                   ),
//                 ],
//               ),
//                     SizedBox(height:10),
//               Container(
//                 color: Colors.white,
//               height:MediaQuery.of(context).size.height,
//                 child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("users")
//                         .doc(MRANDMRS.sharedprefs.getString("uid"))
//                         .collection("cart")
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return Text(
//                           'No Data...',
//                         );
//                       } else {
//                         return Scrollbar(
//                           //   isAlwaysShown: true,
//                           //  controller: _s`crollController,
//                           child: ListView.builder(
//                               // gridDelegate:
//                               //     SliverGridDelegateWithFixedCrossAxisCount(
//                               //         crossAxisCount: 1),
//                               //   controller: _scrollController,
//                               itemCount: snapshot.data.docs.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   DetailScreen(
//                                                     queryDocumentSnapshot:
//                                                         snapshot
//                                                             .data.docs[index],
//                                                   )));
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 height: 120,
//                                                 width:120,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(5),
//                                                     color: Colors.grey[200],
//                                                     image: DecorationImage(
//                                                         image: NetworkImage(snapshot
//                                                                 .data.docs[index]
//                                                             ['mainimage']),
//                                                         fit: BoxFit.cover)),
//                                               ),
//                                               Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 8.0,top:12),
//                                                       child: Center(
//                                                         child: Column(
//                                                           crossAxisAlignment:CrossAxisAlignment.start,
//                                                           children: [
//                                                             Text(
//                                                               snapshot
//                                                                   .data
//                                                                   .docs[index]
//                                                                       ['name']
//                                                                   .toUpperCase(),
//                                                               style:
//                                                                   GoogleFonts.lato(
//                                                                 textStyle: TextStyle(
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w700,
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize: 14,
//                                                                     letterSpacing:
//                                                                         1),
//                                                               ),
//                                                             ),
//                                                             Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   right: 8.0),
//                                                           child: Center(
//                                                             child: Text(
//                                                               "₹ " +
//                                                                   snapshot
//                                                                       .data
//                                                                       .docs[
//                                                                           index]
//                                                                           [
//                                                                           'price']
//                                                                       .toUpperCase(),
//                                                               style: GoogleFonts
//                                                                   .lato(
//                                                                 textStyle: TextStyle(
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w700,
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize:
//                                                                         15,
//                                                                     letterSpacing:
//                                                                         1),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   right: 10.0),
//                                                           child: Text(
//                                                             "₹ " +
//                                                                 snapshot
//                                                                     .data
//                                                                     .docs[index]
//                                                                         [
//                                                                         "oprice"]
//                                                                     .toString(),
//                                                             style: GoogleFonts
//                                                                 .lato(
//                                                               textStyle: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   decoration:
//                                                                       TextDecoration
//                                                                           .lineThrough,
//                                                                   color: Colors
//                                                                       .black54,
//                                                                   fontSize: 12,
//                                                                   letterSpacing:
//                                                                       0),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Center(
//                                                           child: Text(
//                                                             snapshot
//                                                                 .data
//                                                                 .docs[index]
//                                                                     ['category']
//                                                                 .toUpperCase(),
//                                                             style:
//                                                                 GoogleFonts.lato(
//                                                               textStyle: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black54,
//                                                                   fontSize: 12,
//                                                                   letterSpacing:
//                                                                       1),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                      ),
//                                                       child: Center(
//                                                         child: Text(
//                                                           "PRODUCT NO : " +
//                                                               snapshot
//                                                                   .data
//                                                                   .docs[index]
//                                                                       ['id']
//                                                                   .toUpperCase(),
//                                                           style:
//                                                               GoogleFonts.lato(
//                                                             textStyle: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w700,
//                                                                 color: Colors
//                                                                     .black54,
//                                                                 fontSize: 10,
//                                                                 letterSpacing:
//                                                                     1),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Center(
//                                                           child: Text("WOOD : "+
//                                                             snapshot
//                                                                 .data
//                                                                 .docs[index]
//                                                                     ['wood']
//                                                                 .toUpperCase(),
//                                                             style:
//                                                                 GoogleFonts.lato(
//                                                               textStyle: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black54,
//                                                                   fontSize: 12,
//                                                                   letterSpacing:
//                                                                       1),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                          Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
                  
//                                                     Center(
//                                                           child: Text("QUANTITY : ",
//                                                             style:
//                                                                 GoogleFonts.lato(
//                                                               textStyle: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black54,
//                                                                   fontSize: 12,
//                                                                   letterSpacing:
//                                                                       1),
//                                                             ),
//                                                           ),
//                                                         ),
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                      snapshot
//                                                             .data
//                                                             .docs[index]
//                                                                 ['quanity']++;
//                     });
//                   },
//                   icon: Icon(Icons.add_circle_outline)),
//               Container(
//                   child: Center(
//                     child: Text(
//                       snapshot
//                                                             .data
//                                                             .docs[index]
//                                                                 ['quanity'].toString(),
//                       style: GoogleFonts.lato(
//                         textStyle: TextStyle(
//                             fontWeight: FontWeight.w900,
//                             color: Colors.black,
//                             fontSize: 14,
//                             letterSpacing: 1),
//                       ),
//                     ),
//                   ),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2)),
//                   height: 30,
//                   width: 30),
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (snapshot
//                                                             .data
//                                                             .docs[index]
//                                                                 ['quanity'] >= 2) {
//                        snapshot
//                                                             .data
//                                                             .docs[index]
//                                                                 ['quanity']--;
//                       }
//                     });
//                   },
//                   icon: Icon(Icons.remove_circle_outline)),
//                 ],
//               ),
//               height: 60,
//               width: 200,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(5)),
//             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
                                                    
                                                    
//                                             ],
//                                           ),
//                                           Container(
//                                             height: 50,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.only(
//                                                   bottomLeft:
//                                                       Radius.circular(5),
//                                                   bottomRight:
//                                                       Radius.circular(5)),
//                                               color: Colors.grey[200],
//                                             ),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
                               
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.only(
//                                                             bottomLeft: Radius
//                                                                 .circular(5),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     5)),
//                                                     color: Colors.orange[300],
//                                                   ),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceAround,
//                                                     children: [
//                                                       Center(
//                                                         child: IconButton(
//                                                             onPressed: () {
//                                                               FirebaseFirestore
//                                                                   .instance
//                                                                   .collection(
//                                                                       "users")
//                                                                   .doc(MRANDMRS
//                                                                       .sharedprefs
//                                                                       .getString(
//                                                                           "uid"))
//                                                                   .collection(
//                                                                       "cart")
//                                                                   .doc(snapshot
//                                                                           .data
//                                                                           .docs[
//                                                                       index]["id"])
//                                                                   .get()
//                                                                   .then((value) {
//                                                                 if (value
//                                                                     .exists) {
//                                                                   print(
//                                                                       "Already In Cart");
//                                                                 }else{

//                                                                    FirebaseFirestore
//                                                                   .instance
//                                                                   .collection(
//                                                                       "users")
//                                                                   .doc(MRANDMRS
//                                                                       .sharedprefs
//                                                                       .getString(
//                                                                           "uid"))
//                                                                   .collection(
//                                                                       "cart")
//                                                                   .doc(snapshot
//                                                                           .data
//                                                                           .docs[
//                                                                       index]['id'])
//                                                                   .set({
//                                                                 "Description": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index][
//                                                                     'Description'],
//                                                                 "price": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index]
//                                                                     ['price'],
//                                                                 "oprice": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index]
//                                                                     ['oprice'],
//                                                                 "category": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index][
//                                                                     'category'],
//                                                                 "name": snapshot
//                                                                         .data
//                                                                         .docs[
//                                                                     index]['name'],
//                                                                 "id": snapshot
//                                                                         .data
//                                                                         .docs[
//                                                                     index]['id'],
//                                                                 "mainimage": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index][
//                                                                     'mainimage'],
//                                                                 "quanity": 1,
//                                                                 "wood": ""
//                                                               });

//                                                                 }
//                                                               });

                                                             
//                                                             },
//                                                             icon: Icon(Icons
//                                                                 .remove_shopping_cart_outlined)),
//                                                       ),
//                                                       Center(
//                                                         child: IconButton(
//                                                             onPressed: () {
//                                                               FirebaseFirestore
//                                                                   .instance
//                                                                   .collection(
//                                                                       "users")
//                                                                   .doc(MRANDMRS
//                                                                       .sharedprefs
//                                                                       .getString(
//                                                                           "uid"))
//                                                                   .collection(
//                                                                       "favlist")
//                                                                   .doc(snapshot
//                                                                           .data
//                                                                           .docs[
//                                                                       index]['id'])
//                                                                   .set({
//                                                                 "Description": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index][
//                                                                     'Description'],
//                                                                 "price": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index]
//                                                                     ['price'],
//                                                                 "oprice": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index]
//                                                                     ['oprice'],
//                                                                 "category": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index][
//                                                                     'category'],
//                                                                 "name": snapshot
//                                                                         .data
//                                                                         .docs[
//                                                                     index]['name'],
//                                                                 "id": snapshot
//                                                                         .data
//                                                                         .docs[
//                                                                     index]['id'],
//                                                                 "mainimage": snapshot
//                                                                             .data
//                                                                             .docs[
//                                                                         index][
//                                                                     'mainimage'],
//                                                                 "quanity": 1,
//                                                                 "wood": ""
//                                                               });
//                                                             },
//                                                             icon: Icon(Icons
//                                                                 .favorite_outline_sharp)),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
                                                
//                                               ],
                                              
//                                             ),
//                                           ),
                                          
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         );
//                       }
//                     }),
//               ),










// Padding(
//                       padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
//                       child: Container(
//                         child: Center(
//                           child: Text(
//                             "LOGIN",
//                             style: GoogleFonts.lato(
//                               textStyle: TextStyle(
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   letterSpacing: 2),
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             color: Colors.red[900],
//                             borderRadius: BorderRadius.circular(8)),
//                         height: 50,
//                       ),
//                     ),
                 




              
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
