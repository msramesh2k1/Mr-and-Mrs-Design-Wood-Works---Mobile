import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/DetailedScreen.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:provider/provider.dart';

import 'models/category_model.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList =
        Provider.of<List<CategoryModel>>(context);
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
            "Explore by Rooms",
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kBackgroundColor,
                  fontSize: 19,
                  letterSpacing: 1),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(categoryList[index].url),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.brown.withOpacity(0.3),
                                  BlendMode.srcATop))),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Center(
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                child: Text(
                                  categoryList[index].title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontSize: 24,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
