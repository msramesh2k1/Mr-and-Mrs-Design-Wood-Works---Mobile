import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_and_mrs/userScreen.dart';

import 'CartPage.dart';
import 'Helper.dart';
import 'Search.dart';
import 'categorypage.dart';

class shopbycategory extends StatefulWidget {
  @override
  _shopbycategoryState createState() => _shopbycategoryState();
}

class _shopbycategoryState extends State<shopbycategory> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 0, left: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "MR AND MRS",
                            style: GoogleFonts.yatraOne(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                  fontSize: 20,
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return userScren();
                            }));
                          },
                          child: Icon(Icons.account_circle_outlined,
                              color: Colors.black54, size: 20)),
                      SizedBox(width: 14),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Search();
                          }));
                        },
                        child:
                            Icon(Icons.search, color: Colors.black54, size: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return userScren();
                            }));
                          },
                          child: Icon(Icons.favorite_outline_rounded,
                              color: Colors.black54, size: 20)),
                      GestureDetector(
                        onTap: () {},
                        child: Stack(children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return cart();
                                }));
                              },
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                size: 20,
                                color: Colors.black54,
                              )),
                          Positioned(
                            right: 7,
                            top: 7,
                            child: CircleAvatar(
                              child: Text(
                                cartvalueno().toString(),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.red[900],
                              radius: 8,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(width: 1)
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Center(
                child: Text(
                  "SHOP BY CATEGORY".toUpperCase(),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontSize: 15,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 128,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Items")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'No Data...',
                      );
                    } else {
                      return Scrollbar(
                        //   isAlwaysShown: true,
                        //   controller: _scrollController,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //     crossAxisCount: 1),
                            //   controller: _scrollController,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => categorypage(
                                                  queryDocumentSnapshot:
                                                      snapshot.data.docs[index],
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 13),
                                            Center(
                                              child: Text(
                                                snapshot
                                                    .data.docs[index]['name']
                                                    .toUpperCase(),
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black54,
                                                      fontSize: 15,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.arrow_forward_ios,
                                                size: 16,
                                                color: Colors.black54),
                                            SizedBox(width: 13)
                                          ],
                                        )
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
        ],
      ),
    );
  }
}
