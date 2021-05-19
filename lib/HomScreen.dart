import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'checkout.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mr_and_mrs/Admin.dart';
import 'package:mr_and_mrs/CartPage.dart';
import 'package:mr_and_mrs/Stepper.dart';
import 'package:mr_and_mrs/categorypage.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:mr_and_mrs/maincategory.dart';
import 'package:mr_and_mrs/userScreen.dart';
import 'package:mr_and_mrs/wishlist.dart';
import 'DetailedScreen.dart';
import 'Helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  ScrollController pagecontroller = ScrollController();
  bool fabisVisible = true;
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
    pagecontroller = ScrollController();
    pagecontroller.addListener(() {
      setState(() {
        fabisVisible = pagecontroller.position.userScrollDirection ==
            ScrollDirection.forward;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? smallscreen()
            : largescreen();
      },
    );
  }

  Widget largescreen() {
    return Scaffold(
        floatingActionButton: AnimatedOpacity(
          duration: Duration(milliseconds: 100),
          opacity: fabisVisible ? 0 : 1,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blueGrey[500],
            child: IconButton(
                onPressed: () {
                  pagecontroller.animateTo(0,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOut);
                },
                icon: Icon(Icons.arrow_upward_sharp)),
          ),
        ),
        body: SingleChildScrollView(
          controller: pagecontroller,
          child: Container(
            color: Colors.white,
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Mr & Mrs",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kBackgroundColor,
                              fontSize: 22,
                              letterSpacing: 0),
                        ),
                      ),
                      Text(
                        "Design Wood Works".toUpperCase(),
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: kBackgroundColor,
                              fontSize: 8,
                              letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Center(
                            child: Text(
                              "Search Products",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.teal[50].withOpacity(0.4)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return userScren();
                            }));
                          },
                          child: Icon(Icons.account_circle_outlined, size: 20)),
                      SizedBox(
                        width: 10,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //         new MaterialPageRoute(builder: (BuildContext context) {
                      //       return Search();
                      //     }));
                      //   },
                      //   child: Icon(Icons.search, size: 20),
                      // ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Column(
                        children: [
                          SizedBox(
                            height: 0,
                          ),
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
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                child: Container(
                  // height: 161,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 60,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Items")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                'Loading',
                              ),
                            );
                          } else {
                            return Scrollbar(
                              //   isAlwaysShown: true,
                              controller: _scrollController,
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        height: 4,
                                        color: Colors.black,
                                        width: 0.5,
                                      ),
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  // gridDelegate:
                                  //     SliverGridDelegateWithFixedCrossAxisCount(
                                  //         crossAxisCount: 1),
                                  controller: _scrollController,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 10, bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      categorypage(
                                                        queryDocumentSnapshot:
                                                            snapshot.data
                                                                .docs[index],
                                                      )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              //   color: Colors.teal[50].withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 120,
                                          width: 80,
                                          child: Container(
                                            height: 55,
                                            //  width: 270,
                                            child: Center(
                                              child: Text(
                                                snapshot.data.docs[index]
                                                    ['name'],
                                                style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 1, bottom: 8),
                child: Container(
                  height: 65,
                  child: Center(
                    child: Text(
                      "Qualified Furnitures * Free & Fast Installation ",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 17,
                            letterSpacing: 0),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 0.5,
                    ),
                    // color: Colors.teal[50].withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                child: SizedBox(
                    height: 350.0,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Poster")
                            .limit(10)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(
                              'Loading',
                            );
                          } else {
                            return Carousel(
                              images: [
                                NetworkImage(snapshot.data.docs[0]["image"]),
                                NetworkImage(snapshot.data.docs[1]["image"]),
                                NetworkImage(snapshot.data.docs[2]["image"]),
                              ],
                              dotSize: 2.0,
                              dotSpacing: 12.0,
                              dotColor: Colors.amber,
                              indicatorBgPadding: 5.0,
                              dotBgColor: Colors.transparent,
                              borderRadius: true,
                            );
                          }
                        })),
              ),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Stay Safe, Stay Home",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                                letterSpacing: 0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50, top: 50),
                          child: Text(
                            "To comply with the norms, we will continue to serve and fulfill your home furnishing needs in a safer manner through online shopping at IKEA.in. Use our remote planning services and try Click & Collect, our contactless shopping service. Mumbai and Pune customers can shop online, the deliveries will resume once the government restrictions are lifted. ",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.teal[50].withOpacity(0.4),
                  height: 300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Trending Items",
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    //TODO
                    // Navigator.of(context).push(
                    //     new MaterialPageRoute(builder: (BuildContext context) {
                    //   return shopbycategory();
                    // }));
                  },
                  child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "See All ",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 1),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      height: 15),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.teal[50].withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5)),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("SearchProducts")
                          .where("trend", isEqualTo: "true")
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
                            //   isAlwaysShown: true,
                            controller: _scrollController,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                // gridDelegate:
                                //     SliverGridDelegateWithFixedCrossAxisCount(
                                //         crossAxisCount: 1),
                                controller: _scrollController,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      queryDocumentSnapshot:
                                                          snapshot
                                                              .data.docs[index],
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        height: 380,
                                        //   width: 220,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 348,
                                              width: 370,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['mainimage']),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Center(
                                              child: Text(
                                                snapshot
                                                    .data.docs[index]['name']
                                                    .toUpperCase(),
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      letterSpacing: 1),
                                                ),
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
              SizedBox(
                height: 20,
              ),
              Text(
                "Explore By Category",
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 0),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 1.0, top: 3),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 250,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Items")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(
                              'Loading',
                            );
                          } else {
                            return Scrollbar(
                              //   isAlwaysShown: true,
                              controller: _scrollController,
                              child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1),
                                  controller: _scrollController,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      categorypage(
                                                        queryDocumentSnapshot:
                                                            snapshot.data
                                                                .docs[index],
                                                      )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.teal[50]
                                              //     .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 80,
                                          width: 210,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child: Container(
                                                  height: 130,
                                                  width: 260,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  Colors.grey[
                                                                      800],
                                                                  BlendMode
                                                                      .srcATop),
                                                          image: NetworkImage(
                                                              snapshot.data
                                                                          .docs[
                                                                      index]
                                                                  ['image']),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              Center(
                                                child: Text(
                                                  snapshot
                                                      .data.docs[index]['name']
                                                      .toUpperCase(),
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        letterSpacing: 1),
                                                  ),
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

              SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => userScren()));
                  },
                  child: SizedBox(
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[100].withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Setup Account Settings",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kBackgroundColor,
                                  fontSize: 18,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              //  Padding(
              //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              //   child: Container(
              //       child: Center(
              //         child: Text(
              //           "SET UP ACCOUNT SEETINGS",
              //           style: GoogleFonts.lato(
              //             textStyle: TextStyle(
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.black54,
              //                 fontSize: 14,
              //                 letterSpacing: 2),
              //           ),
              //         ),
              //       ),
              //       decoration: BoxDecoration(
              //           color: Colors.blueGrey[100].withOpacity(0.4),
              //           borderRadius: BorderRadius.circular(5)),
              //       height: 80),
              // ),

              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14.0, right: 8.0, top: 9),
                    child: Text(
                      "CATEGORY",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //     new MaterialPageRoute(builder: (BuildContext context) {
                    //   return shopbycategory();
                    // }));
                  },
                  child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "SEE ALL ",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 1),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      height: 15),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.white,
              //     height: 210,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 1.0, right: 1.0),
              //       child: Container(
              //         height: 210,
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Container(
              //           height: 110,
              //           child: StreamBuilder(
              //               stream: FirebaseFirestore.instance
              //                   .collection("Poster")
              //                   .snapshots(),
              //               builder: (context, snapshot) {
              //                 if (!snapshot.hasData) {
              //                   return Text(
              //                     'Loading',
              //                   );
              //                 } else {
              //                   return Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceEvenly,
              //                     children: [
              //                       Container(
              //                         height: 210,
              //                         width: 150,
              //                         decoration: BoxDecoration(
              //                             borderRadius:
              //                                 BorderRadius.circular(5),
              //                             color: Colors.grey[200],
              //                             image: DecorationImage(
              //                                 image: NetworkImage(snapshot
              //                                     .data.docs[0]['image']),
              //                                 fit: BoxFit.cover)),
              //                       ),
              //                       Container(
              //                         height: 210,
              //                         width: 150,
              //                         decoration: BoxDecoration(
              //                             borderRadius:
              //                                 BorderRadius.circular(5),
              //                             color: Colors.grey[200],
              //                             image: DecorationImage(
              //                                 image: NetworkImage(snapshot
              //                                     .data.docs[1]['image']),
              //                                 fit: BoxFit.cover)),
              //                       )
              //                     ],
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 40,
              //     child: Center(
              //       child: Text(
              //         "TRENDS",
              //         style: GoogleFonts.lato(
              //           textStyle: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               color: Colors.black,
              //               fontSize: 12,
              //               letterSpacing: 3),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 140,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 1.0, right: 1.0),
              //       child: Container(
              //         height: 200,
              //         decoration: BoxDecoration(
              //             color: Colors.grey[200],
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Container(
              //           height: 100,
              //           child: StreamBuilder(
              //               stream: FirebaseFirestore.instance
              //                   .collection("Items")
              //                   .snapshots(),
              //               builder: (context, snapshot) {
              //                 if (!snapshot.hasData) {
              //                   return Text(
              //                     'Loading',
              //                   );
              //                 } else {
              //                   return Scrollbar(
              //                     //   isAlwaysShown: true,
              //                     controller: _scrollController,
              //                     child: ListView.builder(
              //                         shrinkWrap: true,
              //                         scrollDirection: Axis.horizontal,
              //                         //                     gridDelegate:
              //                         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                         // controller: _scrollController,
              //                         itemCount: snapshot.data.docs.length,
              //                         itemBuilder:
              //                             (BuildContext context, int index) {
              //                           return Padding(
              //                             padding: const EdgeInsets.all(10.0),
              //                             child: GestureDetector(
              //                               onTap: () {
              //                                 Navigator.push(
              //                                     context,
              //                                     MaterialPageRoute(
              //                                         builder: (context) =>
              //                                             DetailScreen(
              //                                               queryDocumentSnapshot:
              //                                                   snapshot.data
              //                                                           .docs[
              //                                                       index],
              //                                             )));
              //                               },
              //                               child: Container(
              //                                 decoration: BoxDecoration(
              //                                     color: Colors.white,
              //                                     borderRadius:
              //                                         BorderRadius.circular(5)),
              //                                 height: 120,
              //                                 width: 150,
              //                                 child: Column(
              //                                   children: [
              //                                     Container(
              //                                       height: 105,
              //                                       width: 270,
              //                                       decoration: BoxDecoration(
              //                                           borderRadius:
              //                                               BorderRadius
              //                                                   .circular(5),
              //                                           color: Colors.white,
              //                                           image: DecorationImage(
              //                                               image: NetworkImage(
              //                                                   snapshot.data
              //                                                               .docs[
              //                                                           index]
              //                                                       ['image']),
              //                                               fit: BoxFit.cover)),
              //                                     ),
              //                                     Center(
              //                                       child: Text(
              //                                         snapshot.data
              //                                             .docs[index]['name']
              //                                             .toUpperCase(),
              //                                         style: GoogleFonts.lato(
              //                                           textStyle: TextStyle(
              //                                               fontWeight:
              //                                                   FontWeight.w700,
              //                                               color: Colors.black,
              //                                               fontSize: 10,
              //                                               letterSpacing: 1),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           );
              //                         }),
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 40,
              //     child: Center(
              //       child: Text(
              //         "CHAIR",
              //         style: GoogleFonts.lato(
              //           textStyle: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               color: Colors.black,
              //               fontSize: 12,
              //               letterSpacing: 3),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 190,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 1.0, right: 1.0),
              //       child: Container(
              //         height: 200,
              //         decoration: BoxDecoration(
              //             color: Colors.grey[200],
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Container(
              //           height: 100,
              //           child: StreamBuilder(
              //               stream: FirebaseFirestore.instance
              //                   .collection("Items").doc("chair").collection("Products")
              //                   .snapshots(),
              //               builder: (context, snapshot) {
              //                 if (!snapshot.hasData) {
              //                   return Text(
              //                     'Loading',
              //                   );
              //                 } else {
              //                   return Scrollbar(
              //                     //   isAlwaysShown: true,
              //                     controller: _scrollController,
              //                     child: ListView.builder(
              //                         scrollDirection: Axis.horizontal,
              //                         //                     gridDelegate:
              //                         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                         controller: _scrollController,
              //                         itemCount: snapshot.data.docs.length,
              //                         itemBuilder:
              //                             (BuildContext context, int index) {
              //                           return Padding(
              //                             padding: const EdgeInsets.all(10.0),
              //                             child: GestureDetector(
              //                               onTap: () {
              //                                 Navigator.push(
              //                                     context,
              //                                     MaterialPageRoute(
              //                                         builder: (context) =>
              //                                             DetailScreen(
              //                                               queryDocumentSnapshot:
              //                                                   snapshot.data
              //                                                       .docs[index],
              //                                             )));
              //                               },
              //                               child: Container(
              //                                 decoration: BoxDecoration(
              //                                     color: Colors.white,
              //                                     borderRadius:
              //                                         BorderRadius.circular(5)),
              //                                 height: 120,
              //                                 width: 150,
              //                                 child: Column(
              //                                   children: [
              //                                     Container(
              //                                       height: 152,
              //                                       width: 272,
              //                                       decoration: BoxDecoration(
              //                                           borderRadius:
              //                                               BorderRadius.circular(
              //                                                   5),
              //                                           color: Colors.white,
              //                                           image: DecorationImage(
              //                                               image: NetworkImage(
              //                                                   snapshot.data
              //                                                               .docs[
              //                                                           index]
              //                                                       ['mainimage']),
              //                                               fit: BoxFit.cover)),
              //                                     ),
              //                                     Center(
              //                                       child: Text(
              //                                         snapshot.data
              //                                             .docs[index]['name']
              //                                             .toUpperCase(),
              //                                         style: GoogleFonts.lato(
              //                                           textStyle: TextStyle(
              //                                               fontWeight:
              //                                                   FontWeight.w700,
              //                                               color: Colors.black,
              //                                               fontSize: 10,
              //                                               letterSpacing: 1),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           );
              //                         }),
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                color: Colors.transparent,
                height: 945,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Items")
                        .limit(4)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'Loading',
                        );
                      } else {
                        return Scrollbar(
                          //   isAlwaysShown: true,
                          //
                          //
                          controller: _scrollController,

                          child: Container(
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                //                     gridDelegate:
                                // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                controller: _scrollController,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  categorypage(
                                                    queryDocumentSnapshot:
                                                        snapshot
                                                            .data.docs[index],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 9),
                                                Center(
                                                  child: Text(
                                                    snapshot.data
                                                        .docs[index]["name"]
                                                        .toUpperCase(),
                                                    style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          letterSpacing: 1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 190,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0, right: 1.0),
                                                child: Container(
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    height: 100,
                                                    child: StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Items")
                                                                .doc(
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      ["name"],
                                                                )
                                                                .collection(
                                                                    "Products")
                                                                .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Text(
                                                              'Loading',
                                                            );
                                                          } else {
                                                            return Scrollbar(
                                                              //   isAlwaysShown: true,
                                                              controller:
                                                                  _scrollController,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      //                     gridDelegate:
                                                                      // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                                                      controller:
                                                                          _scrollController,
                                                                      itemCount: snapshot
                                                                          .data
                                                                          .docs
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => DetailScreen(
                                                                                            queryDocumentSnapshot: snapshot.data.docs[index],
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(5)),
                                                                              height: 120,
                                                                              width: 150,
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 152,
                                                                                    width: 272,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['mainimage']), fit: BoxFit.cover)),
                                                                                  ),
                                                                                  SizedBox(height: 4),
                                                                                  Center(
                                                                                    child: Text(
                                                                                      snapshot.data.docs[index]['name'].toUpperCase(),
                                                                                      style: GoogleFonts.lato(
                                                                                        textStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 10, letterSpacing: 1),
                                                                                      ),
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
                                            ),
                                          ),
                                          ////
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[100].withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "-----     EXPLORE CART     -----",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey[700],
                                fontSize: 14,
                                letterSpacing: 2),
                          ),
                        ),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 945,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Items")
                        .orderBy("name")
                        .limitToLast(4)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'Loading',
                        );
                      } else {
                        return Scrollbar(
                          //   isAlwaysShown: true,
                          //
                          //
                          controller: _scrollController,

                          child: Container(
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                //                     gridDelegate:
                                // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                controller: _scrollController,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    queryDocumentSnapshot:
                                                        snapshot
                                                            .data.docs[index],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 9),
                                                Center(
                                                  child: Text(
                                                    snapshot.data
                                                        .docs[index]["name"]
                                                        .toUpperCase(),
                                                    style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          letterSpacing: 2),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 190,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0, right: 1.0),
                                                child: Container(
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    height: 100,
                                                    child: StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Items")
                                                                .doc(
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      ["name"],
                                                                )
                                                                .collection(
                                                                    "Products")
                                                                .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Text(
                                                              'Loading',
                                                            );
                                                          } else {
                                                            return Scrollbar(
                                                              //   isAlwaysShown: true,
                                                              controller:
                                                                  _scrollController,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      //                     gridDelegate:
                                                                      // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                                                      controller:
                                                                          _scrollController,
                                                                      itemCount: snapshot
                                                                          .data
                                                                          .docs
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => DetailScreen(
                                                                                            queryDocumentSnapshot: snapshot.data.docs[index],
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(5)),
                                                                              height: 120,
                                                                              width: 150,
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 152,
                                                                                    width: 272,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['mainimage']), fit: BoxFit.cover)),
                                                                                  ),
                                                                                  SizedBox(height: 4),
                                                                                  Center(
                                                                                    child: Text(
                                                                                      snapshot.data.docs[index]['name'].toUpperCase(),
                                                                                      style: GoogleFonts.lato(
                                                                                        textStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 10, letterSpacing: 1),
                                                                                      ),
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
                                            ),
                                          ),
                                          ////
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                    }),
              ),
              //   Container(
              //   color: Colors.grey[200],
              //    height: 1050,
              //   child: StreamBuilder(
              //       stream: FirebaseFirestore.instance
              //           .collection("Items").orderBy("name").limitToLast(4)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (!snapshot.hasData) {
              //           return Text(
              //             'Loading',
              //           );
              //         } else {
              //           return Scrollbar(
              //             //   isAlwaysShown: true,
              //             //
              //             //
              //             controller: _scrollController,

              //             child: Container(
              //               child: ListView.builder(
              //                 primary: false,
              //                 shrinkWrap: true,
              //                physics:NeverScrollableScrollPhysics(),
              //                   scrollDirection: Axis.vertical,
              //                   //                     gridDelegate:
              //                   // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                   controller: _scrollController,
              //                   itemCount: snapshot.data.docs.length,
              //                   itemBuilder: (BuildContext context, int index) {
              //                     return GestureDetector(
              //                       onTap: () {
              //                         Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) => DetailScreen(
              //                                       queryDocumentSnapshot:
              //                                           snapshot.data.docs[index],
              //                                     )));
              //                       },
              //                       child: Container(
              //                         decoration: BoxDecoration(
              //                             color: Colors.white,
              //                             borderRadius: BorderRadius.circular(5)),
              //                         child: Column(
              //                           children: [
              //                             Padding(
              //                               padding: const EdgeInsets.all(8.0),
              //                               child: Container(
              //                                 color: Colors.grey[200],
              //                                 height: 40,
              //                                 child: Center(
              //                                   child: Text(
              //                                     snapshot
              //                                         .data.docs[index]["name"]
              //                                         .toUpperCase(),
              //                                     style: GoogleFonts.lato(
              //                                       textStyle: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w600,
              //                                           color: Colors.black,
              //                                           fontSize: 12,
              //                                           letterSpacing: 3),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),

              //                             Padding(
              //                               padding: const EdgeInsets.all(8.0),
              //                               child: Container(
              //                                 color: Colors.grey[200],
              //                                 height: 190,
              //                                 child: Padding(
              //                                   padding: const EdgeInsets.only(
              //                                       left: 1.0, right: 1.0),
              //                                   child: Container(
              //                                     height: 200,
              //                                     decoration: BoxDecoration(
              //                                         color: Colors.grey[200],
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5)),
              //                                     child: Container(
              //                                       height: 100,
              //                                       child: StreamBuilder(
              //                                           stream: FirebaseFirestore
              //                                               .instance
              //                                               .collection("Items")
              //                                               .doc(
              //                                                 snapshot.data
              //                                                         .docs[index]
              //                                                     ["name"],
              //                                               )
              //                                               .collection(
              //                                                   "Products")
              //                                               .snapshots(),
              //                                           builder:
              //                                               (context, snapshot) {
              //                                             if (!snapshot.hasData) {
              //                                               return Text(
              //                                                 'Loading',
              //                                               );
              //                                             } else {
              //                                               return Scrollbar(
              //                                                 //   isAlwaysShown: true,
              //                                                 controller:
              //                                                     _scrollController,
              //                                                 child: ListView
              //                                                     .builder(
              //                                                         scrollDirection:
              //                                                             Axis
              //                                                                 .horizontal,
              //                                                         //                     gridDelegate:
              //                                                         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                                                         controller:
              //                                                             _scrollController,
              //                                                         itemCount:
              //                                                             snapshot
              //                                                                 .data
              //                                                                 .docs
              //                                                                 .length,
              //                                                         itemBuilder:
              //                                                             (BuildContext
              //                                                                     context,
              //                                                                 int index) {
              //                                                           return Padding(
              //                                                             padding:
              //                                                                 const EdgeInsets.all(10.0),
              //                                                             child:
              //                                                                 GestureDetector(
              //                                                               onTap:
              //                                                                   () {
              //                                                                 Navigator.push(
              //                                                                     context,
              //                                                                     MaterialPageRoute(
              //                                                                         builder: (context) => DetailScreen(
              //                                                                               queryDocumentSnapshot: snapshot.data.docs[index],
              //                                                                             )));
              //                                                               },
              //                                                               child:
              //                                                                   Container(
              //                                                                 decoration:
              //                                                                     BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              //                                                                 height:
              //                                                                     120,
              //                                                                 width:
              //                                                                     150,
              //                                                                 child:
              //                                                                     Column(
              //                                                                   children: [
              //                                                                     Container(
              //                                                                       height: 152,
              //                                                                       width: 272,
              //                                                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['mainimage']), fit: BoxFit.cover)),
              //                                                                     ),
              //                                                                     Center(
              //                                                                       child: Text(
              //                                                                         snapshot.data.docs[index]['name'].toUpperCase(),
              //                                                                         style: GoogleFonts.lato(
              //                                                                           textStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 10, letterSpacing: 1),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ],
              //                                                                 ),
              //                                                               ),
              //                                                             ),
              //                                                           );
              //                                                         }),
              //                                               );
              //                                             }
              //                                           }),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                             ////
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   }),
              //             ),
              //           );
              //         }
              //       }),
              // ),
              //
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                    height: 90,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Follow Us through ",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 10,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launch("https://www.facebook.com/");
                                },
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    child: Image.network(
                                        "https://assets.stickpng.com/thumbs/584ac2d03ac3a570f94a666d.png")),
                              ),
                              SizedBox(width: 15),
                              Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                      "https://assets.stickpng.com/images/580b57fcd9996e24bc43c521.png")),
                              SizedBox(width: 5),
                              Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                      "https://assets.stickpng.com/images/580b57fcd9996e24bc43c53e.png"))
                            ],
                          )
                        ]),
                    decoration: BoxDecoration(color: Colors.blueGrey[10])),
              )
            ]),
          ),
        ));
  }

  Widget smallscreen() {
    return Scaffold(
      appBar: AppBar(
        //  actionsIconTheme: IconThemeData(color: kBackgroundColor),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return userScren();
                }));
              },
              child: Icon(Icons.account_circle_outlined, size: 20)),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext context) {
                return Search();
              }));
            },
            child: Icon(Icons.search, size: 20),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return wishlist();
                }));
              },
              child: Icon(Icons.favorite_outline_rounded, size: 20)),
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {},
                child: Stack(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return stepper();
                        }));
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
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
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 0,
            // ),
            Text(
              "Mr & Mrs",
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kBackgroundColor,
                    fontSize: 20,
                    letterSpacing: 0),
              ),
            ),
            Text(
              "Design Wood Works".toUpperCase(),
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 6,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        elevation: 0,
        //   centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 100),
        opacity: fabisVisible ? 0 : 1,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kBackgroundColor,
          child: IconButton(
              onPressed: () {
                pagecontroller.animateTo(0,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut);
              },
              icon: Icon(Icons.arrow_upward_sharp)),
        ),
      ),
      body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          controller: pagecontroller,
          child: Container(
            color: Colors.white,
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 12),
                child: Container(
                  // height: 161,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 70,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Items")
                            // .limit(10)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                'Loading',
                              ),
                            );
                          } else {
                            return Scrollbar(
                              //   isAlwaysShown: true,
                              controller: _scrollController,
                              child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1),
                                  controller: _scrollController,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      categorypage(
                                                        queryDocumentSnapshot:
                                                            snapshot.data
                                                                .docs[index],
                                                      )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.teal,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 120,
                                          width: 220,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                              height: 55,
                                              width: 270,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.grey[600],
                                                              BlendMode
                                                                  .srcATop),
                                                      image: NetworkImage(
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['image']),
                                                      fit: BoxFit.contain)),
                                            ),
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

              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                child: SizedBox(
                    height: 180.0,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Poster")
                            .limit(10)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Center(
                                child: Text(
                                  'Loading',
                                ),
                              ),
                            );
                          } else {
                            return Carousel(
                              images: [
                                NetworkImage(snapshot.data.docs[0]["image"]),
                                NetworkImage(snapshot.data.docs[1]["image"]),
                                NetworkImage(snapshot.data.docs[2]["image"]),
                              ],
                              dotSize: 2.0,
                              dotSpacing: 12.0,
                              dotColor: Colors.amber,
                              indicatorBgPadding: 5.0,
                              dotBgColor: Colors.transparent,
                              borderRadius: true,
                            );
                          }
                        })),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 14.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.freepik.com/free-photo/empty-living-room-with-blue-sofa-plants-table-empty-white-wall-background-3d-rendering_41470-1778.jpg"),
                              fit: BoxFit.cover),
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Qualified Furnitures",
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: kBackgroundColor,
                                      fontSize: 12,
                                      letterSpacing: 0),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                  height: 2, width: 20, color: Colors.white),
                            ],
                          ),
                        ),
                        height: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.freepik.com/free-photo/empty-living-room-with-blue-sofa-plants-table-empty-white-wall-background-3d-rendering_41470-1786.jpg"),
                              fit: BoxFit.cover),
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Free Installation",
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: kBackgroundColor,
                                      fontSize: 12,
                                      letterSpacing: 0),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                  height: 2, width: 20, color: Colors.white),
                            ],
                          ),
                        ),
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 23),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0, right: 8.0),
                    child: Text(
                      "IN TRENDS",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: 15,
                            letterSpacing: 0),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    //tofdo
                    // Navigator.of(context).push(
                    //     new MaterialPageRoute(builder: (BuildContext context) {
                    //   return shopbycategory();
                    // }));
                  },
                  child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "See All",
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 0),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      height: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 9),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      // color: Colors.teal[50].withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 120,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("SearchProducts")
                            .where("trend", isEqualTo: "true")
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
                              //   isAlwaysShown: true,
                              controller: _scrollController,
                              child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1),
                                  controller: _scrollController,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen(
                                                        queryDocumentSnapshot:
                                                            snapshot.data
                                                                .docs[index],
                                                      )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          height: 120,
                                          width: 220,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 115,
                                                width: 270,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['mainimage']),
                                                        fit: BoxFit.cover)),
                                              ),
                                              SizedBox(
                                                height: 1.5,
                                              ),
                                              Center(
                                                child: Text(
                                                  snapshot
                                                      .data.docs[index]['name']
                                                      .toUpperCase(),
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        letterSpacing: 1),
                                                  ),
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
              // SizedBox(
              //   height: 14,
              // ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => userScren()));
                  },
                  child: SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.freepik.com/free-vector/white-abstract-background_23-2148810113.jpg",
                                  // NetworkImage("https://image.freepik.com/free-vector/white-background-with-3d-hexagonal-pattern-design_1017-28443.jpg"
                                ),
                                fit: BoxFit.cover),
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(3)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.settings,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Center(
                              child: Text(
                                "Setup Account Settings . . ",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      fontSize: 15,
                                      letterSpacing: 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),

              //  Padding(
              //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              //   child: Container(
              //       child: Center(
              //         child: Text(
              //           "SET UP ACCOUNT SEETINGS",
              //           style: GoogleFonts.lato(
              //             textStyle: TextStyle(
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.black54,
              //                 fontSize: 14,
              //                 letterSpacing: 2),
              //           ),
              //         ),
              //       ),
              //       decoration: BoxDecoration(
              //           color: Colors.blueGrey[100].withOpacity(0.4),
              //           borderRadius: BorderRadius.circular(5)),
              //       height: 80),
              // ),

              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 17.0, right: 8.0, top: 9),
                    child: Text(
                      "CATEGORY",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: 15,
                            letterSpacing: 0),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return shopbycategory();
                    }));
                  },
                  child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "SEE ALL ",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 1),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      height: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 1.0, top: 3),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.teal[50].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 100,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Items")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                'Loading',
                              ),
                            );
                          } else {
                            return Scrollbar(
                              //   isAlwaysShown: true,
                              controller: _scrollController,
                              child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1),
                                  controller: _scrollController,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      categorypage(
                                                        queryDocumentSnapshot:
                                                            snapshot.data
                                                                .docs[index],
                                                      )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 80,
                                          width: 210,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 85,
                                                width: 260,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors
                                                                    .grey[600],
                                                                BlendMode
                                                                    .srcATop),
                                                        image: NetworkImage(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['image']),
                                                        fit: BoxFit.contain)),
                                              ),
                                              SizedBox(height: 16),
                                              Center(
                                                child: Text(
                                                  snapshot
                                                      .data.docs[index]['name']
                                                      .toUpperCase(),
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        letterSpacing: 1),
                                                  ),
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

              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Stay Safe, Stay Home",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20,
                                letterSpacing: 0),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 0.5,
                          color: kBackgroundColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 50, top: 50),
                          child: Text(
                            "To comply with the norms, we will continue to serve and fulfill your home furnishing needs in a safer manner through online shopping at IKEA.in. Use our remote planning services and try Click & Collect, our contactless shopping service. Mumbai and Pune customers can shop online, the deliveries will resume once the government restrictions are lifted. ",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          // colorFilter:
                          //     ColorFilter.mode(
                          //         Colors.grey[600],
                          //         BlendMode
                          //             .srcATop),
                          image: NetworkImage(
                              "https://image.freepik.com/free-photo/white-virus-background_44769-1701.jpg"),
                          fit: BoxFit.cover)),
                  height: 250,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.white,
              //     height: 210,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 1.0, right: 1.0),
              //       child: Container(
              //         height: 210,
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Container(
              //           height: 110,
              //           child: StreamBuilder(
              //               stream: FirebaseFirestore.instance
              //                   .collection("Poster")
              //                   .snapshots(),
              //               builder: (context, snapshot) {
              //                 if (!snapshot.hasData) {
              //                   return Text(
              //                     'Loading',
              //                   );
              //                 } else {
              //                   return Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceEvenly,
              //                     children: [
              //                       Container(
              //                         height: 210,
              //                         width: 150,
              //                         decoration: BoxDecoration(
              //                             borderRadius:
              //                                 BorderRadius.circular(5),
              //                             color: Colors.grey[200],
              //                             image: DecorationImage(
              //                                 image: NetworkImage(snapshot
              //                                     .data.docs[0]['image']),
              //                                 fit: BoxFit.cover)),
              //                       ),
              //                       Container(
              //                         height: 210,
              //                         width: 150,
              //                         decoration: BoxDecoration(
              //                             borderRadius:
              //                                 BorderRadius.circular(5),
              //                             color: Colors.grey[200],
              //                             image: DecorationImage(
              //                                 image: NetworkImage(snapshot
              //                                     .data.docs[1]['image']),
              //                                 fit: BoxFit.cover)),
              //                       )
              //                     ],
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 40,
              //     child: Center(
              //       child: Text(
              //         "TRENDS",
              //         style: GoogleFonts.lato(
              //           textStyle: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               color: Colors.black,
              //               fontSize: 12,
              //               letterSpacing: 3),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 140,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 1.0, right: 1.0),
              //       child: Container(
              //         height: 200,
              //         decoration: BoxDecoration(
              //             color: Colors.grey[200],
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Container(
              //           height: 100,
              //           child: StreamBuilder(
              //               stream: FirebaseFirestore.instance
              //                   .collection("Items")
              //                   .snapshots(),
              //               builder: (context, snapshot) {
              //                 if (!snapshot.hasData) {
              //                   return Text(
              //                     'Loading',
              //                   );
              //                 } else {
              //                   return Scrollbar(
              //                     //   isAlwaysShown: true,
              //                     controller: _scrollController,
              //                     child: ListView.builder(
              //                         shrinkWrap: true,
              //                         scrollDirection: Axis.horizontal,
              //                         //                     gridDelegate:
              //                         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                         // controller: _scrollController,
              //                         itemCount: snapshot.data.docs.length,
              //                         itemBuilder:
              //                             (BuildContext context, int index) {
              //                           return Padding(
              //                             padding: const EdgeInsets.all(10.0),
              //                             child: GestureDetector(
              //                               onTap: () {
              //                                 Navigator.push(
              //                                     context,
              //                                     MaterialPageRoute(
              //                                         builder: (context) =>
              //                                             DetailScreen(
              //                                               queryDocumentSnapshot:
              //                                                   snapshot.data
              //                                                           .docs[
              //                                                       index],
              //                                             )));
              //                               },
              //                               child: Container(
              //                                 decoration: BoxDecoration(
              //                                     color: Colors.white,
              //                                     borderRadius:
              //                                         BorderRadius.circular(5)),
              //                                 height: 120,
              //                                 width: 150,
              //                                 child: Column(
              //                                   children: [
              //                                     Container(
              //                                       height: 105,
              //                                       width: 270,
              //                                       decoration: BoxDecoration(
              //                                           borderRadius:
              //                                               BorderRadius
              //                                                   .circular(5),
              //                                           color: Colors.white,
              //                                           image: DecorationImage(
              //                                               image: NetworkImage(
              //                                                   snapshot.data
              //                                                               .docs[
              //                                                           index]
              //                                                       ['image']),
              //                                               fit: BoxFit.cover)),
              //                                     ),
              //                                     Center(
              //                                       child: Text(
              //                                         snapshot.data
              //                                             .docs[index]['name']
              //                                             .toUpperCase(),
              //                                         style: GoogleFonts.lato(
              //                                           textStyle: TextStyle(
              //                                               fontWeight:
              //                                                   FontWeight.w700,
              //                                               color: Colors.black,
              //                                               fontSize: 10,
              //                                               letterSpacing: 1),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           );
              //                         }),
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 40,
              //     child: Center(
              //       child: Text(
              //         "CHAIR",
              //         style: GoogleFonts.lato(
              //           textStyle: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               color: Colors.black,
              //               fontSize: 12,
              //               letterSpacing: 3),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     color: Colors.grey[200],
              //     height: 190,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 1.0, right: 1.0),
              //       child: Container(
              //         height: 200,
              //         decoration: BoxDecoration(
              //             color: Colors.grey[200],
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Container(
              //           height: 100,
              //           child: StreamBuilder(
              //               stream: FirebaseFirestore.instance
              //                   .collection("Items").doc("chair").collection("Products")
              //                   .snapshots(),
              //               builder: (context, snapshot) {
              //                 if (!snapshot.hasData) {
              //                   return Text(
              //                     'Loading',
              //                   );
              //                 } else {
              //                   return Scrollbar(
              //                     //   isAlwaysShown: true,
              //                     controller: _scrollController,
              //                     child: ListView.builder(
              //                         scrollDirection: Axis.horizontal,
              //                         //                     gridDelegate:
              //                         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                         controller: _scrollController,
              //                         itemCount: snapshot.data.docs.length,
              //                         itemBuilder:
              //                             (BuildContext context, int index) {
              //                           return Padding(
              //                             padding: const EdgeInsets.all(10.0),
              //                             child: GestureDetector(
              //                               onTap: () {
              //                                 Navigator.push(
              //                                     context,
              //                                     MaterialPageRoute(
              //                                         builder: (context) =>
              //                                             DetailScreen(
              //                                               queryDocumentSnapshot:
              //                                                   snapshot.data
              //                                                       .docs[index],
              //                                             )));
              //                               },
              //                               child: Container(
              //                                 decoration: BoxDecoration(
              //                                     color: Colors.white,
              //                                     borderRadius:
              //                                         BorderRadius.circular(5)),
              //                                 height: 120,
              //                                 width: 150,
              //                                 child: Column(
              //                                   children: [
              //                                     Container(
              //                                       height: 152,
              //                                       width: 272,
              //                                       decoration: BoxDecoration(
              //                                           borderRadius:
              //                                               BorderRadius.circular(
              //                                                   5),
              //                                           color: Colors.white,
              //                                           image: DecorationImage(
              //                                               image: NetworkImage(
              //                                                   snapshot.data
              //                                                               .docs[
              //                                                           index]
              //                                                       ['mainimage']),
              //                                               fit: BoxFit.cover)),
              //                                     ),
              //                                     Center(
              //                                       child: Text(
              //                                         snapshot.data
              //                                             .docs[index]['name']
              //                                             .toUpperCase(),
              //                                         style: GoogleFonts.lato(
              //                                           textStyle: TextStyle(
              //                                               fontWeight:
              //                                                   FontWeight.w700,
              //                                               color: Colors.black,
              //                                               fontSize: 10,
              //                                               letterSpacing: 1),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           );
              //                         }),
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                color: Colors.transparent,
                height: 970,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Items")
                        .limit(4)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'Loading',
                        );
                      } else {
                        return Scrollbar(
                          //   isAlwaysShown: true,
                          //
                          //
                          controller: _scrollController,

                          child: Container(
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                //                     gridDelegate:
                                // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                controller: _scrollController,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  categorypage(
                                                    queryDocumentSnapshot:
                                                        snapshot
                                                            .data.docs[index],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8, top: 8),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 9),
                                                Center(
                                                  child: Text(
                                                    snapshot.data
                                                        .docs[index]['name']
                                                        .toUpperCase(),
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black54,
                                                          fontSize: 15,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                categorypage(
                                                                  queryDocumentSnapshot:
                                                                      snapshot
                                                                          .data
                                                                          .docs[index],
                                                                )));
                                              },
                                              child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    "See All",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  height: 15),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.teal[50]
                                                  .withOpacity(0.2),
                                              height: 190,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0, right: 1.0),
                                                child: Container(
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    height: 100,
                                                    child: StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Items")
                                                                .doc(
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      ["name"],
                                                                )
                                                                .collection(
                                                                    "Products")
                                                                .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                                                                                          child: Text(
                                                                'Loading',
                                                              ),
                                                            );
                                                          } else {
                                                            return Scrollbar(
                                                              //   isAlwaysShown: true,
                                                              controller:
                                                                  _scrollController,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      //                     gridDelegate:
                                                                      // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                                                      controller:
                                                                          _scrollController,
                                                                      itemCount: snapshot
                                                                          .data
                                                                          .docs
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => DetailScreen(
                                                                                            queryDocumentSnapshot: snapshot.data.docs[index],
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(color: kBackgroundColor, borderRadius: BorderRadius.circular(5)),
                                                                              height: 120,
                                                                              width: 150,
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 152,
                                                                                    width: 272,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['mainimage']), fit: BoxFit.cover)),
                                                                                  ),
                                                                                  SizedBox(height: 4),
                                                                                  Center(
                                                                                    child: Text(
                                                                                      snapshot.data.docs[index]['name'].toUpperCase(),
                                                                                      style: GoogleFonts.lato(
                                                                                        textStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 10, letterSpacing: 1),
                                                                                      ),
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
                                            ),
                                          ),
                                          ////
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (b) => stepper()));
                  },
                  child: SizedBox(
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.freepik.com/free-photo/shopping-bag-cart_23-2148879372.jpg"),
                                fit: BoxFit.cover),
                            color: Colors.teal[50].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Center(
                              child: Text(
                                "Explore Cart",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey[700],
                                      fontSize: 19,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 980,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Items")
                        .orderBy("name")
                        .limitToLast(4)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                                                  child: Text(
                            'Loading',
                          ),
                        );
                      } else {
                        return Scrollbar(
                          //   isAlwaysShown: true,
                          //
                          //
                          controller: _scrollController,

                          child: Container(
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                //                     gridDelegate:
                                // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                controller: _scrollController,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  categorypage(
                                                    queryDocumentSnapshot:
                                                        snapshot
                                                            .data.docs[index],
                                                  )));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => DetailScreen(
                                      //               queryDocumentSnapshot:
                                      //                   snapshot.data.docs[index],
                                      //             )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 8, right: 8),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 9),
                                                Center(
                                                  child: Text(
                                                    snapshot.data
                                                        .docs[index]['name']
                                                        .toUpperCase(),
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black54,
                                                          fontSize: 15,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                categorypage(
                                                                  queryDocumentSnapshot:
                                                                      snapshot
                                                                          .data
                                                                          .docs[index],
                                                                )));
                                              },
                                              child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    "See All",
                                                    style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          letterSpacing: 1),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  height: 15),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 190,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0, right: 1.0),
                                                child: Container(
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      color: Colors.teal[50]
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    height: 100,
                                                    child: StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Items")
                                                                .doc(
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      ["name"],
                                                                )
                                                                .collection(
                                                                    "Products")
                                                                .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: Text(
                                                                'Loading',
                                                              ),
                                                            );
                                                          } else {
                                                            return Scrollbar(
                                                              //   isAlwaysShown: true,
                                                              controller:
                                                                  _scrollController,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      //                     gridDelegate:
                                                                      // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
                                                                      controller:
                                                                          _scrollController,
                                                                      itemCount: snapshot
                                                                          .data
                                                                          .docs
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => DetailScreen(
                                                                                            queryDocumentSnapshot: snapshot.data.docs[index],
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(color: kBackgroundColor, borderRadius: BorderRadius.circular(5)),
                                                                              height: 120,
                                                                              width: 150,
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    height: 152,
                                                                                    width: 272,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['mainimage']), fit: BoxFit.cover)),
                                                                                  ),
                                                                                  SizedBox(height: 4),
                                                                                  Center(
                                                                                    child: Text(
                                                                                      snapshot.data.docs[index]['name'].toUpperCase(),
                                                                                      style: GoogleFonts.lato(
                                                                                        textStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 10, letterSpacing: 1),
                                                                                      ),
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
                                            ),
                                          ),
                                          ////
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                    }),
              ),
              //   Container(
              //   color: Colors.grey[200],
              //    height: 1050,
              //   child: StreamBuilder(
              //       stream: FirebaseFirestore.instance
              //           .collection("Items").orderBy("name").limitToLast(4)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (!snapshot.hasData) {
              //           return Text(
              //             'Loading',
              //           );
              //         } else {
              //           return Scrollbar(
              //             //   isAlwaysShown: true,
              //             //
              //             //
              //             controller: _scrollController,

              //             child: Container(
              //               child: ListView.builder(
              //                 primary: false,
              //                 shrinkWrap: true,
              //                physics:NeverScrollableScrollPhysics(),
              //                   scrollDirection: Axis.vertical,
              //                   //                     gridDelegate:
              //                   // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                   controller: _scrollController,
              //                   itemCount: snapshot.data.docs.length,
              //                   itemBuilder: (BuildContext context, int index) {
              //                     return GestureDetector(
              //                       onTap: () {
              //                         Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) => DetailScreen(
              //                                       queryDocumentSnapshot:
              //                                           snapshot.data.docs[index],
              //                                     )));
              //                       },
              //                       child: Container(
              //                         decoration: BoxDecoration(
              //                             color: Colors.white,
              //                             borderRadius: BorderRadius.circular(5)),
              //                         child: Column(
              //                           children: [
              //                             Padding(
              //                               padding: const EdgeInsets.all(8.0),
              //                               child: Container(
              //                                 color: Colors.grey[200],
              //                                 height: 40,
              //                                 child: Center(
              //                                   child: Text(
              //                                     snapshot
              //                                         .data.docs[index]["name"]
              //                                         .toUpperCase(),
              //                                     style: GoogleFonts.lato(
              //                                       textStyle: TextStyle(
              //                                           fontWeight:
              //                                               FontWeight.w600,
              //                                           color: Colors.black,
              //                                           fontSize: 12,
              //                                           letterSpacing: 3),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),

              //                             Padding(
              //                               padding: const EdgeInsets.all(8.0),
              //                               child: Container(
              //                                 color: Colors.grey[200],
              //                                 height: 190,
              //                                 child: Padding(
              //                                   padding: const EdgeInsets.only(
              //                                       left: 1.0, right: 1.0),
              //                                   child: Container(
              //                                     height: 200,
              //                                     decoration: BoxDecoration(
              //                                         color: Colors.grey[200],
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5)),
              //                                     child: Container(
              //                                       height: 100,
              //                                       child: StreamBuilder(
              //                                           stream: FirebaseFirestore
              //                                               .instance
              //                                               .collection("Items")
              //                                               .doc(
              //                                                 snapshot.data
              //                                                         .docs[index]
              //                                                     ["name"],
              //                                               )
              //                                               .collection(
              //                                                   "Products")
              //                                               .snapshots(),
              //                                           builder:
              //                                               (context, snapshot) {
              //                                             if (!snapshot.hasData) {
              //                                               return Text(
              //                                                 'Loading',
              //                                               );
              //                                             } else {
              //                                               return Scrollbar(
              //                                                 //   isAlwaysShown: true,
              //                                                 controller:
              //                                                     _scrollController,
              //                                                 child: ListView
              //                                                     .builder(
              //                                                         scrollDirection:
              //                                                             Axis
              //                                                                 .horizontal,
              //                                                         //                     gridDelegate:
              //                                                         // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),
              //                                                         controller:
              //                                                             _scrollController,
              //                                                         itemCount:
              //                                                             snapshot
              //                                                                 .data
              //                                                                 .docs
              //                                                                 .length,
              //                                                         itemBuilder:
              //                                                             (BuildContext
              //                                                                     context,
              //                                                                 int index) {
              //                                                           return Padding(
              //                                                             padding:
              //                                                                 const EdgeInsets.all(10.0),
              //                                                             child:
              //                                                                 GestureDetector(
              //                                                               onTap:
              //                                                                   () {
              //                                                                 Navigator.push(
              //                                                                     context,
              //                                                                     MaterialPageRoute(
              //                                                                         builder: (context) => DetailScreen(
              //                                                                               queryDocumentSnapshot: snapshot.data.docs[index],
              //                                                                             )));
              //                                                               },
              //                                                               child:
              //                                                                   Container(
              //                                                                 decoration:
              //                                                                     BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
              //                                                                 height:
              //                                                                     120,
              //                                                                 width:
              //                                                                     150,
              //                                                                 child:
              //                                                                     Column(
              //                                                                   children: [
              //                                                                     Container(
              //                                                                       height: 152,
              //                                                                       width: 272,
              //                                                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['mainimage']), fit: BoxFit.cover)),
              //                                                                     ),
              //                                                                     Center(
              //                                                                       child: Text(
              //                                                                         snapshot.data.docs[index]['name'].toUpperCase(),
              //                                                                         style: GoogleFonts.lato(
              //                                                                           textStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 10, letterSpacing: 1),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ],
              //                                                                 ),
              //                                                               ),
              //                                                             ),
              //                                                           );
              //                                                         }),
              //                                               );
              //                                             }
              //                                           }),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                             ////
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   }),
              //             ),
              //           );
              //         }
              //       }),
              // ),
              //
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                    height: 90,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Follow Us through ",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 10,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launch("https://www.facebook.com/");
                                },
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    child: Image.network(
                                        "https://assets.stickpng.com/thumbs/584ac2d03ac3a570f94a666d.png")),
                              ),
                              SizedBox(width: 15),
                              Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                      "https://assets.stickpng.com/images/580b57fcd9996e24bc43c521.png")),
                              SizedBox(width: 5),
                              Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                      "https://assets.stickpng.com/images/580b57fcd9996e24bc43c53e.png"))
                            ],
                          )
                        ]),
                    decoration: BoxDecoration(color: Colors.blueGrey[10])),
              )
            ]),
          )),
    );
  }
}
