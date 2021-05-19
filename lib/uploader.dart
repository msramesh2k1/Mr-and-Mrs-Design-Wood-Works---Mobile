import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CustomDialog.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String _url = "https://google.com";
  @override
  void initState() {
    super.initState();
    MRANDMRS.sharedprefs.setString("PINEWOOD",
        "https://d2kxk2c617i0nn.cloudfront.net/image_resize/back/w1500/products/23_005--yellow_pine_softwood-s.jpg");
    print(MRANDMRS.sharedprefs.getString("PINEWOOD"));
    MRANDMRS.sharedprefs.setString("ASHWOOD",
        "https://i.pinimg.com/originals/9e/cd/0f/9ecd0f1fce66f986007fd608a1407189.jpg");
    MRANDMRS.sharedprefs.setString("BLACKWOOD",
        "https://cdn.shopify.com/s/files/1/2026/2511/products/african_blackwood_turning_squares_2_8f7f6894-d102-4ad3-b644-2891a93102e6.jpg?v=1571595097");
  }

  String imageUrl;
  double percent;
  int initialvalue = 1;
  File topimage;
  File sideimage;
  File mainimage;
  File image1;
  File image2;
  File image3;
  File image4;
  File image5;

  String _topimageurl;
  String _sideimageurl;
  String _mainimageurl;
  String image1url;
  String image2url;
  String image3url;
  String image4url;
  String image5url;

  //Image pickedImage;
  List<TextEditingController> itemcontrollers = new List();
  List<TextEditingController> thicknesscontrollers = new List();
  List<TextEditingController> lenghtcontrollers = new List();
  List<TextEditingController> widthcontrollers = new List();
  List<TextEditingController> costcontrollers = new List();

  File file;

  TextEditingController opricecontroller = new TextEditingController();
  TextEditingController commentscontroller = new TextEditingController();
  TextEditingController qnocontroller = new TextEditingController();
  TextEditingController itemcontroller = new TextEditingController();

  TextEditingController descriptioncontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController categorycontroller = new TextEditingController();
  TextEditingController productidcontroller = new TextEditingController();
  TextEditingController hdimensioncontroller = new TextEditingController();
  TextEditingController wdimensioncontroller = new TextEditingController();
  TextEditingController ddimensioncontroller = new TextEditingController();
  TextEditingController weightcontroller = new TextEditingController();
  TextEditingController warrantycontroller = new TextEditingController();
  // TextEditingController productidcontroller = new TextEditingController();

  TextEditingController tdimensioncontroller = new TextEditingController();
  TextEditingController witemdimensioncontroller = new TextEditingController();
  TextEditingController litemdimensioncontroller = new TextEditingController();

  TextEditingController link1 = new TextEditingController();
  TextEditingController link2 = new TextEditingController();
  TextEditingController link3 = new TextEditingController();
  TextEditingController link4 = new TextEditingController();
  TextEditingController link5 = new TextEditingController();
  TextEditingController controller0 = new TextEditingController();
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();

  var _woodlist = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_sharp,
                  color: Colors.white, size: 12)),
          leadingWidth: 25,
          title: Text(
            "UPLOAD ITEMS",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 3),
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: namecontroller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "NAME",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 160,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: productidcontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "PRODUCT ID",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 387,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: descriptioncontroller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "DESCRIPTION",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 270,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: categorycontroller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "CATEGORY",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            //  textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: pricecontroller,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "PRICE",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            //  textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: opricecontroller,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "O' PRICE",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 1, right: 1, bottom: 5),
                  child: Container(
                    color: Colors.white,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          height: 80,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Woods")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                    'No Data...',
                                  );
                                } else {
                                  return Scrollbar(
                                    //   isAlwaysShown: true,

                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        //                     gridDelegate:
                                        // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 11),

                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                height: 60,
                                                width: 70,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: IconButton(
                                                          onPressed: () {
                                                            if (_woodlist.contains(
                                                                snapshot.data
                                                                            .docs[
                                                                        index]
                                                                    ['name'])) {
                                                              setState(() {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "SearchProducts")
                                                                    .doc(productidcontroller
                                                                        .text
                                                                        .toString())
                                                                    .collection(
                                                                        "WoodList")
                                                                    .doc(snapshot
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'name'])
                                                                    .delete();
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "Items")
                                                                    .doc(categorycontroller
                                                                        .text
                                                                        .toString())
                                                                    .collection(
                                                                        "Products")
                                                                    .doc(productidcontroller
                                                                        .text
                                                                        .toString())
                                                                    .collection(
                                                                        "WoodList")
                                                                    .doc(snapshot
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'name'])
                                                                    .delete();
                                                                _woodlist.remove(
                                                                    snapshot.data
                                                                            .docs[index]
                                                                        [
                                                                        'name']);
                                                              });
                                                            } else {
                                                              setState(() {
                                                                _woodlist.add(snapshot
                                                                            .data
                                                                            .docs[
                                                                        index]
                                                                    ['name']);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "SearchProducts")
                                                                    .doc(productidcontroller
                                                                        .text
                                                                        .toString())
                                                                    .collection(
                                                                        "WoodList")
                                                                    .doc(snapshot
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'name'])
                                                                    .set({
                                                                  "name": snapshot
                                                                          .data
                                                                          .docs[
                                                                      index]['name'],
                                                                  "image": snapshot
                                                                          .data
                                                                          .docs[
                                                                      index]['image']
                                                                });
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "Items")
                                                                    .doc(categorycontroller
                                                                        .text
                                                                        .toString())
                                                                    .collection(
                                                                        "Products")
                                                                    .doc(productidcontroller
                                                                        .text
                                                                        .toString())
                                                                    .collection(
                                                                        "WoodList")
                                                                    .doc(snapshot
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'name'])
                                                                    .set({
                                                                  "name": snapshot
                                                                          .data
                                                                          .docs[
                                                                      index]['name'],
                                                                  "image": snapshot
                                                                          .data
                                                                          .docs[
                                                                      index]['image']
                                                                });
                                                              });
                                                            }
                                                          },
                                                          icon: Icon(
                                                              _woodlist.contains(snapshot
                                                                          .data
                                                                          .docs[index]
                                                                      ['name'])
                                                                  ? Icons
                                                                      .remove_circle_outline
                                                                  : Icons
                                                                      .add_circle_outline,
                                                              size: 20,
                                                              color: Colors
                                                                  .red[900])),
                                                      height: 69,
                                                      width: 280,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.white,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'image']),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        snapshot.data
                                                            .docs[index]['name']
                                                            .toUpperCase(),
                                                        style: GoogleFonts.lato(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 8,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    child: Center(
                      child: Text(
                        _woodlist.toString().toUpperCase(),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 10,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 17),
                    Text(
                      "TOP IMAGE",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: topimage == null
                          ? GestureDetector(
                              onTap: () async {
                                await ImagePicker().getImage(
                                        source: ImageSource.gallery)
                                    .then((image) {
                                  setState(() {
                                    topimage = File(image.path);
                                  });
                                });
                              },
                              child: Container(
                                  child: Center(
                                    child: Text(
                                      "TOP IMAGE",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38,
                                            fontSize: 10,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 100,
                                  width: 100),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: new FileImage(topimage),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 100,
                            ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Reference storageref = FirebaseStorage.instance
                            .ref()
                            .child("topof_${productidcontroller.text}.jpg");
                        UploadTask uploadTaskSnapshot =
                            storageref.putFile(topimage).whenComplete(() async {
                          setState(() async {
                            _topimageurl = await storageref.getDownloadURL();
                            print(_topimageurl);
                          });
                        });
                      },
                      child: Container(
                          child: Center(
                            child: Text(
                              "UPLOAD",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 10,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          height: 30,
                          width: 80),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: sideimage == null
                          ? GestureDetector(
                              onTap: () async {
                                await ImagePicker().getImage(
                                        source: ImageSource.gallery)
                                    .then((image) {
                                  setState(() {
                                    sideimage = File(image.path);
                                  });
                                });
                              },
                              child: Container(
                                  child: Center(
                                    child: Text(
                                      "SIDE IMAGE",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38,
                                            fontSize: 10,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 100,
                                  width: 100),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: new FileImage(sideimage),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 100,
                            ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Reference storageref = FirebaseStorage.instance
                            .ref()
                            .child("sideof_${productidcontroller.text}.jpg");
                        UploadTask uploadTaskSnapshot = storageref
                            .putFile(sideimage)
                            .whenComplete(() async {
                          setState(() async {
                            _sideimageurl = await storageref.getDownloadURL();
                            print(_sideimageurl);
                          });
                        });
                      },
                      child: Container(
                          child: Center(
                            child: Text(
                              "UPLOAD",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 10,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          height: 30,
                          width: 80),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mainimage == null
                          ? GestureDetector(
                              onTap: () async {
                                await ImagePicker().getImage(
                                        source: ImageSource.gallery)
                                    .then((image) {
                                  setState(() {
                                    mainimage = File(image.path);
                                  });
                                });
                              },
                              child: Container(
                                  child: Center(
                                    child: Text(
                                      "MAIN IMAGE",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38,
                                            fontSize: 10,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 100,
                                  width: 100),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: new FileImage(mainimage),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 100,
                              width: 100,
                            ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Reference storageref = FirebaseStorage.instance
                            .ref()
                            .child("mainof_${productidcontroller.text}.jpg");
                        UploadTask uploadTaskSnapshot = storageref
                            .putFile(mainimage)
                            .whenComplete(() async {
                          setState(() async {
                            _mainimageurl = await storageref.getDownloadURL();
                            print(_mainimageurl);
                          });
                        });
                      },
                      child: Container(
                          child: Center(
                            child: Text(
                              "UPLOAD",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 10,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          height: 30,
                          width: 80),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 17),
                    Text(
                      "IMAGES",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    height: 150,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: image1 == null
                                ? GestureDetector(
                                    onTap: () async {
                                      await ImagePicker().getImage(
                                              source: ImageSource.gallery)
                                          .then((image) {
                                        setState(() {
                                          image1 = File(image.path);
                                        });
                                      });
                                    },
                                    child: Container(
                                        child: Center(
                                          child: Text(
                                            "IMAGE1",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38,
                                                  fontSize: 10,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 100,
                                        width: 100),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new FileImage(image1),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(height: 4),
                                      GestureDetector(
                                        onTap: () async {
                                          Reference storageref = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child(
                                                  "image1of_${productidcontroller.text}.jpg");
                                          UploadTask uploadTaskSnapshot =
                                              storageref
                                                  .putFile(image1)
                                                  .whenComplete(() async {
                                            image1url = await storageref
                                                .getDownloadURL();
                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(categorycontroller.text)
                                                .collection("SearchProducts")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image1",
                                              "imgurl": image1url
                                            });
                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(categorycontroller.text)
                                                .collection("Products")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image1",
                                              "imgurl": image1url
                                            });
                                            print(image1url);
                                          });
                                        },
                                        child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPLOAD",
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 30,
                                            width: 80),
                                      )
                                    ],
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: image2 == null
                                ? GestureDetector(
                                    onTap: () async {
                                      await ImagePicker().getImage(
                                              source: ImageSource.gallery)
                                          .then((image) {
                                        setState(() {
                                          image2 = File(image.path);
                                        });
                                      });
                                    },
                                    child: Container(
                                        child: Center(
                                          child: Text(
                                            "IMAGE2",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38,
                                                  fontSize: 12,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 100,
                                        width: 100),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new FileImage(image2),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(height: 4),
                                      GestureDetector(
                                        onTap: () async {
                                          Reference storageref = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child(
                                                  "image2of_${productidcontroller.text}.jpg");
                                          UploadTask uploadTaskSnapshot =
                                              storageref
                                                  .putFile(image2)
                                                  .whenComplete(() async {
                                            image2url = await storageref
                                                .getDownloadURL();

                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(categorycontroller.text)
                                                .collection("Products")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image2",
                                              "imgurl": image2url
                                            });
                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(categorycontroller.text)
                                                .collection("SearchProducts")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image2",
                                              "imgurl": image2url
                                            });
                                            print(image1url);
                                            print(image2url);
                                          });
                                        },
                                        child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPLOAD",
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 30,
                                            width: 80),
                                      )
                                    ],
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: image3 == null
                                ? GestureDetector(
                                    onTap: () async {
                                      await ImagePicker().getImage(
                                              source: ImageSource.gallery)
                                          .then((image) {
                                        setState(() {
                                          image3 = File(image.path);
                                        });
                                      });
                                    },
                                    child: Container(
                                        child: Center(
                                          child: Text(
                                            "IMAGE3",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38,
                                                  fontSize: 12,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 100,
                                        width: 100),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new FileImage(image3),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(height: 4),
                                      GestureDetector(
                                        onTap: () async {
                                          Reference storageref = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child(
                                                  "image3of_${productidcontroller.text}.jpg");
                                          UploadTask uploadTaskSnapshot =
                                              storageref
                                                  .putFile(image3)
                                                  .whenComplete(() async {
                                            image3url = await storageref
                                                .getDownloadURL();

                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(categorycontroller.text)
                                                .collection("Products")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image3",
                                              "imgurl": image3url
                                            });
                                            FirebaseFirestore.instance
                                                .collection("SearchProducts")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image3",
                                              "imgurl": image3url
                                            });
                                            print(image1url);
                                            print(image3url);
                                          });
                                        },
                                        child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPLOAD",
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 30,
                                            width: 80),
                                      )
                                    ],
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: image4 == null
                                ? GestureDetector(
                                    onTap: () async {
                                      await ImagePicker().getImage(
                                              source: ImageSource.gallery)
                                          .then((image) {
                                        setState(() {
                                          image4 = File(image.path);
                                        });
                                      });
                                    },
                                    child: Container(
                                        child: Center(
                                          child: Text(
                                            "IMAGE4",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38,
                                                  fontSize: 12,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 100,
                                        width: 100),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new FileImage(image4),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(height: 4),
                                      GestureDetector(
                                        onTap: () async {
                                          Reference storageref = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child(
                                                  "image4of_${productidcontroller.text}.jpg");
                                          UploadTask uploadTaskSnapshot =
                                              storageref
                                                  .putFile(image4)
                                                  .whenComplete(() async {
                                            image4url = await storageref
                                                .getDownloadURL();

                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(categorycontroller.text)
                                                .collection("Products")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image4",
                                              "imgurl": image4url
                                            });
                                            FirebaseFirestore.instance
                                                .collection("SearchProducts")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image4",
                                              "imgurl": image4url
                                            });
                                            print(image1url);
                                            print(image4url);
                                          });
                                        },
                                        child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPLOAD",
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 30,
                                            width: 80),
                                      )
                                    ],
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: image5 == null
                                ? GestureDetector(
                                    onTap: () async {
                                      await ImagePicker().getImage(
                                              source: ImageSource.gallery)
                                          .then((image) {
                                        setState(() {
                                          image5 = File(image.path);
                                        });
                                      });
                                    },
                                    child: Container(
                                        child: Center(
                                          child: Text(
                                            "IMAGE5",
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38,
                                                  fontSize: 12,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 100,
                                        width: 100),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: new DecorationImage(
                                              image: new FileImage(image5),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(height: 4),
                                      GestureDetector(
                                        onTap: () async {
                                          Reference storageref = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child(
                                                  "image5of_${productidcontroller.text}.jpg");
                                          UploadTask uploadTaskSnapshot =
                                              storageref
                                                  .putFile(image5)
                                                  .whenComplete(() async {
                                            image5url = await storageref
                                                .getDownloadURL();

                                            FirebaseFirestore.instance
                                                .collection("Items")
                                                .doc(categorycontroller.text)
                                                .collection("Products")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image5",
                                              "imgurl": image5url
                                            });
                                            FirebaseFirestore.instance
                                                .collection("SearchProducts")
                                                .doc(productidcontroller.text
                                                    .toString())
                                                .collection("Images")
                                                .doc()
                                                .set({
                                              "name": "image5",
                                              "imgurl": image5url
                                            });
                                            print(image1url);
                                            print(image5url);
                                          });
                                        },
                                        child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPLOAD",
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: 30,
                                            width: 80),
                                      )
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 17),
                    Text(
                      "REQUIREMENTS LIST",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: hdimensioncontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "H",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "- H -",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: wdimensioncontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "W",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "- W -",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: ddimensioncontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "D",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "- D ",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: weightcontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "WEIGHT",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: warrantycontroller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "WARRANTY",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        width: 390,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: link1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "LINK 1",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        width: 390,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: link2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "LINK 2",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        width: 390,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: link3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "LINK 3",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        width: 390,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: link4,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "LINK 4",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        width: 390,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            // textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: Colors.black),
                            controller: link5,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "LINK 5",
                              labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Constants.padding),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                height: 500,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "WOOD LIST",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 18,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "MR AND MRD DESIGN WOOD WORKS",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 10,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 60,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                controller: qnocontroller,
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "NO.Q",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 160,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                controller: itemcontroller,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "ITEM",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 60,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                // textCapitalization: TextCapitalization.sentences,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                controller:
                                                    tdimensioncontroller,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "T",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "- T -",
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                fontSize: 16,
                                                letterSpacing: 2),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 60,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                // textCapitalization: TextCapitalization.sentences,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                controller:
                                                    witemdimensioncontroller,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "W",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "- W -",
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                fontSize: 16,
                                                letterSpacing: 2),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 60,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                // textCapitalization: TextCapitalization.sentences,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                controller:
                                                    litemdimensioncontroller,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "L",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "- L ",
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                fontSize: 16,
                                                letterSpacing: 2),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 80,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                controller: commentscontroller,
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "COMMENTS",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection("Items")
                                              .doc(categorycontroller.text
                                                  .toString())
                                              .collection("Products")
                                              .doc(productidcontroller.text
                                                  .toString())
                                              .collection("materials")
                                              .doc(Timeline.now.toString())
                                              .set({
                                            "name":
                                                itemcontroller.text.toString(),
                                            "quantity":
                                                qnocontroller.text.toString(),
                                            "tvalue": tdimensioncontroller.text
                                                .toString(),
                                            "wvalue": witemdimensioncontroller
                                                .text
                                                .toString(),
                                            "lvalue": litemdimensioncontroller
                                                .text
                                                .toString(),
                                            "comments": commentscontroller.text
                                                .toString()
                                          });
                                          itemcontroller.clear();
                                          qnocontroller.clear();
                                          tdimensioncontroller.clear();
                                          witemdimensioncontroller.clear();
                                          litemdimensioncontroller.clear();
                                          commentscontroller.clear();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "UPLOAD",
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                            ),
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            "WOODS REQUIRED",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      List<String> splitList =
                          namecontroller.text.toString().split(" ");
                      List<String> indexList = [];
                      for (int i = 0; i < splitList.length; i++) {
                        for (int j = 0; j < splitList[i].length + i; j++) {
                          indexList
                              .add(splitList[i].substring(0, j).toLowerCase());
                        }
                      }
                      FirebaseFirestore.instance
                          .collection("SearchProducts")
                          .doc(productidcontroller.text.toString())
                          .set({
                        "Description": descriptioncontroller.text.trim(),
                        "price":int.parse(pricecontroller.toString()),
                        "publishedDate": DateTime.now(),
                        "oprice": opricecontroller.text.toString(),
                        "category": categorycontroller.text.trim(),
                        "name": namecontroller.text.toString(),
                        "id": productidcontroller.text.toString(),
                        "topimage": _topimageurl,
                        "sideimage": _sideimageurl,
                        "mainimage": _mainimageurl,
                        "height": hdimensioncontroller.text.toString(),
                        "width": wdimensioncontroller.text.toString(),
                        "depth": ddimensioncontroller.text.toString(),
                        "weight": weightcontroller.text.toString(),
                        "warranty": warrantycontroller.text.toString(),
                        "index": indexList,
                        "link1": link1.text.toString(),
                        "link2": link2.text.toString(),
                        "link3": link3.text.toString(),
                        "link4": link4.text.toString(),
                        "link5": link5.text.toString(),
                      });
                      FirebaseFirestore.instance
                          .collection("Items")
                          .doc(categorycontroller.text)
                          .collection("Products")
                          .doc(productidcontroller.text.toString())
                          .set({
                        "link1": link1.text.toString(),
                        "link2": link2.text.toString(),
                        "link3": link3.text.toString(),
                        "link4": link4.text.toString(),
                        "link5": link5.text.toString(),
                        "Description": descriptioncontroller.text.trim(),
                        "price": int.parse(pricecontroller.toString()),
                        "publishedDate": DateTime.now(),
                        "oprice": opricecontroller.text.toString(),
                        "category": categorycontroller.text.trim(),
                        "name": namecontroller.text.toString(),
                        "id": productidcontroller.text.toString(),
                        "topimage": _topimageurl,
                        "sideimage": _sideimageurl,
                        "mainimage": _mainimageurl,
                        "height": hdimensioncontroller.text.toString(),
                        "width": wdimensioncontroller.text.toString(),
                        "depth": ddimensioncontroller.text.toString(),
                        "weight": weightcontroller.text.toString(),
                        "warranty": warrantycontroller.text.toString(),
                        "index": indexList
                      });

                      link1.clear();
                      // link2.clear();
                      // link3.clear();
                      // link4.clear();
                      // link5.clear();

                      // pricecontroller.clear();
                      // opricecontroller.clear();
                      // categorycontroller.clear();
                      // namecontroller.clear();
                      // productidcontroller.clear();
                      // hdimensioncontroller.clear();
                      // wdimensioncontroller.clear();
                      // ddimensioncontroller.clear();
                      // weightcontroller.clear();
                      // warrantycontroller.clear();
                      // descriptioncontroller.clear();
                      setState(() {
                        topimage = null;
                        sideimage = null;
                        mainimage = null;
                        image1 = null;
                        image2 = null;
                        image3 = null;
                        image4 = null;
                        image5 = null;
                        _woodlist = [];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            "UPLOAD",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    )),
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
                // Row(
                //   children: [
                //     SizedBox(width: 17),
                //     Text(
                //       "REQUIREMENTS LIST",
                //       style: GoogleFonts.lato(
                //         textStyle: TextStyle(
                //             fontWeight: FontWeight.normal,
                //             color: Colors.black,
                //             fontSize: 16,
                //             letterSpacing: 2),
                //       ),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     child: Row(
                //       children: [
                //         SizedBox(width: 17),
                //         Text(
                //           "NO OF LIST ITEMS           :  ",
                //           style: GoogleFonts.lato(
                //             textStyle: TextStyle(
                //                 fontWeight: FontWeight.normal,
                //                 color: Colors.black,
                //                 fontSize: 16,
                //                 letterSpacing: 2),
                //           ),
                //         ),
                //         IconButton(
                //           onPressed: () {
                //             if (initialvalue >= 1) {
                //               setState(() {
                //                 initialvalue--;
                //               });
                //             }
                //           },
                //           icon: Icon(Icons.remove_circle_outline,
                //               color: Colors.black),
                //         ),
                //         Container(
                //             child: Center(
                //               child: Text(
                //                 initialvalue.toString(),
                //                 style: GoogleFonts.lato(
                //                   textStyle: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.black,
                //                       fontSize: 16,
                //                       letterSpacing: 2),
                //                 ),
                //               ),
                //             ),
                //             decoration: BoxDecoration(
                //               color: Colors.grey[900],
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             height: 20,
                //             width: 60),
                //         IconButton(
                //             onPressed: () {
                //               setState(() {
                //                 initialvalue++;
                //               });
                //             },
                //             icon: Icon(Icons.add_circle_outline,
                //                 color: Colors.black))
                //       ],
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.grey[200],
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     height: 50,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Container(
                //     height: 500,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[700],
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: ListView.builder(
                //         itemCount: initialvalue,
                //         itemBuilder: (BuildContext context, int index) {
                //           itemcontrollers.add(new TextEditingController());
                //           lenghtcontrollers.add(new TextEditingController());
                //           widthcontrollers.add(new TextEditingController());
                //           costcontrollers.add(new TextEditingController());
                //           thicknesscontrollers.add(new TextEditingController());
                //           return Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Container(
                //               child: Row(
                //                 children: [
                //                   SizedBox(width: 20),
                //                   Container(
                //                       child: Text(
                //                         index.toString(),
                //                         style: GoogleFonts.lato(
                //                           textStyle: TextStyle(
                //                               fontWeight: FontWeight.bold,
                //                               color: Colors.black,
                //                               fontSize: 16,
                //                               letterSpacing: 2),
                //                         ),
                //                       ),
                //                       decoration: BoxDecoration(
                //                         //color: Colors.grey[200],
                //                         borderRadius: BorderRadius.circular(20),
                //                       ),
                //                       height: 20,
                //                       width: 20),
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 8.0, bottom: 8.0),
                //                     child: VerticalDivider(
                //                       color: Colors.black,
                //                       thickness: 1,
                //                     ),
                //                   ),
                //                   Container(
                //                     child: TextField(
                //                       textCapitalization:
                //                           TextCapitalization.sentences,
                //                       style: TextStyle(color: Colors.black),
                //                       controller: itemcontrollers[index],
                //                       keyboardType: TextInputType.name,
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                         hintText: "ITEM",
                //                         hintStyle: TextStyle(
                //                             color: Colors.black, fontSize: 10),
                //                       ),
                //                     ),
                //                     height: 100,
                //                     width: 30,
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey[200],
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 8.0, bottom: 8.0),
                //                     child: VerticalDivider(
                //                       color: Colors.black,
                //                       thickness: 1,
                //                     ),
                //                   ),

                //                   Container(
                //                     child: TextField(
                //                       textCapitalization:
                //                           TextCapitalization.sentences,
                //                       style: TextStyle(color: Colors.black),
                //                       controller: thicknesscontrollers[index],
                //                       keyboardType: TextInputType.name,
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                         labelText: "THICKNESS",
                //                         labelStyle: TextStyle(
                //                             color: Colors.black, fontSize: 10),
                //                       ),
                //                     ),
                //                     height: 100,
                //                     width: 50,
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey[200],
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 8.0, bottom: 8.0),
                //                     child: VerticalDivider(
                //                       color: Colors.black,
                //                       thickness: 1,
                //                     ),
                //                   ),
                //                   Container(
                //                     child: TextField(
                //                       textCapitalization:
                //                           TextCapitalization.sentences,
                //                       style: TextStyle(color: Colors.black),
                //                       //  controller: controller2,
                //                       controller: lenghtcontrollers[index],
                //                       keyboardType: TextInputType.name,
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                         labelText: "LENGHT",
                //                         labelStyle: TextStyle(
                //                             color: Colors.black, fontSize: 10),
                //                       ),
                //                     ),
                //                     height: 100,
                //                     width: 50,
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey[200],
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 8.0, bottom: 8.0),
                //                     child: VerticalDivider(
                //                       color: Colors.black,
                //                       thickness: 1,
                //                     ),
                //                   ),
                //                   Container(
                //                     child: TextField(
                //                       textCapitalization:
                //                           TextCapitalization.sentences,
                //                       style: TextStyle(color: Colors.black),
                //                       //      controller: controller2,
                //                       controller: widthcontrollers[index],
                //                       keyboardType: TextInputType.name,
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                         labelText: "WIDTH",
                //                         labelStyle: TextStyle(
                //                             color: Colors.black, fontSize: 10),
                //                       ),
                //                     ),
                //                     height: 100,
                //                     width: 50,
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey[200],
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 8.0, bottom: 8.0),
                //                     child: VerticalDivider(
                //                       color: Colors.black,
                //                       thickness: 1,
                //                     ),
                //                   ),
                //                   Container(
                //                     child: TextField(
                //                       textCapitalization:
                //                           TextCapitalization.sentences,
                //                       style: TextStyle(color: Colors.black),
                //                       //    controller: controller2,
                //                       controller: costcontrollers[index],
                //                       keyboardType: TextInputType.name,
                //                       decoration: InputDecoration(
                //                         border: InputBorder.none,
                //                         labelText: "COST",
                //                         labelStyle: TextStyle(
                //                             color: Colors.black, fontSize: 10),
                //                       ),
                //                     ),
                //                     height: 100,
                //                     width: 30,
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey[200],
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                   // Padding(
                //                   //     padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                //                   //     child: VerticalDivider(color:Colors.black,thickness:1,),
                //                   //   ),
                //                 ],
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[200],
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               height: 60,
                //             ),
                //           );
                //         }),
                //   ),
                // ),
                // GestureDetector(
                //     onTap: () {},
                //     child: Padding(
                //       padding: const EdgeInsets.all(13.0),
                //       child: Container(
                //           child: Center(
                //             child: GestureDetector(
                //               onTap: _launchURL,
                //               child: Container(
                //                   color: Colors.grey[600],
                //                   height: 50,
                //                   width: 100),
                //             ),
                //           ),
                //           height: 100,
                //           decoration: BoxDecoration(
                //             color: Colors.grey[200],
                //             borderRadius: BorderRadius.circular(20),
                //           )),
                //     )),
                // Divider(color: Colors.black),
                // SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     uploadandsaveiteminfo();
                //   },
                //   child: Container(
                //     child: Padding(
                //       padding: const EdgeInsets.only(
                //           left: 30.0, right: 30, top: 10, bottom: 10),
                //       child: Text(
                //         "UPLOAD",
                //         style: GoogleFonts.lato(
                //           textStyle: TextStyle(
                //               fontWeight: FontWeight.normal,
                //               color: Colors.black,
                //               fontSize: 16,
                //               letterSpacing: 2),
                //         ),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //         color: Colors.red[900],
                //         borderRadius: BorderRadius.circular(8)),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _imgFromCamera() async {
  //   File image = await ImagePicker().getImage(
  //       source: ImageSource.camera, imageQuality: 50);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  // _imgFromGallery() async {
  //   File image = await ImagePicker().getImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       _imgFromGallery();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     _imgFromCamera();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  clearinfo() {
    setState(() {
      file = null;
      namecontroller.clear();

      descriptioncontroller.clear();
      pricecontroller.clear();
      categorycontroller.clear();
    });
  }

  uploadandsaveiteminfo() async {
    // fb.StorageReference storageref = fb.storage().ref("images1");
    // fb.UploadTaskSnapshot uploadTaskSnapshot =
    //     await storageref.put(pickedImage).future;
    // Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    // print("1010101010010101" + imageUri.toString());
    // _woodlist.forEach((element) {
    //   print("HLO NAVEE" + element);
    //   FirebaseFirestore.instance
    //       .collection("Products")
    //       .doc(productidcontroller.text.toString())
    //       .collection("woodu")
    //       .doc()
    //       .set({
    //     "name": element,
    //     "imgurl": MRANDMRS.sharedprefs.getString(element)
    //   });
    // });

    //      itemcontrollers.forEach((_items) {
    //  //   print("HLO NAVEE" + items);
    //     FirebaseFirestore.instance
    //         .collection("Products")
    //         .doc(productidcontroller.text.toString())
    //         .collection("req")
    //         .doc()
    //         .set({
    //       "name": _items,
    //      // "imgurl": MRANDMRS.sharedprefs.getString(element)
    //     });
    //   });
    //print(itemcontrollers);
    List<String> splitList = namecontroller.text.split(" ");
    List<String> indexList = [];
    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + i; j++) {
        indexList.add(splitList[i].substring(0, j).toLowerCase());
      }
    }
    FirebaseFirestore.instance
        .collection("Items")
        .doc("chair")
        .collection("Products")
        .doc(productidcontroller.text.toString())
        .set({
      "Description": descriptioncontroller.text.trim(),
      "price": int.parse(pricecontroller.toString()),
      // "image": __image,
      "publishedDate": DateTime.now(),
      "oprice": "2399",
      // "items": _woodlist,
      // "req1": itemcontrollers[0].text,

      //  "ratings": ratingscontroller.text,
      //  "fav": false,
      "category": categorycontroller.text.trim(),
      "name": namecontroller.text.toString(),

      "id": productidcontroller.text.toString(),
      "title": indexList,
    });
    // FirebaseFirestore.instance
    //     .collection("Products")
    //     .doc("201")
    //     .collection("woodlist")
    //     .doc("woodlist")
    //     .set({"woodlist": _woodlist});
    // setState(() {
    //   // descriptioncontroller.clear();
    //   // pricecontroller.clear();

    //   // categorycontroller.clear();
    //   // namecontroller.clear();
    //   // productidcontroller.clear();
    // });
  }

  void _launchURL() async {
    await canLaunch(_url)
        ? await launch(_url)
        : throw "COULD NOT LAUNCH IT $_url";
  }
}

// identifier() {
//   return controller0;
// }
// SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             Container(
                //               child: IconButton(
                //                   onPressed: () {
                //                     print(_woodlist);
                                   
                //                   },
                //                   icon: Icon(
                //                       _woodlist.contains("PINEWOOD")
                //                           ? Icons.remove_circle_outline
                //                           : Icons.add_circle_outline,
                //                       color: Colors.red[900])),
                //               decoration: BoxDecoration(
                //                   color: Colors.red,
                //                   borderRadius: BorderRadius.circular(10),
                //                   image: DecorationImage(
                //                       image: NetworkImage(
                //                           "https://d2kxk2c617i0nn.cloudfront.net/image_resize/back/w1500/products/23_005--yellow_pine_softwood-s.jpg"),
                //                       fit: BoxFit.cover)),
                //               height: 60,
                //               width: 60,
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Container(
                //               child: Center(
                //                 child: Text(
                //                   "PINEWOOD",
                //                   style: GoogleFonts.lato(
                //                     textStyle: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.black,
                //                         fontSize: 10,
                //                         letterSpacing: 1),
                //                   ),
                //                 ),
                //               ),
                //               height: 10,
                //               width: 70,
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             Container(
                //               child: IconButton(
                //                   onPressed: () {
                //                     print(_woodlist);
                //                     if (_woodlist.contains("ASHWOOD")) {
                //                       setState(() {
                //                         _woodlist.remove("ASHWOOD");
                //                       });
                //                     } else {
                //                       setState(() {
                //                         _woodlist.add("ASHWOOD");
                //                       });
                //                     }
                //                   },
                //                   icon: Icon(
                //                       _woodlist.contains("ASHWOOD")
                //                           ? Icons.remove_circle_outline
                //                           : Icons.add_circle_outline,
                //                       color: Colors.red[900])),
                //               decoration: BoxDecoration(
                //                   color: Colors.red,
                //                   borderRadius: BorderRadius.circular(10),
                //                   image: DecorationImage(
                //                       image: NetworkImage(
                //                           "https://i.pinimg.com/originals/9e/cd/0f/9ecd0f1fce66f986007fd608a1407189.jpg"),
                //                       fit: BoxFit.cover)),
                //               height: 60,
                //               width: 60,
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Container(
                //               child: Center(
                //                 child: Text(
                //                   "ASHWOOD",
                //                   style: GoogleFonts.lato(
                //                     textStyle: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.black,
                //                         fontSize: 10,
                //                         letterSpacing: 1),
                //                   ),
                //                 ),
                //               ),
                //               height: 10,
                //               width: 70,
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             Container(
                //               child: IconButton(
                //                   onPressed: () {
                //                     print(_woodlist);
                //                     if (_woodlist.contains("BLACKWOOD")) {
                //                       setState(() {
                //                         _woodlist.remove("BLACKWOOD");
                //                       });
                //                     } else {
                //                       setState(() {
                //                         _woodlist.add("BLACKWOOD");
                //                       });
                //                     }
                //                   },
                //                   icon: Icon(
                //                       _woodlist.contains("BLACKWOOD")
                //                           ? Icons.remove_circle_outline
                //                           : Icons.add_circle_outline,
                //                       color: Colors.red[900])),
                //               decoration: BoxDecoration(
                //                   color: Colors.red,
                //                   borderRadius: BorderRadius.circular(10),
                //                   image: DecorationImage(
                //                       image: NetworkImage(
                //                           "https://cdn.shopify.com/s/files/1/2026/2511/products/african_blackwood_turning_squares_2_8f7f6894-d102-4ad3-b644-2891a93102e6.jpg?v=1571595097"),
                //                       fit: BoxFit.cover)),
                //               height: 60,
                //               width: 60,
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Container(
                //               child: Center(
                //                 child: Text(
                //                   "BLACKWOOD",
                //                   style: GoogleFonts.lato(
                //                     textStyle: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.black,
                //                         fontSize: 10,
                //                         letterSpacing: 1),
                //                   ),
                //                 ),
                //               ),
                //               height: 10,
                //               width: 70,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),