import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/DetailedScreen.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:provider/provider.dart';

import 'models/product_model.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> productList = Provider.of<List<ProductModel>>(context);
//           SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarIconBrightness: Brightness.dark
//  ));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp,
                color: kBackgroundColor, size: 12)),
        leadingWidth: 25,
        title: Text(
          "Mr & Mrs / ",
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: kBackgroundColor,
                fontSize: 18,
                letterSpacing: 1),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height - 96,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    //  gridDelegate:
                    //      SliverGridDelegateWithFixedCrossAxisCount(
                    //          crossAxisCount: 1),
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 340,
                              decoration: BoxDecoration(
                                  //border: Border.all(color: kBackgroundColor,width: 0.5),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                productList[index].url),
                                            fit: BoxFit.contain)),
                                  ),
                                  Container(
                                    height: 117,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      color: Colors.brown[100].withOpacity(0.5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Center(
                                                child: Text(
                                                  productList[index].title,
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        letterSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Center(
                                                    child: Text(
                                                      "₹ " +
                                                          productList[index]
                                                              .price
                                                              .toString(),
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            letterSpacing: 0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: Text(
                                                    "₹ " +
                                                        productList[index]
                                                            .oriprice
                                                            .toString(),
                                                    style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Colors.black54,
                                                          fontSize: 15,
                                                          letterSpacing: 0),
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
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 5),
                                              child: Center(
                                                child: Text(
                                                  productList[index]
                                                      .category
                                                      .toUpperCase(),
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black54,
                                                        fontSize: 17,
                                                        letterSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              height: 47,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5)),
                                                  color: kBackgroundColor),
                                              child: Center(
                                                child: Text(
                                                  "VIEW PRODUCT",
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        letterSpacing: 1),
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
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
