// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mr_and_mrs/Helper.dart';
// import 'package:mr_and_mr/paymentpage.dart';
// import 'package:mr_and_mrs/razorpay.dart';
// import 'AddAddress.dart';
// import 'AddressINfo.dart';
// import 'Addresschanger.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class Address extends StatefulWidget {
//   final double totalAmount;
//   final QueryDocumentSnapshot queryDocumentSnapshot;
//   const Address({Key key, this.totalAmount, this.queryDocumentSnapshot})
//       : super(key: key);
//   @override
//   _AddressState createState() => _AddressState();
// }

// class _AddressState extends State<Address> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //  appBar: AppBar(
//       //   leading: IconButton(
//       //       onPressed: () {
//       //         Navigator.pop(context);
//       //       },
//       //       icon: Icon(Icons.arrow_back_ios_sharp,
//       //           color: Colors.white, size: 12)),
//       //   leadingWidth: 25,
//       //   title: Text(
//       //     "SHIPMENT ADDRESS",
//       //     style: GoogleFonts.lato(
//       //       textStyle: TextStyle(
//       //           fontWeight: FontWeight.w900,
//       //           color: Colors.white,
//       //           fontSize: 14,
//       //           letterSpacing: 3),
//       //     ),
//       //   ),
//       //   backgroundColor: Colors.blueGrey[900],
//       // ),

//       child: Container(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Route route = MaterialPageRoute(builder: (c) => AddAddress());
//                 Navigator.push(context, route);
//               },
//               child: Container(
//                 child: Center(
//                   child: Text("ADD NEW ADDRESS",
//                       style: GoogleFonts.lato(
//                           textStyle: TextStyle(
//                         letterSpacing: 2,
//                         decoration: TextDecoration.none,
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                       ))),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.teal[900].withOpacity(0.4),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 height: 45,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 child: Consumer<AddressChanger>(builder: (context, address, c) {
//                   return StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection("users")
//                         .doc(MRANDMRS.sharedprefs.getString("uid"))
//                         .collection("address")
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       return !snapshot.hasData
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : snapshot.data.docs.length == 0
//                               ? noAddressCard()
//                               : ListView.builder(
//                                   itemBuilder: (context, index) {
//                                     return AddressCard(
//                                       currentIndex: address.count,
//                                       value: index,
//                                       addressId: snapshot.data.docs[index].id,
//                                       totalAmount: widget.totalAmount,
//                                       model: AddressModel.fromJson(
//                                           snapshot.data.docs[index].data()),
//                                     );
//                                   },
//                                   itemCount: snapshot.data.docs.length,
//                                   shrinkWrap: true,
//                                 );
//                     },
//                   );
//                 }),
//               ),
//             )
//           ],
//         ),
//         // color:Colors.black
//       ),
//     );
//   }

// class AddressCard extends StatefulWidget {
//   final AddressModel model;
//   final int currentIndex;
//   final int value;
//   final String addressId;
//   final double totalAmount;

//   const AddressCard(
//       {Key key,
//       this.model,
//       this.currentIndex,
//       this.value,
//       this.addressId,
//       this.totalAmount})
//       : super(key: key);

//   @override
//   _AddressCardState createState() => _AddressCardState();
// }

// class _AddressCardState extends State<AddressCard> {
//   @override
//   Widget build(BuildContext context) {
//     double screenwidth = MediaQuery.of(context).size.width;

//     return InkWell(
//         onTap: () {
//           Provider.of<AddressChanger>(context, listen: false)
//               .displayResult(widget.value);
//         },
//         child: Card(
//             elevation: 0,
//             color: Colors.grey[200],
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Radio(
//                       groupValue: widget.currentIndex,
//                       value: widget.value,
//                       activeColor: Colors.blueGrey[900],
//                       onChanged: (val) {
//                         print(widget.value);
//                         print("hi");
//                         Provider.of<AddressChanger>(context, listen: false)
//                             .displayResult(val);
//                       },
//                     ),
//                     SizedBox(
//                       width: 50,
//                     ),
//                     Container(
//                       height: 130,
//                       //  width: MediaQuery.of(context).size.width,

//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     widget.model.name.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.model.flatNumber.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.model.street1.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.model.street2.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.model.city.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.model.state.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.model.country.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.model.pincode.toUpperCase(),
//                                     style: GoogleFonts.lato(
//                                       textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 12,
//                                           letterSpacing: 1),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 widget.value == Provider.of<AddressChanger>(context).count
//                     ? Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             //  Navigator.push(context,
//                             //               MaterialPageRoute(builder: (context) =>

//                             //                RazorPayWeb()));

//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => PaymentPage(
//                                         addressId: widget.addressId,
//                                         totalAmount: widget.totalAmount)));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 bottom: 10.0, right: 10, left: 10),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.blueGrey[800],
//                                   borderRadius: BorderRadius.circular(10)),
//                               height: 45,
//                               //  width:20,

//                               child: Center(
//                                 child: Text(
//                                   "PROCEED",
//                                   style: GoogleFonts.lato(
//                                     textStyle: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                         letterSpacing: 3),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     : Container()
//               ],
//             )));
//   }
// }

// class KeText extends StatelessWidget {
//   final String msg;

//   const KeText({Key key, this.msg}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(msg.toUpperCase(),
//         style: GoogleFonts.lato(
//             textStyle: TextStyle(
//           color: Colors.black54,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         )));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AddAddress.dart';
import 'Helper.dart';
import 'constants.dart';

class maineraddress extends StatefulWidget {
  @override
  _maineraddressState createState() => _maineraddressState();
}

bool selected = false;
// List maineraddress = new List.filled(0, 1, growable: false);
var id = "";

class _maineraddressState extends State<maineraddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp,
                color: kBackgroundColor, size: 12)),
        leadingWidth: 25,
        backgroundColor: Colors.white,
        title: Text(
          "Address",
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: kBackgroundColor,
                fontSize: 18,
                letterSpacing: 0),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
          color: Colors.white,
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(builder: (c) => AddAddress());
                Navigator.push(context, route);
              },
              child: Container(
                child: Center(
                  child: Text("ADD NEW ADDRESS",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        letterSpacing: 2,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ))),
                ),
                decoration: BoxDecoration(
                  color: Colors.brown[900].withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 45,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(MRANDMRS.sharedprefs.getString("uid"))
                        .collection("address")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.data.docs.length == 0
                              ? noAddressCard()
                              : ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            id =
                                                snapshot.data.docs[index]['id'];
                                            print(id);
                                          });
                                          // print(address);
                                          // if (address.contains(
                                          //     snapshot.data.docs[index]['id'])) {
                                          //   setState(() {
                                          //     address.remove(snapshot
                                          //         .data.docs[index]["id"]);
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     address.add(snapshot
                                          //         .data.docs[index]["id"]);
                                          //   });
                                          // }
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                  snapshot.data.docs[index]
                                                      ['name'],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                              Text(
                                                  snapshot.data.docs[index]
                                                          ['flatNumber'] +
                                                      " " +
                                                      snapshot.data.docs[index]
                                                          ['street1'],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                              Text(
                                                  snapshot.data.docs[index]
                                                      ['street2'],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                              Text(
                                                  snapshot.data
                                                          .docs[index]['city'] +
                                                      "  -  " +
                                                      snapshot.data.docs[index]
                                                          ['pincode'],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                              Text(
                                                  snapshot.data.docs[index]
                                                      ['state'],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                              Text(
                                                  snapshot.data.docs[index]
                                                      ['country'],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                              Text(
                                                  snapshot.data.docs[index]
                                                      ['phoneNumber'],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            ],
                                          ),
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: id ==
                                                    snapshot.data.docs[index]
                                                        ['id']
                                                ? Colors.teal[900]
                                                    .withOpacity(0.2)
                                                : Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: snapshot.data.docs.length,
                                  shrinkWrap: true,
                                );
                    },
                  )),
            ),
          ])),
    );
  }

  noAddressCard() {
    return Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Address Has Been Saved !!!",
                style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
          ],
        ));
  }
}
