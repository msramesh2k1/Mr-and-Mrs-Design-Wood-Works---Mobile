import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorAlertDialog extends StatelessWidget
{
  final String message;
  const ErrorAlertDialog({Key key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      backgroundColor: Colors.white,
      key: key,
      content: Padding(
      
        padding: const EdgeInsets.all(1.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error,color: Colors.black),
            SizedBox(height:20),
            Text(
              message.toUpperCase(),style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                       color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ))),
                                               SizedBox(height:20),
                                               
          ],
        ),
      ),
          );
  }
}


	
	
	
