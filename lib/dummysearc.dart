// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mr_and_mrs/DetailedScreen.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   TextEditingController searchcontroller = new TextEditingController();
//   String name = '';
//   List category = ["chair", "bed", "sofa"];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           backgroundColor: Colors.red[900],
//           child: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.clear),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         body: Container(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(7)),
//                   height: 50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       onChanged: (val) {
//                         setState(() {
//                           name = val;
//                         });
//                       },
//                       // cursorColor: Colors.red[900],
//                       controller: searchcontroller,
//                       style: TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,

//                         // border: OutlineInputBorder(
//                         //     borderSide: BorderSide(color: Colors.black,width:5)),
//                         hintText: "SEARCH HERE ...",
//                         hintStyle:
//                             TextStyle(color: Colors.grey, letterSpacing: 1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 1.0, right: 1.0),
//                 child: Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Container(
//                     height: 100,
//                     child: StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection("Items")
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return Text(
//                               'No Data...',
//                             );
//                           } else {
//                             return Scrollbar(
//                               //   isAlwaysShown: true,controller: _scrollController,
//                               child: GridView.builder(
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 4),
//                                   itemCount: snapshot.data.docs.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       DetailScreen(
//                                                         queryDocumentSnapshot:
//                                                             snapshot.data
//                                                                 .docs[index],
//                                                       )));
//                                         },
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(5)),
//                                           height: 120,
//                                           width: 220,
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 height: 67,
//                                                 width: 270,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                     color: Colors.white,
//                                                     image: DecorationImage(
//                                                         image: NetworkImage(
//                                                             snapshot.data
//                                                                     .docs[index]
//                                                                 ['image']),
//                                                         fit: BoxFit.cover)),
//                                               ),
//                                               Center(
//                                                 child: Text(
//                                                   snapshot
//                                                       .data.docs[index]['name']
//                                                       .toUpperCase(),
//                                                   style: GoogleFonts.lato(
//                                                     textStyle: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Colors.black,
//                                                         fontSize: 10,
//                                                         letterSpacing: 1),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                             );
//                           }
//                         }),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   // child: ListView.builder(
//                   //     scrollDirection: Axis.vertical,
//                   //     itemCount: resultlist.length,
//                   //     itemBuilder: (BuildContext context, int index) {
//                   //       return GestureDetector(
//                   //         onTap: () {
//                   //           Navigator.push(
//                   //               context,
//                   //               MaterialPageRoute(
//                   //                   builder: (context) => DetailScreen(
//                   //                         queryDocumentSnapshot:
//                   //                             resultlist[index],
//                   //                       )));
//                   //         },
//                   //         child: Padding(
//                   //           padding: const EdgeInsets.all(5.0),
//                   //           child: Container(
//                   //             decoration: BoxDecoration(
//                   //               color: Colors.black,
//                   //               borderRadius: BorderRadius.circular(10),
//                   //             ),
//                   //             child: Row(
//                   //               children: [
//                   //                 SizedBox(
//                   //                   width: 20,
//                   //                 ),
//                   //                 //  Container(
//                   //                 //         height: 120,
//                   //                 //         width: 120,
//                   //                 //         decoration: BoxDecoration(
//                   //                 //             image: DecorationImage(
//                   //                 //                 image: NetworkImage(
//                   //                 //                   resultlist[index].data()['image']
//                   //                 //                  ),
//                   //                 //                 fit: BoxFit.fill),
//                   //                 //             color: Colors.grey.shade300,
//                   //                 //             borderRadius:
//                   //                 //                 BorderRadius.circular(20)),
//                   //                 //       ),

//                   //                 Text(
//                   //                   resultlist[index].data()['name'],
//                   //                   style: GoogleFonts.lato(
//                   //                     textStyle: TextStyle(
//                   //                         fontWeight: FontWeight.normal,
//                   //                         color: Colors.white,
//                   //                         fontSize: 14,
//                   //                         letterSpacing: 2),
//                   //                   ),
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //             height: 80,
//                   //           ),
//                   //         ),
//                   //       );
//                   //     }),

//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: (name != "" && name != null)
//                         ? FirebaseFirestore.instance
//                             .collection("Items")
//                             .doc()
//                             .collection("Products")
//                             .where('index', arrayContains: name)
//                             .snapshots()
//                         :                     
                        
//                         FirebaseFirestore.instance
//                             .collection("Items")
                          
//                             .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: Text("Loading"));
//                       } else {
//                         return GridView.count(
//                           scrollDirection: Axis.vertical,
//                           crossAxisCount: 2,
//                           children: snapshot.data.docs
//                               .map((DocumentSnapshot documentSnapshot) {
//                             return Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => DetailScreen(
//                                                 queryDocumentSnapshot:
//                                                     documentSnapshot,
//                                               )));
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           width: 546,
//                                           height: 160,
//                                           decoration: BoxDecoration(
//                                               image: DecorationImage(
//                                                   image: NetworkImage(
//                                                       documentSnapshot
//                                                           .data()['image']),
//                                                   fit: BoxFit.cover),
//                                               color: Colors.grey.shade300,
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                         ),
//                                         Center(
//                                           child: Text(
//                                             documentSnapshot
//                                                 .data()['name']
//                                                 .toUpperCase(),
//                                             style: GoogleFonts.lato(
//                                               textStyle: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                   letterSpacing: 2),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             );
//                           }).toList(),
//                         );
//                       }
//                     },
//                   ),

//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
