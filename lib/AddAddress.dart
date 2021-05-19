import 'package:toast/toast.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/constants.dart';
import 'AddressINfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAddress extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final scafoldKey = GlobalKey<ScaffoldState>();
  final addressName = TextEditingController();
  final addressPhoneNumber = TextEditingController();
  final addressFlatNumber = TextEditingController();
  final addressstreet1 = TextEditingController();
  final addressstreet2 = TextEditingController();
  final addressDistrict = TextEditingController();
  final addressstate = TextEditingController();
  final addresscountry = TextEditingController();
  final addresspincode = TextEditingController();

  String addressid = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp,
                color: kBackgroundColor, size: 12)),
        leadingWidth: 25,
        title: Text(
          "Add Address",
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: kBackgroundColor,
                fontSize: 20,
                letterSpacing: 0),
          ),
        ),
        backgroundColor: Colors.teal[900].withOpacity(0.4),
        elevation: 0,
      ),
      key: scafoldKey,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 700,
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(children: [
                  MyTextField(
                    hint: "NAME",
                    controller: addressName,
                    height: 60,
                  ),
                  MyTextField(
                    hint: "PHONE NUMBER",
                    controller: addressPhoneNumber,
                    height: 60,
                  ),
                  MyTextField(
                    hint: "FLAT NO / DOOR NO",
                    controller: addressFlatNumber,
                    height: 60,
                  ),
                  MyTextField(
                      hint: "STREET ADDRESS - LINE 1",
                      controller: addressstreet1,
                      height: 60),
                  MyTextField(
                      hint: "STREET ADDRESS - LINE 2",
                      controller: addressstreet2,
                      height: 60),
                  MyTextField(
                      hint: "DISTRICT",
                      controller: addressDistrict,
                      height: 60),
                  MyTextField(
                      hint: "STATE", controller: addressstate, height: 60),
                  MyTextField(
                      hint: "COUNTRY", controller: addresscountry, height: 60),
                  MyTextField(
                      hint: "PINCODE", controller: addresspincode, height: 60),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  )
                ]),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (formkey.currentState.validate()) {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(MRANDMRS.sharedprefs.getString("uid"))
                    .collection("address")
                    .doc(DateTime.now().millisecondsSinceEpoch.toString())
                    .set({
                  "id": addressid.toString(),
                  "name": addressName.text.trim(),
                  "street1": addressstreet1.text.trim(),
                  "street2": addressstreet2.text.trim(),
                  "country": addresscountry.text.trim(),
                  "state": addressstate.text.trim(),
                  "pincode": addresspincode.text.trim(),
                  "phoneNumber": addressPhoneNumber.text.trim(),
                  "flatNumber": addressFlatNumber.text.trim(),
                  "city": addressDistrict.text.trim(),
                }).then((value) {
                  Toast.show("Address added Successfully", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  FocusScope.of(context).requestFocus(FocusNode());
                  formkey.currentState.reset();
                });
           //     Navigator.pop(context);
              }
            },
            child: Container(
              child: Center(
                child: Text("Add Address",
                    style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                      letterSpacing: 0,
                      decoration: TextDecoration.none,
                      color: kBackgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ))),
              ),
              color: Colors.teal[900].withOpacity(0.4),
              height: 60,
            ),
          )
        ],
      )),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int height;

  MyTextField({Key key, this.hint, this.controller, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4, right: 4, top: 4),
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueGrey[60],
        ),
        child: Container(
          height: height.toDouble(),
          child: TextFormField(
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black),
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: hint,
                labelStyle: TextStyle(color: Colors.black54, fontSize: 10),
              ),
              validator: (val) =>
                  val.isEmpty ? "Field can not be Empty" : null),
        ),
      ),
    );
  }
}
