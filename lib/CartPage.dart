import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/DetailedScreen.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/HomScreen.dart';
import 'package:mr_and_mrs/constants.dart';

import 'Address.dart';

class cart extends StatefulWidget {
  //final int cartno;

  const cart({
    Key key,
  }) : super(key: key);

  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  int totalAmount = 0;
  int quanity = 1;
  int cartno = 0;

  int cartvalueno() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        cartno = querySnapshot.docs.length;
      });
    });
    return cartno;
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .snapshots();
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        cartno = querySnapshot.docs.length;
      });
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          MRANDMRS.sharedprefs
              .setInt(element.data()['id'], element.data()['quanity']);
          totalAmount =
              totalAmount + element.data()["price"] * element.data()['quanity'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(Icons.arrow_back_ios_sharp,
      //           color: Colors.white, size: 12)),
      //   leadingWidth: 25,
      //   title: Text(
      //     "Cart",
      // style: GoogleFonts.josefinSans(
      //       textStyle: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           color: Colors.white,
      //           fontSize: 18,
      //           letterSpacing: 1),
      //     ),
      //   ),
      //   backgroundColor: kBackgroundColor,
      // ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      // floatingActionButton: FloatingActionButton.extended(

      //   onPressed: () {
      //     cartno == 0 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
      //       return HomeScreen();
      //     })) :Navigator.push(context, MaterialPageRoute(builder: (c){
      //       return Address(

      //         // FirebaseFirestore.instance
      //         //                 .collection("users")
      //         //                 .doc(MRANDMRS.sharedprefs.getString("uid"))
      //         //                 .collection("cart")
      //         //                 .snapshots() ,
      //         totalAmount: totalAmount.toDouble());
      //     }));

      //   },

      //   label:cartno == 0?  Text(
      //                             "Countiue Shopping",
      //                             style: GoogleFonts.josefinSans(
      //                               textStyle: TextStyle(
      //                                   fontWeight: FontWeight.w600,
      //                                   color: Colors.white,
      //                                   fontSize: 13,
      //                                   letterSpacing: 1),
      //                             ),
      //                           ):Text(
      //                         "Place Order",
      //                             style: GoogleFonts.josefinSans(
      //                               textStyle: TextStyle(
      //                                   fontWeight: FontWeight.w600,
      //                                   color: Colors.white,
      //                                   fontSize: 13,
      //                                   letterSpacing: 1),
      //                             ),
      //                           ),
      //   backgroundColor: kBackgroundColor,
      //   //  icon: Icon(Icons.navigate_next)
      // ),
      child: cartno == 0
          ? Container(
              height: 200,
              color: Colors.transparent,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Oops!!",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey,
                            fontSize: 24,
                            letterSpacing: 0.5),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Cart is Empty",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey[700],
                            fontSize: 24,
                            letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    // SizedBox(height: 10),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            "Total No of Items : " + cartno.toString(),
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            "Total Amount : " + totalAmount.toString(),
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0, bottom: 10),
                      child: SingleChildScrollView(
                        //physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(MRANDMRS.sharedprefs.getString("uid"))
                                  .collection("cart")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text(
                                      'Loading...',
                                    ),
                                  );
                                } else {
                                  return Scrollbar(
                                    isAlwaysShown: true,
                                    thickness: 10,

                                    //  controller: _s`crollController,
                                    child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        // gridDelegate:
                                        //     SliverGridDelegateWithFixedCrossAxisCount(
                                        //         crossAxisCount: 1),
                                        //   controller: _scrollController,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailScreen()));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 120,
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors
                                                                  .grey[200],
                                                              image: DecorationImage(
                                                                  image: NetworkImage(snapshot
                                                                          .data
                                                                          .docs[index]
                                                                      [
                                                                      'mainimage']),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  top: 12),
                                                          child: Center(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'name']
                                                                      .toUpperCase(),
                                                                  style:
                                                                      GoogleFonts
                                                                          .lato(
                                                                    textStyle: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            1),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "₹ " +
                                                                          snapshot
                                                                              .data
                                                                              .docs[index]['price']
                                                                              .toString(),
                                                                      style: GoogleFonts
                                                                          .lato(
                                                                        textStyle: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w700,
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                15,
                                                                            letterSpacing:
                                                                                1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                                  child: Text(
                                                                    "₹ " +
                                                                        snapshot
                                                                            .data
                                                                            .docs[index]["oprice"]
                                                                            .toString(),
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      textStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          decoration: TextDecoration
                                                                              .lineThrough,
                                                                          color: Colors
                                                                              .black54,
                                                                          fontSize:
                                                                              12,
                                                                          letterSpacing:
                                                                              0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child: Text(
                                                                    snapshot
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                            [
                                                                            'category']
                                                                        .toUpperCase(),
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      textStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color: Colors
                                                                              .black54,
                                                                          fontSize:
                                                                              12,
                                                                          letterSpacing:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "PRODUCT NO : " +
                                                                          snapshot
                                                                              .data
                                                                              .docs[index]['id']
                                                                              .toUpperCase(),
                                                                      style: GoogleFonts
                                                                          .lato(
                                                                        textStyle: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w700,
                                                                            color: Colors
                                                                                .black54,
                                                                            fontSize:
                                                                                10,
                                                                            letterSpacing:
                                                                                1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child: Text(
                                                                    "WOOD : " +
                                                                        snapshot
                                                                            .data
                                                                            .docs[index]['wood']
                                                                            .toUpperCase(),
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      textStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color: Colors
                                                                              .black54,
                                                                          fontSize:
                                                                              12,
                                                                          letterSpacing:
                                                                              1),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "QUANTITY : ",
                                                                          style:
                                                                              GoogleFonts.lato(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight.w700,
                                                                                color: Colors.black54,
                                                                                fontSize: 12,
                                                                                letterSpacing: 1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // IconButton(
                                                                      //     onPressed:
                                                                      //         () {
                                                                      //       setState(
                                                                      //           () {
                                                                      //        MRANDMRS.sharedprefs.setString(snapshot.data.docs[index]['id'], (snapshot.data.docs[index]['id']++).toString());
                                                                      //       });
                                                                      //     },
                                                                      //     icon: Icon(
                                                                      //         Icons.add_circle_outline)),
                                                                      Container(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              snapshot.data.docs[index]['quanity'].toString(),
                                                                              style: GoogleFonts.lato(
                                                                                textStyle: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 14, letterSpacing: 1),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey[
                                                                                  300],
                                                                              borderRadius: BorderRadius.circular(
                                                                                  2)),
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30),
                                                                      // IconButton(
                                                                      //     onPressed:
                                                                      //         () {
                                                                      //       setState(
                                                                      //           () {
                                                                      //         if (
                                                                      //           snapshot.data.docs[index]['quanity'] >=
                                                                      //             2) {
                                                                      //           snapshot.data.docs[index]['quanity']--;
                                                                      //         }
                                                                      //       });
                                                                      //     },
                                                                      //     icon: Icon(
                                                                      //         Icons.remove_circle_outline)),
                                                                    ],
                                                                  ),
                                                                  height: 60,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                        color: Colors.grey[200],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5)),
                                                              color:
                                                                  kBackgroundColor,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            FirebaseFirestore.instance.collection("users").doc(MRANDMRS.sharedprefs.getString("uid")).collection("cart").doc(snapshot.data.docs[index]["id"]).delete();

                                                                            setState(() {
                                                                              cartno = cartvalueno();
                                                                              totalAmount = totalAmount - snapshot.data.docs[index]['price'] * snapshot.data.docs[index]['quanity'];
                                                                            });

                                                                            //   .get()
                                                                            //   .then((value) {
                                                                            // if (value.exists) {
                                                                            //   print("Already In Cart");
                                                                            // } else {
                                                                            //   FirebaseFirestore.instance.collection("users").doc(MRANDMRS.sharedprefs.getString("uid")).collection("cart").doc(snapshot.data.docs[index]['id']).set({
                                                                            //     "Description": snapshot.data.docs[index]['Description'],
                                                                            //     "price": snapshot.data.docs[index]['price'],
                                                                            //     "oprice": snapshot.data.docs[index]['oprice'],
                                                                            //     "category": snapshot.data.docs[index]['category'],
                                                                            //     "name": snapshot.data.docs[index]['name'],
                                                                            //     "id": snapshot.data.docs[index]['id'],
                                                                            //     "mainimage": snapshot.data.docs[index]['mainimage'],
                                                                            //     "quanity": 1,
                                                                            //     "wood": ""
                                                                            //   });
                                                                            // }
                                                                            // }
                                                                            // );
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.remove_shopping_cart_outlined,
                                                                            color:
                                                                                Colors.white,
                                                                          )),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            FirebaseFirestore.instance.collection("users").doc(MRANDMRS.sharedprefs.getString("uid")).collection("wishlist").doc(snapshot.data.docs[index]['id']).set({
                                                                              "height": snapshot.data.docs[index]['height'],
                                                                              'width': snapshot.data.docs[index]['width'],
                                                                              "depth": snapshot.data.docs[index]['depth'],
                                                                              "weight": snapshot.data.docs[index]['weight'],
                                                                              "warranty": snapshot.data.docs[index]['warranty'],
                                                                              "Description": snapshot.data.docs[index]['Description'],
                                                                              "price": snapshot.data.docs[index]['price'],
                                                                              "oprice": snapshot.data.docs[index]['oprice'],
                                                                              "category": snapshot.data.docs[index]['category'],
                                                                              "name": snapshot.data.docs[index]['name'],
                                                                              "id": snapshot.data.docs[index]['id'],
                                                                              "mainimage": snapshot.data.docs[index]['mainimage'],
                                                                              "quanity": 1,
                                                                              "wood": ""
                                                                            });
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.favorite_outline_sharp,
                                                                            color:
                                                                                Colors.white,
                                                                          )),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                  ],
                ),
              ),
            ),
    );
  }
}
