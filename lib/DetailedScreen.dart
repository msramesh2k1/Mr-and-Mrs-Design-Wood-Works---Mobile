import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/CartPage.dart';
import 'package:mr_and_mrs/CustomDialog.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/Stepper.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:mr_and_mrs/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:mr_and_mrs/cartvalue.dart';

import 'ErrorAlert.dart';
import 'controllers/cart_controller.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel productlist;

  const DetailScreen({Key key, this.productlist}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // String imgurl;
  String woodtype = " ";
  int quanityvalue = 1;
  int cartno = 0;
  bool isincart = false;

  @override
  void initState() {
    //    final cartysnapshot = FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(MRANDMRS.sharedprefs.getString("uid"))
    //       .collection("cart")
    //       .doc(widget.queryDocumentSnapshot['id'])
    //       .get()
    //       .then((value) {
    //     if (value.exists) {
    //       setState(() {
    //         isincart = true;
    //       });
    //     }
    //     else
    //     {
    //       isincart = false;
    //     }
    //   });

    //   FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(MRANDMRS.sharedprefs.getString("uid"))
    //       .collection("cart")
    //       .get()
    //       .then((QuerySnapshot querySnapshot) {
    //     if (mounted) {
    //       setState(() {
    //         cartno = querySnapshot.docs.length;
    //       });
    //     }
    //   });
    //   String _imgurl = widget.queryDocumentSnapshot["mainimage"];
    //   super.initState();
    //   if (mounted) {
    //     setState(() {
    //       imgurl = _imgurl;
    //     });
    //   }
    // }

    // int cartvalueno() {
    //   FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(MRANDMRS.sharedprefs.getString("uid"))
    //       .collection("cart")
    //       .get()
    //       .then((QuerySnapshot querySnapshot) {
    //     if (mounted) {
    //       setState(() {
    //         cartno = querySnapshot.docs.length;
    //       });
    //     }
    //   });
    //   return cartno;
  }

  @override
  Widget build(BuildContext context) {
//       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarIconBrightness: Brightness.dark
//  ));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => StepperCart());
          Navigator.push(context, route);
        },
        backgroundColor: Colors.orange[400],
        child: Stack(children: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
          Positioned(
            right: 7,
            top: 7,
            child: CircleAvatar(
              child: Consumer<CartController>(builder: (context, value, __) {
                return Text(
                  value.cartvalue.toString(),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                );
              }),
              backgroundColor: Colors.red[900],
              radius: 8,
            ),
          ),
        ]),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_sharp,
                              color: kBackgroundColor, size: 15)),
                      Text(
                        widget.productlist.title,
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: kBackgroundColor,
                              fontSize: 20,
                              letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        child: Row(
                          children: [
                            Text(
                              widget.productlist.category.toUpperCase() +
                                  "  >  " +
                                  widget.productlist.title.toUpperCase(),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13,
                                    letterSpacing: 0.5),
                              ),
                            ),
                            Text(
                              "  / PRODUCT NO : " +
                                  widget.productlist.id.toString(),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                    fontSize: 14,
                                    letterSpacing: 2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(widget.productlist.url),
                              fit: BoxFit.contain),
                          color: Colors.transparent,
                        ),
                        height: 250,
                        // width: 450,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   height: 80,
                      //   child: StreamBuilder(
                      //       stream: FirebaseFirestore.instance
                      //           .collection("Items")
                      //           .doc(widget.queryDocumentSnapshot["category"]
                      //               .toString())
                      //           .collection("Products")
                      //           .doc(widget.queryDocumentSnapshot["id"]
                      //               .toString())
                      //           .collection("Images")
                      //           .snapshots(),
                      //       builder: (context, snapshot) {
                      //         if (!snapshot.hasData) {
                      //           return Text(
                      //             'No Data...',
                      //           );
                      //         } else {
                      //           return Scrollbar(
                      //             child: ListView.builder(
                      //                 scrollDirection: Axis.horizontal,
                      //                 itemCount: snapshot.data.docs.length,
                      //                 itemBuilder:
                      //                     (BuildContext context, int index) {
                      //                   return Padding(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     child: GestureDetector(
                      //                       onTap: () {
                      //                         setState(() {
                      //                           imgurl = snapshot
                      //                               .data.docs[index]['imgurl'];
                      //                           print(imgurl);
                      //                         });
                      //                       },
                      //                       child: Container(
                      //                         width: 80,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius:
                      //                                 BorderRadius.circular(5),
                      //                             color: Colors.red,
                      //                             image: DecorationImage(
                      //                                 image: NetworkImage(
                      //                                     snapshot.data
                      //                                             .docs[index]
                      //                                         ['imgurl']),
                      //                                 fit: BoxFit.cover)),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }),
                      //           );
                      //         }
                      //       }),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     color: Colors.grey[200],
                      //   ),
                      // )
                    ],
                  ),
                ),
                detailselemnt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailselemnt(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              widget.productlist.title,
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 19,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              widget.productlist.title,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontSize: 14,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(height: 9),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(2)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 5, bottom: 5),
                child: Text(
                  widget.productlist.category.toUpperCase(),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(height: 4),
                    Text(
                      "₹",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
                // Text(
                //   widget.queryDocumentSnapshot["price"].toString(),
                //   style: GoogleFonts.lato(
                //     textStyle: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black,
                //         fontSize: 19,
                //         letterSpacing: 0),
                //   ),
                // ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(height: 4),
                    Text(
                      "₹",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            // decoration:TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
                // Text(
                //   widget.queryDocumentSnapshot["oprice"].toString(),
                //   style: GoogleFonts.lato(
                //     textStyle: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         decoration: TextDecoration.lineThrough,
                //         color: Colors.black54,
                //         fontSize: 12,
                //         letterSpacing: 0),
                //   ),
                // ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "(Inclusive of all Taxes)",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 12,
                        letterSpacing: 0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   height: 140,
            //   child: StreamBuilder(
            //       stream: FirebaseFirestore.instance
            //           .collection("Items")
            //           .doc(widget.queryDocumentSnapshot['category'])
            //           .collection("Products")
            //           .doc(widget.queryDocumentSnapshot["id"].toString())
            //           .collection("WoodList")
            //           .snapshots(),
            //       builder: (context, snapshot) {
            //         if (snapshot.data == null) {
            //           return Center(
            //             child: Text(
            //               'Loading',
            //             ),
            //           );
            //         } else {
            //           return Scrollbar(
            //             child: ListView.builder(
            //                 scrollDirection: Axis.horizontal,
            //                 itemCount: snapshot.data.docs.length,
            //                 itemBuilder: (BuildContext context, int index) {
            //                   return Padding(
            //                     padding: const EdgeInsets.all(10.0),
            //                     child: GestureDetector(
            //                       onTap: () {
            //                         setState(() {
            //                           woodtype =
            //                               snapshot.data.docs[index]['name'];
            //                         });
            //                         print(woodtype);
            //                       },
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                             color: Colors.white,
            //                             borderRadius: BorderRadius.circular(5)),
            //                         height: 80,
            //                         width: 80,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.start,
            //                           children: [
            //                             Container(
            //                               decoration: BoxDecoration(
            //                                   color: Colors.white,
            //                                   image: DecorationImage(
            //                                       image: NetworkImage(snapshot
            //                                           .data
            //                                           .docs[index]['image']),
            //                                       fit: BoxFit.cover),
            //                                   borderRadius:
            //                                       BorderRadius.circular(5)),
            //                               height: 70,
            //                             ),
            //                             Center(
            //                               child: Text(
            //                                 snapshot.data.docs[index]['name']
            //                                     .toUpperCase(),
            //                                 style: GoogleFonts.lato(
            //                                   textStyle: TextStyle(
            //                                       fontWeight: FontWeight.w900,
            //                                       color: Colors.black,
            //                                       fontSize: 10,
            //                                       letterSpacing: 1),
            //                                 ),
            //                               ),
            //                             ),
            //                             Radio(
            //                                 activeColor: Colors.green[900],
            //                                 splashRadius: 20,
            //                                 materialTapTargetSize:
            //                                     MaterialTapTargetSize
            //                                         .shrinkWrap,
            //                                 autofocus: false,
            //                                 value: snapshot.data.docs[index]
            //                                     ['name'],
            //                                 groupValue: woodtype,
            //                                 onChanged: (val) {
            //                                   setState(() {
            //                                     woodtype = val;
            //                                   });
            //                                 })
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 }),
            //           );
            //         }
            //       }),
            //   decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(5)),
            // ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Quantity",
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          // quanityvalue++;
                        });
                      },
                      icon: Icon(Icons.add_circle_outline)),
                  Container(
                      child: Center(
                        child: Text(
                          quanityvalue.toString(),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2)),
                      height: 30,
                      width: 30),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (quanityvalue >= 2) {
                            quanityvalue--;
                          }
                        });
                      },
                      icon: Icon(Icons.remove_circle_outline)),
                ],
              )),
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 510,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "PRODUCT DETAILS",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        textDirection: TextDirection.ltr,
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border:
                            TableBorder.all(width: 0.5, color: Colors.black54),
                        children: [
                          TableRow(children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "BRAND",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "MR AND MRS",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "DIMENSIONS",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  " H " +
                                      widget.productlist.height.toString() +
                                      " * W " +
                                      widget.productlist.width.toString() +
                                      " * D " +
                                      widget.productlist.dimension.toString()
                                  // " (In Inches)",
                                  ,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 12,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "WEIGHT",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        widget.productlist.finish + " kg",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "WARRANTY",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        // child: Text(
                                        //   widget.queryDocumentSnapshot[
                                        //           'warranty'] +
                                        //       " Months Warranty",
                                        //   style: GoogleFonts.lato(
                                        //     textStyle: TextStyle(
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.black54,
                                        //         fontSize: 12,
                                        //         letterSpacing: 1),
                                        //   ),
                                        // ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "MATERIAL",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "ENGINEERED WOOD",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "ROOM TYPE",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "LIVING ROOM",
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "ADDITIONAL INFO",
                                  descriptions:
                                      "Accessories shown in the image are only for representation and are not part of the product.Depending on your screen settings and resolution on your device there may be a slight variance in fabric color and wood polish of the image and actual product.Wood grains will vary from product to product in case of solid wood furniture.Furniture having intricate hand-painted details are individual unique pieces and may have slight distinctions and variance between the picture and actual product.The Primary material is the main material used to manufacture the product and in addition to the primary material there might also be other type of materials used in the manufacturing of the product",
                                  text: "Yes",
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "ADDITIONAL INFO",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    ">",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 22,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "WARRANTY & INSTALLATION",
                                  descriptions:
                                      "Assembly: Carpenter Assembly Warranty  Terms:The warranty, as mentioned, on the product is provided by the Merchant.The product comes with a 12 Months warranty against any manufacturing defect under normal household conditions.What is not covered under this warranty?This limited warranty does not apply to:normal wear and tear cuts or scratches, or damage caused by impacts or accidents products that have been stored, assembled or installed incorrectly, used inappropriately,or cleaned using the wrong cleaning methods or cleaning products. (eg upholstered furniture will lighten over time if it's exposed to direct sunlight) No warranty on upholstery/ coverings/ cushion covers Warranty Contact: In case of any issues, please reach out to us : Phone No: 022 6157 6157",
                                  text: "Yes",
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "WARRANTY & INSTALLATION",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    ">",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 22,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "CARE",
                                  descriptions:
                                      "Try and use a tablecloth or any thick quality cloth on your dining table or any other table which is subject to daily and heavy use.Do not keep warm or cold items directly on a furniture surface; instead use a hot pad or coasters; please do not keep hot items like a tawa or baking dish even on a hot pad.To protect your furniture from fading, avoid keeping your furniture next to windows and other places where it can be exposed to direct sunlight.To avoid minor scratches which may hamper the finish of your furniture avoid sliding or passing items placed on your tabletop.Avoid placing items like burning candles or irons on any furniture as the heat generated from them may affect the life of your furniture in the long run, make use of candle holders to avoid melting wax touching the furniture.Cleaning your furniture items regularly will help you maintain them for a long time, make sure that you clean your furniture gently with a soft lightly damp cloth; using a rough rag and pressing it hard against the wood might lead to minor scratches.In case of a spill on the furniture, never try to wipe it as it will spread the spill and hamper the polish, instead just blot the spill."
                                          .toUpperCase(),
                                  text: "Yes",
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "CARE",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    ">",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 22,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // height:500,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  // if (isincart) {
                  //   setState(() {
                  //     isincart = false;
                  //   });

                  //   FirebaseFirestore.instance
                  //       .collection("users")
                  //       .doc(MRANDMRS.sharedprefs.getString("uid"))
                  //       .collection("cart")
                  //       .doc(widget.queryDocumentSnapshot["id"])
                  //       .delete();
                  // } else {
                  //   if (woodtype == " ") {
                  //     showDialog(
                  //         context: context,
                  //         builder: (c) {
                  //           return ErrorAlertDialog(message: "SELECT WOOD");
                  //         });
                  //   } else {
                  //     setState(() {
                  //       isincart = true;
                  //     });
                  //     FirebaseFirestore.instance
                  //         .collection("users")
                  //         .doc(MRANDMRS.sharedprefs.getString("uid"))
                  //         .collection("cart")
                  //         .doc(widget.queryDocumentSnapshot["id"])
                  //         .set({
                  //       //       "height":widget.queryDocumentSnapshot['height'],
                  //       //       'width':widget.queryDocumentSnapshot['width'],
                  //       //       "depth":widget.queryDocumentSnapshot['depth'],
                  //       //       "weight":widget.queryDocumentSnapshot['weight'],
                  //       //       "warranty":widget.queryDocumentSnapshot['warranty'],

                  //       "Description":
                  //           widget.queryDocumentSnapshot["Description"],
                  //       // "price": widget.queryDocumentSnapshot["price"],
                  //       // "oprice": widget.queryDocumentSnapshot["oprice"],
                  //       // "category": widget.queryDocumentSnapshot["category"],
                  //       "name": widget.queryDocumentSnapshot["name"],
                  //       "id": widget.queryDocumentSnapshot["id"],
                  //       "mainimage": widget.queryDocumentSnapshot["mainimage"],
                  //       "quanity": quanityvalue,
                  //       "wood": woodtype
                  //     });
                  //   }
                  // }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        isincart ? "REMOVE ITEM" : "ADD TO CART",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  // FirebaseFirestore.instance
                  //     .collection("users")
                  //     .doc(MRANDMRS.sharedprefs.getString("uid"))
                  //     .collection("wishlist")
                  //     .doc(widget.queryDocumentSnapshot["id"])
                  //     .set({
                  //   "height": widget.queryDocumentSnapshot['height'],
                  //   'width': widget.queryDocumentSnapshot['width'],
                  //   "depth": widget.queryDocumentSnapshot['depth'],
                  //   "weight": widget.queryDocumentSnapshot['weight'],
                  //   "warranty": widget.queryDocumentSnapshot['warranty'],
                  //   "Description": widget.queryDocumentSnapshot["Description"],
                  //   "price": widget.queryDocumentSnapshot["price"],
                  //   "oprice": widget.queryDocumentSnapshot["oprice"],
                  //   "category": widget.queryDocumentSnapshot["category"],
                  //   "name": widget.queryDocumentSnapshot["name"],
                  //   "id": widget.queryDocumentSnapshot["id"],
                  //   "mainimage": widget.queryDocumentSnapshot["mainimage"],
                  //   "quanity": quanityvalue,
                  //   "wood": woodtype
                  // });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[600],
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "ADD TO WISHLIST",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Related Products",
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   height: 180,
            //   child: StreamBuilder(
            //       stream: FirebaseFirestore.instance
            //           .collection("SearchProducts")
            //           .where("category",
            //               isEqualTo: widget.queryDocumentSnapshot["category"])
            //           .snapshots(),
            //       builder: (context, snapshot) {
            //         if (!snapshot.hasData) {
            //           return Text(
            //             'No Data...',
            //           );
            //         } else {
            //           return Scrollbar(
            //             child: ListView.builder(
            //                 scrollDirection: Axis.horizontal,
            //                 itemCount: snapshot.data.docs.length,
            //                 itemBuilder: (BuildContext context, int index) {
            //                   return Padding(
            //                     padding: const EdgeInsets.all(10.0),
            //                     child: GestureDetector(
            //                       onTap: () {
            //                         Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                                 builder: (context) => DetailScreen(
            //                                     queryDocumentSnapshot: snapshot
            //                                         .data.docs[index])));
            //                       },
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                             color: Colors.white,
            //                             borderRadius: BorderRadius.circular(5)),
            //                         width: 150,
            //                         child: Column(
            //                           children: [
            //                             Container(
            //                               height: 142,
            //                               width: 260,
            //                               decoration: BoxDecoration(
            //                                   borderRadius:
            //                                       BorderRadius.circular(5),
            //                                   color: Colors.red,
            //                                   image: DecorationImage(
            //                                       image: NetworkImage(
            //                                           snapshot.data.docs[index]
            //                                               ['mainimage']),
            //                                       fit: BoxFit.cover)),
            //                             ),
            //                             Center(
            //                               child: Text(
            //                                   snapshot.data.docs[index]['name']
            //                                       .toUpperCase(),
            //                                   style: GoogleFonts.lato(
            //                                     textStyle: TextStyle(
            //                                         fontWeight: FontWeight.w900,
            //                                         color: Colors.black,
            //                                         fontSize: 12,
            //                                         letterSpacing: 1),
            //                                   )),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 }),
            //           );
            //         }
            //       }),
            // decoration: BoxDecoration(
            // color: Colors.white, borderRadius: BorderRadius.circular(5)),
            // ),
            SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      Divider(color: Colors.black54),
                      Text(
                        "MR AND MRS",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 8,
                              letterSpacing: 1),
                        ),
                      ),
                      Text(
                        "DESIGN WOOD WORKS",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 6,
                              letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 50)
          ],
        ),
      ),
    );
  }
}
