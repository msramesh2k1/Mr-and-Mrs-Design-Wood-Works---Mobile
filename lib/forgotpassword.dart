import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/constants.dart';

import 'confirm.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';
  final String message =
      "An email has just been sent to you, Click the link provided to complete password reset";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String _email;

  _passwordReset() async {
    try {
      _formKey.currentState.save();
      final user = await _auth.sendPasswordResetEmail(email: _email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ConfirmEmail(
            message: widget.message,
          );
        }),
      );
    } catch (e) {
      print(e);
    }
  }

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
            "Reset Password",
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
        body: Form(
    key: _formKey,
    child: Padding(
      padding: EdgeInsets.all(10),
    //  padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Enter Email",
            style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kCaptionColor,
                  fontSize:18,
                  letterSpacing: 0),
            ),
          ),
          SizedBox(height: 20,),
          Container(
        decoration: BoxDecoration(
          color:Colors.grey[200],borderRadius:BorderRadius.circular(4)
        ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onSaved: (newEmail) {
                  _email = newEmail;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  // icon: Icon(
                  //   Icons.mail,
                  //   color: Colors.black,
                  // ),
                  errorStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {
                _passwordReset();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  height: 45,
                   width:120,

                  child: Center(
                    child: Text(
                      "SEND LINK",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 14,
                            letterSpacing: 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        
        ],
      ),
    ),
        ),
      );
  }
}
