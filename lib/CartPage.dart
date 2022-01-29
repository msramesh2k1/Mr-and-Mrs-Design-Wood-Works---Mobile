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
                                                    color: Colors.grey[100],
                                                    // border: Border.all(
                                                    //     color: Colors.black),
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
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  top: 10),
                                                          child: Container(
                                                            height: 100,
                                                            width: 100,
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
                                                                        'url']),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 16,
                                                              ),
                                                              Text(
                                                                snapshot.data
                                                                            .docs[
                                                                        index]
                                                                    ['title'],
                                                                style: GoogleFonts
                                                                    .josefinSans(
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
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Container(
                                                                height: 25,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    180,
                                                                child: Text(
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      ['info'],
                                                                  style: GoogleFonts
                                                                      .josefinSans(
                                                                    textStyle: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            0),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        "QUANTITY : ",
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          textStyle: TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              color: Colors.black54,
                                                                              fontSize: 12,
                                                                              letterSpacing: 1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            snapshot.data.docs[index]['quanity'].toString(),
                                                                            style:
                                                                                GoogleFonts.lato(
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
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                                height: 50,
                                                                width: 120,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      right:
                                                                          8.0,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "₹ " +
                                                                            snapshot.data.docs[index]['price'].toString(),
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          textStyle: TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              color: Colors.black,
                                                                              fontSize: 15,
                                                                              letterSpacing: 0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10.0,
                                                                        top: 0),
                                                                    child: Text(
                                                                      "₹ " +
                                                                          snapshot
                                                                              .data
                                                                              .docs[index]["oprice"]
                                                                              .toString(),
                                                                      style: GoogleFonts
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
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Wood : " +
                                                                        snapshot
                                                                            .data
                                                                            .docs[index]['wood'],
                                                                    style: GoogleFonts
                                                                        .josefinSans(
                                                                      textStyle: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color: Colors
                                                                              .black54,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                  height: 1,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      176,
                                                                  color: Colors
                                                                      .black12),
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                      "Remove   ",
                                                                      style: GoogleFonts
                                                                          .josefinSans(
                                                                        textStyle: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w800,
                                                                            color: Colors
                                                                                .black54,
                                                                            fontSize:
                                                                                17,
                                                                            letterSpacing:
                                                                                0),
                                                                      )),
                                                                  height: 40,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      176,
                                                                  color: Colors
                                                                      .transparent)
                                                            ],
                                                          ),
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
                  ],
                ),
              ),
            ),
    );
  }
}
