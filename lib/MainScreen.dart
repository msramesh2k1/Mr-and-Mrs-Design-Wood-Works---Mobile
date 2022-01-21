import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/Registerer.dart';
import 'package:mr_and_mrs/Widgets/Responsive_widget.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:mr_and_mrs/login.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        body: ResponsiveWidget(
            mobile: mobile(), tab: mobile(), desktop: largescreen()));
  }

  Widget mobile() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Mr & Mrs",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBackgroundColor,
                        fontSize: 30,
                        letterSpacing: 0),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Design Wood Works",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 18,
                        letterSpacing: 0),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 1,
                  color: kPrimaryColor,
                  width: 80,
                )
              ],
            ),
          ),
          Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80.0, right: 80),
                    child: Container(
                      decoration: BoxDecoration(
                          // border: Border.all(color:kbgPrimaryColor,width: 1),
                          color: Colors.teal[200].withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8)),
                      height: 45,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kBackgroundColor,
                                fontSize: 18,
                                letterSpacing: 0),
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Registerer()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80.0, right: 80),
                    child: Container(
                      decoration: BoxDecoration(

                          ///    border: Border.all(color:kbgPrimaryColor,width: 1),
                          color: Colors.teal[200].withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8)),
                      height: 45,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "REGISTER",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kBackgroundColor,
                                fontSize: 18,
                                letterSpacing: 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget largescreen() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 165),
                child: header(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: headermenu(),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 40, top: 40.0),
                  child: _mainarea()),
              Padding(
                padding: const EdgeInsets.only(right: 80, top: 40.0),
                child: circleheader(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget mainarea() {
    return Container(
      decoration: BoxDecoration(
          color: kCaptionColor, borderRadius: BorderRadius.circular(10)),
      height: 200,
      width: 500,
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("A Permium Quality Product which gives complete  ",
              //  textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                    fontSize: 16,
                    letterSpacing: 0),
              )),
          Text("For Your Home, Office etc ..",
              //  textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                    fontSize: 16,
                    letterSpacing: 0),
              )),
        ]),
      ),
    );
  }

  Widget _mainarea() {
    return Container(
      decoration: BoxDecoration(
          color: kCaptionColor, borderRadius: BorderRadius.circular(10)),
      height: 468,
      width: 450,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: [
            // SizedBox(height: 30),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  "https://i.ibb.co/54w1Mms/imageedit-5-9094810655-removebg-preview-1-removebg-preview.png")
// NetworkImage("https://i.ibb.co/xFJPrFv/Whats-App-Image-2021-04-19-at-8-29-14-AM.jpg",),
//
//
              //NetworkImage("https://i.ibb.co/6Rxtrb9/Whats-App-Image-2021-04-19-at-8-29-14-AM-removebg-preview.png")

              //  NetworkImage("https://i.ibb.co/qy1r2Wh/Whats-App-Image-2021-04-19-at-8-29-14-AM-removebg-preview-3.png")

              ,
              backgroundColor: kCaptionColor,
            ),
            // Text("Mr & Mrs ",
            //     style: GoogleFonts.josefinSans(
            //       textStyle: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: kBackgroundColor,
            //           fontSize: 18,
            //           letterSpacing: 0),
            //     )),
            // Text("Design Wood Works",
            //     style: GoogleFonts.josefinSans(
            //       textStyle: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: kBackgroundColor,
            //           fontSize: 18,
            //           letterSpacing: 0),
            //     )),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Divider(color: kBackgroundColor),
        // ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                child: Text(
                  "A Permium Quality World Class Lavishing",
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBackgroundColor,
                        fontSize: 14,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
            Text(
              "Quality from Mr & Mrs Design Wood Works ...",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                    fontSize: 14,
                    letterSpacing: 1),
              ),
            ),
            Text(
              "Our Products Add Extra Beauty ",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                    fontSize: 14,
                    letterSpacing: 1),
              ),
            ),
            Text(
              "to your Environments",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                    fontSize: 14,
                    letterSpacing: 1),
              ),
            ),
            // Text(
            //   "GSTIN: 33ATIPS1405J1ZR",
            //   style: GoogleFonts.josefinSans(
            //     textStyle: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: kBackgroundColor,
            //         fontSize: 14,
            //         letterSpacing: 1),
            //   ),
            // ),
          ],
        ),
        //      SizedBox(height: 100),
        // Center(
        //   child: GestureDetector(
        //     onTap: () {
        //       // Navigator.push(
        //       //     context, MaterialPageRoute(builder: (context) => Homer()));
        //     },
        //     child: Container(
        //       decoration: BoxDecoration(
        //           color: kBackgroundColor,
        //           borderRadius: BorderRadius.circular(10)),
        //       height: 45,
        //       width: 150,
        //       child: Center(
        //         child: Text(
        //           "GET INTO",
        //           style: GoogleFonts.lato(
        //             textStyle: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 color: kCaptionColor,
        //                 fontSize: 12,
        //                 letterSpacing: 3),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ]),
    );
  }

  Widget headermenu() {
    return Row(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => Registerer()));
        },
        child: Container(
          child: Center(
            child: Text("REGISTER",
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kBackgroundColor,
                      fontSize: 13,
                      letterSpacing: 0),
                )),
          ),
          height: 35,
          width: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: kPrimaryColor),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
        },
        child: Container(
          child: Center(
            child: Text("LOGIN",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kBackgroundColor,
                      fontSize: 13,
                      letterSpacing: 0),
                )),
          ),
          height: 35,
          width: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: kPrimaryColor),
        ),
      ),
      // // Column(
      // //   children: [
      // //     // Text("Home",
      // //     //     style: GoogleFonts.josefinSans(
      // //     //       textStyle: TextStyle(
      // //     //           fontWeight: FontWeight.bold,
      // //     //           color: kCaptionColor,
      // //     //           fontSize: 18,
      // //     //           letterSpacing: 0),
      // //     //     )),
      // //     SizedBox(height: 4),
      // //     Container(height: 1, width: 30, color: kPrimaryColor)
      // //   ],
      // // ),
      // SizedBox(width: 15),
      // Column(
      //   children: [
      //     GestureDetector(

      //       onTap: (){
      //         //  Navigator.push(context,
      //         //             MaterialPageRoute(builder: (context) => Users()));
      //       },
      //       child: Text("Users",
      //           style: GoogleFonts.josefinSans(
      //             textStyle: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 color: kCaptionColor,
      //                 fontSize: 18,
      //                 letterSpacing: 0),
      //           )),
      //     ),
      //     SizedBox(height: 4),
      //     Container(height: 1, width: 30, color: kPrimaryColor)
      //   ],
      // ),
      // SizedBox(width: 15),
      // Column(
      //   children: [
      //     GestureDetector(
      //       onTap: (){
      //         //  Navigator.push(context,
      //         //            MaterialPageRoute(builder: (context) => Products()));
      //       },
      //                 child: Text("Products",
      //           style: GoogleFonts.josefinSans(
      //             textStyle: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 color: kCaptionColor,
      //                 fontSize: 18,
      //                 letterSpacing: 0),
      //           )),
      //     ),
      //     SizedBox(height: 4),
      //     Container(height: 1, width: 30, color: kPrimaryColor)
      //   ],
      // ),
      // SizedBox(width: 15),
      // Column(
      //   children: [
      //     GestureDetector(
      //       onTap: (){
      //           // Navigator.push(context,
      //           //          MaterialPageRoute(builder: (context) => about()));

      //       },
      //                 child: Text("About",
      //           style: GoogleFonts.josefinSans(
      //             textStyle: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 color: kCaptionColor,
      //                 fontSize: 18,
      //                 letterSpacing: 0),
      //           )),
      //     ),
      //     SizedBox(height: 4),
      //     Container(height: 1, width: 30, color: kPrimaryColor)
      //   ],
      // ),
      // SizedBox(width: 15),
      // Column(
      //   children: [
      //     GestureDetector(
      //       onTap: (){
      //         //  Navigator.push(context,
      //         //            MaterialPageRoute(builder: (context) => Admin()));

      //       },
      //                 child: Text("Update",
      //           style: GoogleFonts.josefinSans(
      //             textStyle: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 color: kCaptionColor,
      //                 fontSize: 18,
      //                 letterSpacing: 0),
      //           )),
      //     ),
      //     SizedBox(height: 4),
      //     Container(height: 1, width: 30, color: kPrimaryColor)
      //   ],
      // ),
      // SizedBox(width: 15),
      // Column(
      //   children: [
      //     Text("Orders",
      //         style: GoogleFonts.josefinSans(
      //           textStyle: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               color: kCaptionColor,
      //               fontSize: 18,
      //               letterSpacing: 0),
      //         )),
      //     SizedBox(height: 4),
      //     Container(height: 1, width: 30, color: kPrimaryColor)
      //   ],
      // ),
      SizedBox(width: 15),
    ]);
  }

  Widget header() {
    return Center(
      child: Column(
        children: [
          Text("Mr & Mrs - Design Wood Works",
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 18,
                    letterSpacing: 0),
              )),
          SizedBox(height: 9),
          Container(height: 1, width: 90, color: kCaptionColor)
          // Text("Design Wood Works",
          //     style: GoogleFonts.josefinSans(
          //       textStyle: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: kCaptionColor,
          //           fontSize: 10,
          //           letterSpacing: 0),
          //     )),
        ],
      ),
    );
  }

  Widget circleheader() {
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.danthree.com/wp-content/uploads/2019/04/Modern-bed-with-upholstered-headboard.jpg"),
                backgroundColor: kCaptionColor,
                radius: 50,
              ),
              SizedBox(height: 10),
              Text("Best Quality",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kCaptionColor,
                        fontSize: 12,
                        letterSpacing: 0),
                  )),
            ],
          ),
          Container(height: 3, width: 50, color: kPrimaryColor),
          Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://img.archiexpo.com/images_ae/photo-g/145180-15905145.webp"),
                backgroundColor: kCaptionColor,
                radius: 50,
              ),
              SizedBox(height: 10),
              Text("World Class",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kCaptionColor,
                        fontSize: 12,
                        letterSpacing: 0),
                  )),
            ],
          ),
          Container(height: 3, width: 50, color: kPrimaryColor),
          Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://5.imimg.com/data5/AA/KU/MY-60630852/iron-modern-table-500x500.jpg"),
                backgroundColor: kCaptionColor,
                radius: 50,
              ),
              SizedBox(height: 10),
              Text("Best Rate",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kCaptionColor,
                        fontSize: 12,
                        letterSpacing: 0),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
