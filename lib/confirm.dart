import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/constants.dart';

import 'login.dart';
class ConfirmEmail extends StatelessWidget {
  static String id = 'confirm-email';
  final String message;

  const ConfirmEmail({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top:80.0,left: 20,right: 20),
                  child: Center(
                    child: Text(
                                      message.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kCaptionColor,
                                            fontSize: 12,
                                            letterSpacing: 1),
                                      ),
                                    ),
                  ),
                )),
                
                     Center(
                       child: GestureDetector(
                         onTap: ()
                         {
                            Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => Login()));
                                 
                         },
                         child: Padding(
                           padding: const EdgeInsets.only(left:60.0,right:60,bottom: 20),
                           child: Container(
                             decoration: BoxDecoration(
                                 color:kBackgroundColor,
                               borderRadius: BorderRadius.circular(10)
                             ),
                             height:45,
                             width:120,
                      
              
                            child: Center(
                              child: Text(
                                    "COUNTIUE",
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
          ],
        ),
      ),
    );
  }
}
