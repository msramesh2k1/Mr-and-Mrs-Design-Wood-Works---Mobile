//               child: Expanded(
//                   child: SingleChildScrollView(
//                 child: Container(
//                   // decoration: BoxDecoration(
//                   //   borderRadius:BorderRadius.circular(20),
//                   //   color:Colors.grey.withOpacity(0.1),
//                   // ),
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     children: <Widget>[
//                       Text("LOGIN",
//                           style: GoogleFonts.cinzel(
//                               textStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.normal,
//                           ))),
//                       SizedBox(height: 25),
//                       Container(
//                         padding: EdgeInsets.only(left: 20.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.grey.withOpacity(0.2),
//                         ),
//                         child: TextField(
//                           style: TextStyle(color: Colors.black),
//                           controller: emailtexteditingcontroller,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             labelText: "Email ",
//                             labelStyle: TextStyle(color: Colors.black54),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         padding: EdgeInsets.only(left: 20.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.grey.withOpacity(0.2),
//                         ),
//                         child: TextField(
//                           obscureText: !_passwordVisible,
//                           style: TextStyle(color: Colors.black),
//                           controller: passwordtexteditingcontroller,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                   _passwordVisible
//                                       ? Icons.visibility
//                                       : Icons.visibility_off,
//                                   color: Colors.black54),
//                               onPressed: () {
//                                 setState(() {
//                                   _passwordVisible = !_passwordVisible;
//                                 });
//                               },
//                             ),
//                             border: InputBorder.none,
//                             labelText: "Password ",
//                             labelStyle: TextStyle(color: Colors.black54),
//                           ),
//                         ),
//                       ),

//                       // FlatButton(
//                       //   onPressed: (){
//                       //      }),
// //           if (!_open) {
// //             _controller = _formkey.currentState.showBottomSheet(
// //               (_) =>
// //                Container(
// //                  height: 150,
// //                             padding: EdgeInsets.all(20.0),
// //                             decoration: BoxDecoration(
// //                                color: Color(0xececec),
// //                               border: Border(
// //                               top: BorderSide(
// //                                   width: 1,
// //                               color:Colors.lightblue38,
// //                                 ),
// //                               ),
// //                             ),
// //                             child: Column(
// //                               children: [
// //                                 TextField(
// //                                   style: TextStyle(color:Colors.black),
// //                                   controller: resetemailtexteditingcontroller,
// //                                   keyboardType: TextInputType.emailAddress,
// //                                                              decoration: InputDecoration(

// //                                     border: InputBorder.none,
// //                                                                  labelText: "Email : ",
// //                                     labelStyle: TextStyle(color: Colors.lightblue54),

// //                                   ),
// //                                 ),
// //                                  OutlineButton(

// //                   highlightedBorderColor: Colors.black,
// //                   padding: EdgeInsets.symmetric(horizontal:26,vertical:10),
// //                   onPressed: ()async
// //                 {
// //                   resetemailtexteditingcontroller.text.isNotEmpty ?

// //     _auth.sendPasswordResetEmail(email: resetemailtexteditingcontroller.text.toString())
// //     .then((value) => Navigator.pop(context)).then((value) =>

// // Fluttertoast.showToast(msg: 'Reset Email has been sent',
// //           toastLength: Toast.LENGTH_LONG,
// //           gravity: ToastGravity.CENTER,
// //           timeInSecForIos: 5,
// //           backgroundColor: Colors.lightblue54,
// //           textColor: Colors.black,

// //       ))
// //     :
// //    Fluttertoast.showToast(msg: 'Enter email to proceed',
// //           toastLength: Toast.LENGTH_LONG,
// //           gravity: ToastGravity.CENTER,
// //           timeInSecForIos: 5,
// //           backgroundColor: Colors.lightblue54,
// //           textColor: Colors.black,

// //       );

// //                  },
// //              child: Text(
// //                    "Proceed",
// //                    style: GoogleFonts.juliusSansOne(
// //                      textStyle: TextStyle(
// //                      color:Colors.black,
// //                      fontSize: 18,
// //                      fontWeight: FontWeight.normal,
// //                    ))
// //                    ),
// //                                     borderSide: BorderSide(color:Colors.black),
// //                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
// //                                     ),

// //                               ],
// //                             ),
// //                           ),

// //             );
// //           } else {
// //             _controller.close();
// //           }
// //           setState(() => _open = !_open);

// //                     },
// //                                     child: Center(
// //                       child: Text(

// //                         "Forget Password ?",
// //                         style: GoogleFonts.juliusSansOne(
// //                           textStyle: TextStyle(

// //                           color: Colors.black,
// //                           fontSize: 12,
// //                           fontWeight: FontWeight.normal,
// //                         ))
// //                         ),
// //                       ),
// //                   ),
//                     ],
//                   ),
//                 ),
//               )),
//             ),

//             FlatButton(
//               color: Colors.black,
//               padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),

//               onPressed: () async {
//                 emailtexteditingcontroller.text.isNotEmpty &&
//                         passwordtexteditingcontroller.text.isNotEmpty
//                     ? _loginform()
//                     : showDialog(
//                         context: context,
//                         builder: (c) {
//                           return ErrorAlertDialog(
//                               message: "Provide Email and Password");
//                         });
//               },
//               child: Text("Login",
//                   style: GoogleFonts.cinzel(
//                       textStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.normal,
//                   ))),
//               //   borderSide: BorderSide(color:Colors.black),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0)),
//             ),

//             // OutlineButton(
//             //   highlightedBorderColor: Colors.black,
//             //    padding: EdgeInsets.symmetric(horizontal:73),

//             //  onPressed: () async {

//             //                    },
//             //                                   child: Text(
//             //                     "Login",
//             //                     style: GoogleFonts.cinzel(
//             //                       textStyle: TextStyle(

//             //                       color: Colors.black,
//             //                       fontSize: 20,
//             //                       fontWeight: FontWeight.normal,
//             //                     ))
//             //                     ),
//             //                                      borderSide: BorderSide(color:Colors.black),
//             //                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

//             //                                      ),

//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AdminAuthPage(),
//                     ));
//               },
//               child: Text("If you are the Admin , Press here ",
//                   style: GoogleFonts.cinzel(
//                       textStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 9.5,
//                     fontWeight: FontWeight.normal,
//                   ))),
//             ),
//             SizedBox(height: 5),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _loginform() async {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return SpinKitChasingDots(color: Colors.black);
//         });
//     User firebaseUser;
//     await _auth
//         .signInWithEmailAndPassword(
//             email: emailtexteditingcontroller.text,
//             password: passwordtexteditingcontroller.text)
//         .then((authUser) {
//       print("hypo");
//       Fluttertoast.showToast(
//         msg: 'Logged In  hee Successfully',
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,

//         timeInSecForIos: 5,
//         backgroundColor: Colors.black,
//         textColor: Colors.white,
//         // webPosition: "center"
//       );
//       firebaseUser = authUser.user;
//       print(firebaseUser.uid);
//     }).catchError((error) {
//       Navigator.pop(context);
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorAlertDialog(
//               message: error.message.toString(),
//             );
//           });
//     });
//     if (firebaseUser != null) {
//       readData(firebaseUser).then((s) {
//         Navigator.pop(context);
//         Route route = MaterialPageRoute(builder: (context) => SplashScreen());
//         Navigator.pushReplacement(context, route);
//       });
//     }
//   }

//   readData(User fUser) async {
//     EcommerceApp.firestore = FirebaseFirestore.instance;
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(fUser.uid)
//         .get()
//         .then((dataSnapshot) async {
//           EcommerceApp.firestore.collection("users").doc(fUser.uid)
//           .collection("CartItems").get().then((value) => value.docs.
//           forEach((element) async {

//            await EcommerceApp.sharedPreferences.setString(element.data()["title"],element.data()["Quantity"].toString());
//             print(element.data()["title"]);
            
//             print(element.data());}));
//       await EcommerceApp.sharedPreferences
//           .setString("uid", dataSnapshot.data()[EcommerceApp.userUID]);
//       await EcommerceApp.sharedPreferences.setString(
//           EcommerceApp.userEmail, dataSnapshot.data()[EcommerceApp.userEmail]);
//       await EcommerceApp.sharedPreferences.setString(
//           EcommerceApp.userName, dataSnapshot.data()[EcommerceApp.userName]);
//       await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl,
//           dataSnapshot.data()[EcommerceApp.userAvatarUrl]);
//       List<String> cartList =
//           dataSnapshot.data()[EcommerceApp.userCartList].cast<String>();
//       await EcommerceApp.sharedPreferences.setStringList("userCart", cartList);
//     });
//   }
// }

	
	
	
