import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_and_mrs/AddCategory.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/Registerer.dart';
import 'package:mr_and_mrs/addwood.dart';
import 'package:mr_and_mrs/uploader.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Register.dart';
import 'constants.dart';
import 'login.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  



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
            "Admin Panel",
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
      
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                         addcategory()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "ADD CATEGORY",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 3),
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
                        MaterialPageRoute(builder: (context) => addwood()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "ADD WOOD",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 3),
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
                        MaterialPageRoute(builder: (context) => UploadPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "UPLOAD ITEMS",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 3),
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
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "ALL ITEMS",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 3),
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
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 55,
                      //  width:20,

                      child: Center(
                        child: Text(
                          "ORDERS",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 3),
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
        ),
      ),
    );
  }
}
