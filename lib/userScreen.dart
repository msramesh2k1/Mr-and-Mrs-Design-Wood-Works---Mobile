import 'package:flutter/material.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/MainScreen.dart';
import 'package:mr_and_mrs/Orders.dart';
import 'package:mr_and_mrs/constants.dart';

import 'Admin.dart';
import 'CartPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '_address.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
      appBar: AppBar(
        elevation: 0,
        // actionsIconTheme: IconThemeData(color: Colors.white),
        actions: [
          // GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           new MaterialPageRoute(builder: (BuildContext context) {
          //         return UserScreen();
          //       }));
          //     },
          //     child: Icon(Icons.account_circle_outlined, size: 20)),
          SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context)
          //         .push(new MaterialPageRoute(builder: (BuildContext context) {
          //       return Search();
          //     }));
          //   },
          //   child: Icon(Icons.search, size: 20),
          // ),
          SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).push(
          //           new MaterialPageRoute(builder: (BuildContext context) {
          //         return UserScreen();
          //       }));
          //     },
          //     child: Icon(Icons.favorite_outline_rounded, size: 20)),
          Column(
            children: [
              SizedBox(
                height: 3,
              ),
              GestureDetector(
                onTap: () {},
                child: Stack(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return cart();
                        }));
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                        size: 20,
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
            ],
          ),
        ],
        leading: Row(
          children: [
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,
                    color: kBackgroundColor, size: 15)),
          ],
        ),
        leadingWidth: 25,
        title: Text(
          "Account Details",
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: kBackgroundColor,
                fontSize: 19,
                letterSpacing: 1),
          ),
        ),

        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                    // color:Colors.blueGrey[100]
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Email :  " +
                                  FirebaseAuth.instance.currentUser.email,
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 20,
                                    letterSpacing: 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.brown[50].withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => Orders());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "Orders",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 17,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => Admin());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "Wishlist",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 17,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route =
                                MaterialPageRoute(builder: (context) => cart());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "Cart",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 17,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => maineraddress());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "Address",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 17,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Route route = MaterialPageRoute(
                                builder: (context) => MainScreen());
                            Navigator.pushReplacement(context, route);
                            MRANDMRS.sharedprefs.remove("uid");
                          },
                          child: Text(
                            "Sign Out",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 17,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
