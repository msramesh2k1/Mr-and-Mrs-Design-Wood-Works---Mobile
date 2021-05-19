// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:mr_and_mrs/Helper.dart';

// import 'Address.dart';
// import 'AddressINfo.dart';
// import 'OrderCard.dart';
// import 'SplashScreen.dart';

// String getOrderId = "";

// class OrderDetails extends StatelessWidget {
//   final String orderID;

//   const OrderDetails({Key key, this.orderID}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     getOrderId = orderID;
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: FutureBuilder<DocumentSnapshot>(
//             future: FirebaseFirestore.instance
//                 .collection("users")
//                 .doc(MRANDMRS.sharedprefs.getString("uid"))
//                 .collection("orders")
//                 .doc(orderID)
//                 .get(),
//             builder: (context, snapshot) {
//               Map dataMap;
//               if (snapshot.hasData) {
//                 dataMap = snapshot.data.data();
//               }
//               return snapshot.hasData
//                   ? Container(
//                       child: Column(children: [
//                         StatusBanner(
//                           status: dataMap["isSuccess"],
//                         ),
//                         SizedBox(height: 10.0),
//                         Padding(
//                             padding: EdgeInsets.all(4.0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "%" +
//                                     dataMap["price"]
//                                         .toString(),
//                                 style: TextStyle(color: Colors.amberAccent),
//                               ),
//                             )),
//                         Padding(
//                             padding: EdgeInsets.all(4),
//                             child: Text("Order ID " + getOrderId)),
//                         Padding(
//                             padding: EdgeInsets.all(4),
//                             child: Text(
//                               "Orderat " +
//                                   DateFormat("dd MMM, yyyy - hh:mm aa").format(
//                                       DateTime.fromMillisecondsSinceEpoch(
//                                           int.parse(dataMap["orderTime"]))),
//                               style: TextStyle(color: Colors.black38),
//                             )),
//                         Divider(
//                           height: 3,
//                         ),
//                         FutureBuilder<QuerySnapshot>(
//                           future: FirebaseFirestore.instance
//                               .collection("items")
//                               .where("shortInfo",
//                                   whereIn: dataMap["productid"])
//                               .get(),
//                           builder: (context, dataSnapshot) {
//                             return dataSnapshot.hasData
//                                 ? OrderCard(
//                                     itemCount: dataSnapshot.data.docs.length,
//                                     data: dataSnapshot.data.docs,
//                                   )
//                                 : Center(child:  CircularProgressIndicator());
//                           },
//                         ),
//                         Divider(
//                           height: 5,
//                         ),
//                         FutureBuilder<DocumentSnapshot>(
//                             future: FirebaseFirestore.instance
//                                 .collection("users")
//                                 .doc(MRANDMRS.sharedprefs.getString("uid"))
//                                 .collection("address")
//                                 .doc(dataMap["addressid"])
//                                 //////////////////////////////
//                                 .get(),
//                             builder: (context, snap) {
//                               return snap.hasData
//                                   ? ShippingDetails(
//                                       model: AddressModel.fromJson(
//                                           snap.data.data()))
//                                   : Center(child:  CircularProgressIndicator());
//                             }),
//                       ]),
//                     )
//                   : Center(child: CircularProgressIndicator());
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StatusBanner extends StatelessWidget {
//   final bool status;

//   const StatusBanner({Key key, this.status}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String msg;
//     IconData iconData;

//     status ? iconData = Icons.done : iconData = Icons.cancel;
//     status ? msg = "SuccessFull" : msg = "UnSuccessfull";
//     return Container(
//       child: Container(
//           decoration: new BoxDecoration(color: Colors.green),
//           height: 40,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   SystemNavigator.pop();
//                 },
//                 child: Container(
//                     child: Icon(Icons.arrow_downward, color: Colors.red)),
//               ),
//               SizedBox(width: 20),
//               Text(
//                 "Order Placed " + msg,
//                 style: TextStyle(color: Colors.yellow),
//               ),
//               SizedBox(width: 5.0),
//               CircleAvatar(
//                   radius: 8.0,
//                   backgroundColor: Colors.grey,
//                   child: Center(
//                     child: Icon(
//                       iconData,
//                       color: Colors.amber,
//                     ),
//                   ))
//             ],
//           )),
//     );
//   }
// }

// class ShippingDetails extends StatelessWidget {
//  // final AddressModel model;

//  // const ShippingDetails({Key key, this.model}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double screenwidth = MediaQuery.of(context).size.width;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Padding(
//             padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
//             child: Text(
//               "Shipment Details",
//               style: TextStyle(color: Colors.blue),
//             )),
//         Container(
//             padding: EdgeInsets.all(10.0),
//             width: screenwidth * 0.0,
//             child: Table(
//               defaultColumnWidth: FixedColumnWidth(120.0),
//               border: TableBorder.all(
//                   color: Colors.black, style: BorderStyle.solid, width: 2),
//               children: [
//                 TableRow(children: [
//                 //////////  KeText(msg: "Name"),
//                   Text(model.name,
//                       style: GoogleFonts.josefinSans(
//                           textStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       ))),
//                 ]),
//                 TableRow(children: [
//                  //////////// KeText(msg: "Phone Number"),
//                   Text(model.phoneNumber,
//                       style: GoogleFonts.josefinSans(
//                           textStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       ))),
//                 ]),
//                 TableRow(children: [
//                 /////////////////  KeText(msg: "Flat Number"),
//                   Text(model.flatNumber,
//                       style: GoogleFonts.josefinSans(
//                           textStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       ))),
//                 ]),
//                 TableRow(children: [
//               ///////////////////    KeText(msg: "City"),
//                   Text(model.city,
//                       style: GoogleFonts.josefinSans(
//                           textStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       ))),
//                 ]),
//                 TableRow(children: [
//                 ////////////////  KeText(msg: "State"),
//                   Text(model.state,
//                       style: GoogleFonts.josefinSans(
//                           textStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       ))),
//                 ]),
//                 TableRow(children: [
//                 /////////////////////  KeText(msg: "Pincode"),
//                   Text(model.pincode,
//                       style: GoogleFonts.josefinSans(
//                           textStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.normal,
//                       ))),
//                 ]),
//               ],
//             )),
//         Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Center(
//               child: InkWell(
//                   onTap: () {
//                     confirmeduserOrderReceiver(context, getOrderId);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(color: Colors.amber),
//                     width: MediaQuery.of(context).size.width - 40.0,
//                     height: 50,
//                     child: Center(
//                       child: Text(
//                         "Confirmed || Items Received",
//                         style: TextStyle(color: Colors.greenAccent),
//                       ),
//                     ),
//                   )),
//             ))
//       ],
//     );
//   }

//   confirmeduserOrderReceiver(BuildContext context, String mOrderId) {
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(MRANDMRS.sharedprefs.getString("uid"))
//         .collection("orders")
//         .doc(mOrderId)
//         .delete();
//     getOrderId = "";
//     Route route = MaterialPageRoute(builder: (context) => SplashScreen());
//     Navigator.pushReplacement(context, route);
//     print("order has been received");
//     //  Fluttertoast.showToast(msg: "Order has been Received.Confirmed");
//   }
// }
