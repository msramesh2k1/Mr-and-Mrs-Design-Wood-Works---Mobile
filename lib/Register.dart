// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mr_and_mrs/ErrorAlert.dart';
// import 'package:mr_and_mrs/Helper.dart';
// import 'package:mr_and_mrs/HomScreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mr_and_mrs/login.dart';

// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => new _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   bool _password = true;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController emailcontroller = new TextEditingController();
//   final TextEditingController resetemailtexteditingcontroller =
//       new TextEditingController();
//   final TextEditingController passwordcontroller = new TextEditingController();
//   final TextEditingController namecontroller = new TextEditingController();

//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _password = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: new NetworkImage(
//                       "https://images.unsplash.com/photo-1449247709967-d4461a6a6103?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mzh8fHxlbnwwfHx8&w=1000&q=80"),
//                   fit: BoxFit.cover)),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.only(top:70),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(left:20.0),
//                         child: Text(
//                                   "Hello",
//                                   style: GoogleFonts.josefinSans(
//                                     textStyle: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                         fontSize: 58,
//                                         letterSpacing: 0),
//                                   ),
//                                 ),
//                       ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left:20.0),
//                                 child: Text(
//                                   "Users . ",
//                                   style: GoogleFonts.josefinSans(
//                                     textStyle: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                         fontSize: 58,
//                                         letterSpacing: 0),
//                                   ),
//                                 ),
//                               ),
                     
                  
//                     Container(
//                         padding:
//                             EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
//                         child: Column(
//                           children: <Widget>[
//                             TextField(
//                               cursorColor: Colors.green[900],
//                               controller: namecontroller,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: InputDecoration(
//                                   labelText: 'NAME',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'Montserrat',
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.green[900]))),
//                             ),
//                             SizedBox(height: 20.0),
//                             TextField(
//                               cursorColor: Colors.green[900],
//                               controller: emailcontroller,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: InputDecoration(
//                                   labelText: 'EMAIL',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'Montserrat',
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.green[900]))),
//                             ),
//                             SizedBox(height: 20.0),
//                             TextField(
//                               controller: passwordcontroller,
//                               decoration: InputDecoration(
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                         _password
//                                             ? Icons.visibility
//                                             : Icons.visibility_off,
//                                         color: Colors.black),
//                                     onPressed: () {
//                                       setState(() {
//                                         _password = !_password;
//                                       });
//                                     },
//                                   ),
//                                   labelText: 'PASSWORD',
//                                   labelStyle: TextStyle(
//                                       fontFamily: 'Montserrat',
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.green[900]))),
//                               obscureText: !_password,
//                               cursorColor: Colors.green[900],
//                             ),
//                             SizedBox(height: 1.0),
//                             SizedBox(height: 90.0),
//                             Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   emailcontroller.text.isNotEmpty &&
//                                           passwordcontroller.text.isNotEmpty &&
//                                           namecontroller.text.isNotEmpty
//                                       ? _Registerform()
//                                       : showDialog(
//                                           context: context,
//                                           builder: (c) {
//                                             return ErrorAlertDialog(
//                                                 message: "Fill Completely");
//                                           });
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 60.0, right: 60),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius: BorderRadius.circular(10)),
//                                     height: 45,
//                                     //  width:20,

//                                     child: Center(
//                                       child: Text(
//                                         "REGISTER",
//                                         style: GoogleFonts.lato(
//                                           textStyle: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               letterSpacing: 3),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         )),
//                     SizedBox(height: 10.0),
//                     GestureDetector(
//                       onTap: () {
//                         Route route =
//                             MaterialPageRoute(builder: (context) => Login());
//                         Navigator.push(context, route);
//                       },
//                       child: Container(
//                         height: 50,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               'Already an User ?',
//                               style: TextStyle(fontFamily: 'Montserrat'),
//                             ),
//                             SizedBox(width: 5.0),
//                             Text(
//                               "Log In",
//                               style: GoogleFonts.lato(
//                                 textStyle: TextStyle(
//                                     fontWeight: FontWeight.w900,
//                                     color: Colors.green[900],
//                                     fontSize: 12,
//                                     letterSpacing: 1),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }

//   Future<void> _Registerform() async {
//     User firebaseUser;
//     await _auth
//         .createUserWithEmailAndPassword(
//             email: emailcontroller.text, password: passwordcontroller.text)
//         .then((auth) {
//       firebaseUser = auth.user;
//     });
//     print("uid = " + firebaseUser.uid);
//     //  Fluttertoast.showToast(msg: 'Registered In Successfully',
//     //       toastLength: Toast.LENGTH_SHORT,
//     //       gravity: ToastGravity.BOTTOM,
//     //       timeInSecForIos: 3,
//     //       backgroundColor: Colors.black,
//     //       textColor: Colors.white,

//     //   );
//     // Fluttertoast.showToast(msg: 'Welcome !',
//     //     toastLength: Toast.LENGTH_LONG,
//     //     gravity: ToastGravity.BOTTOM,
//     //     timeInSecForIos: 3,
//     //     backgroundColor: Colors.black,
//     //     textColor: Colors.white,

//     // );
//     if (firebaseUser != null) {
//       print("Account Created Successfully");
//       FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).set({
//         "uid": firebaseUser.uid,
//         "email": firebaseUser.email,
//         "name": namecontroller.text.trim(),
//         "password": passwordcontroller.text.trim(),
//       });
//       MRANDMRS.sharedprefs.setString("uid", firebaseUser.uid);
//       MRANDMRS.sharedprefs.setString("email", firebaseUser.email)      ;
//       MRANDMRS.sharedprefs.setString("name", namecontroller.text)
//       .then((value) {
//         Navigator.pop(context);
//         Route route = MaterialPageRoute(builder: (context) => HomeScreen());
//         Navigator.pushReplacement(context, route);
//       });
//     }
//   }
// }
