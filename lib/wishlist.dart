import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/DetailedScreen.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/constants.dart';

class wishlist extends StatefulWidget {
  // wishlist({this.queryDocumentSnapshot});
  @override
  _wishlistState createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
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
        title: Text(
          "WishList",
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: kBackgroundColor,
                fontSize: 18,
                letterSpacing: 1),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height - 96,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(MRANDMRS.sharedprefs.getString("uid"))
                        .collection("wishlist")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'No Data...',
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            //  gridDelegate:
                            //      SliverGridDelegateWithFixedCrossAxisCount(
                            //          crossAxisCount: 1),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                //  queryDocumentSnapshot:
                                                //      snapshot
                                                //          .data.docs[index],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 340,
                                      decoration: BoxDecoration(
                                          //border: Border.all(color: kBackgroundColor,width: 0.5),
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                            .data.docs[index]
                                                        ['mainimage']),
                                                    fit: BoxFit.contain)),
                                          ),
                                          Container(
                                            height: 130,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5)),
                                              color: Colors.teal[100]
                                                  .withOpacity(0.5),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['name'],
                                                          style: GoogleFonts
                                                              .josefinSans(
                                                            textStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Center(
                                                            child: Text(
                                                              "??? " +
                                                                  snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                          [
                                                                          'price']
                                                                      .toString(),
                                                              style: GoogleFonts
                                                                  .lato(
                                                                textStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10.0),
                                                          child: Text(
                                                            "??? " +
                                                                snapshot
                                                                    .data
                                                                    .docs[index]
                                                                        [
                                                                        "oprice"]
                                                                    .toString(),
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              top: 5),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data
                                                              .docs[index]
                                                                  ['category']
                                                              .toUpperCase(),
                                                          style:
                                                              GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 9, left: 8),
                                                      child: Center(
                                                        child: Text(
                                                          "PRODUCT NO : " +
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                      ['id']
                                                                  .toUpperCase(),
                                                          style:
                                                              GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 10,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                  height: 0.5,
                                                  color: kBackgroundColor,
                                                ),
                                                // SizedBox(height: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(MRANDMRS
                                                            .sharedprefs
                                                            .getString("uid"))
                                                        .collection("wishlist")
                                                        .doc(snapshot.data
                                                            .docs[index]["id"])
                                                        .delete();
                                                  },
                                                  child: Container(
                                                      height: 47,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5)),
                                                          color:
                                                              kBackgroundColor),
                                                      child: Center(
                                                        child: Text(
                                                          "-  REMOVE FROM WISHLIST",
                                                          style:
                                                              GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color:
                                                                    kCaptionColor,
                                                                fontSize: 17,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
