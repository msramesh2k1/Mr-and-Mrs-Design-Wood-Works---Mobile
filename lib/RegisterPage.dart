// import 'dart:io';
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_com/ShopInWidgets/TextWidget.dart';
// import 'package:e_com/ShopInlogin.dart';
// import 'package:e_com/config.dart';
// import 'package:e_com/errordialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'ShopInHome.dart';

// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationState createState() => _RegistrationState();
// }

// class _RegistrationState extends State<RegistrationScreen> {
//  bool _passwordVisible = true;
// SharedPreferences prefs ;
// final firestoreInstance = FirebaseFirestore.instance;
// final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
// TextEditingController _email = TextEditingController();
//   TextEditingController _pass = TextEditingController();
//   TextEditingController _cpass = TextEditingController();
//   TextEditingController _name = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool isObsecure = true;
//   File _image;

//   String imageurl; 
//  @override
//   void initState() {
//     super.initState();
//     _passwordVisible = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
       
//          body: Container(
//            color:Colors.white,
//           padding: EdgeInsets.all(13.0),
//          child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
                
//      Container(
//        padding: EdgeInsets.only(top:40),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//              ShopInTitle(),
//              ShopInSubTitle()
                  
//           ],
//         ),
//      ),
//       SizedBox(height:50),
//               Text(              
//                       "REGISTER",
//                       style: GoogleFonts.cinzel(
//                         textStyle: TextStyle(
                        
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.normal,
//                       ))
//                       ),
//               SizedBox(height:10),
//               Form(
//                 key: _formKey,
//                               child: Expanded( 
//                   child: Scrollbar(
//                     //radius:10,
//                                       child: SingleChildScrollView(
//                                       child: Container(
//                        padding: EdgeInsets.all(20),
//                         child: 
//                         Column(
//                           children: <Widget>[
 

//      InkWell(
//     onTap: 
//        getImage
//       ,
//             child: CircleAvatar(  
                
//                           radius: 65,
//                           backgroundColor: Colors.white30,  
//                           backgroundImage: _image == null ?
//                             AssetImage("assets/blankdp.png") :
//                              FileImage(_image),  
//                           child: _image == null 
//                           ?  Icon(Icons.add_a_photo,size:45,color:Colors.transparent)
//                           : null,
//                  ),
//      ),
// SizedBox(height:20),
// Container(
//                                 padding: EdgeInsets.only(left:20),
//                                decoration: BoxDecoration(
//                                           borderRadius:BorderRadius.circular(20),
//                                           color:Colors.grey.withOpacity(0.2),
//                                         ),
//                                 child: TextField(
//                                 textCapitalization: TextCapitalization.sentences,
                              
//                                   style: TextStyle(color:Colors.black),
//                                   controller: _name,
//                                   keyboardType: TextInputType.name,
                                  
//                                         decoration: InputDecoration(
//                                                     border: InputBorder.none,
//                                      labelText: "Name",
//                                     labelStyle: TextStyle(color: Colors.black54),
//                                              ),
//                                 ),
//                               ),SizedBox(height:20),
//  Container(
//                              padding: EdgeInsets.only(left:20),
//                                  decoration: BoxDecoration(
//                                           borderRadius:BorderRadius.circular(20),
//                                           color:Colors.grey.withOpacity(0.2),
//                                         ),
//                                 child: TextField(
//                                   style: TextStyle(color:Colors.black),
//                                   controller: _email,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
                                   
//                                     border: InputBorder.none,
                                
//                                     labelText: "Email",
//                                     labelStyle: TextStyle(color: Colors.black54),
//                                                                ),
//                                 ),
//                               ),SizedBox(height:20),
//                               Container(
//                            padding: EdgeInsets.only(left:20),
//                                 decoration: BoxDecoration(
//                                           borderRadius:BorderRadius.circular(20),
//                                           color:Colors.grey.withOpacity(0.2),
//                                         ),
//                                 child: TextField(
//                                   style: TextStyle(color:Colors.black),
//                                   controller: _pass,
//                                   obscureText: !_passwordVisible,
//                                   decoration: InputDecoration(
                                   
//                                     border: InputBorder.none,
                            
//                                     labelText: "Password",
//                                     labelStyle:                             
                                    
//                                     TextStyle(color: Colors.black54),
//                                       suffixIcon: IconButton(
//             icon: Icon(
//                  _passwordVisible
//                  ? Icons.visibility
//                  : Icons.visibility_off,
//                  color: Colors.black54
//                  ),
//             onPressed: () {
                 
//                  setState(() {
//                        _passwordVisible = !_passwordVisible;
//                  });
//              },
//             ),
//                                   ),
                                   
//                                 ),
//                               ),SizedBox(height:20),
//                               Container(
//                                padding: EdgeInsets.only(left:20),
//                                 decoration: BoxDecoration(
//                                           borderRadius:BorderRadius.circular(20),
//                                           color:Colors.grey.withOpacity(0.2),
//                                         ),
//                                 child: TextField(
//                                   style: TextStyle(color:Colors.black),
//                                   controller: _cpass,
//                                    obscureText: !_passwordVisible,
//                                   decoration: InputDecoration(
//                                       suffixIcon: IconButton(
//             icon: Icon(
//                  _passwordVisible
//                  ? Icons.visibility
//                  : Icons.visibility_off,
//                  color: Colors.black54
//                  ),
//             onPressed: () {
                 
//                  setState(() {
//                        _passwordVisible = !_passwordVisible;
//                  });
//              },
//             ),
//                                                                    border: InputBorder.none,
                           
//                                     labelText: "Confirm Password",
//                                     labelStyle:                             
//                                    TextStyle(color: Colors.black54),                             
//                                   ),
//                                 ),
//                               ),
//                         ],
//                         ),

//                       ),
//                     ),
//                   )
//                 ),
//               ),Text(
//                                           "By registering an account,you agree to ShopIN's Terms of Service",
//                                           style: GoogleFonts.cinzel(
//                                          textStyle: TextStyle(
                                         
//                                          color: Colors.black,
//                                          fontSize: 8,
//                                          fontWeight: FontWeight.normal,
//                                           ))
//                                           ),
//                              FlatButton(
//                     color: Colors.black,
//                      padding: EdgeInsets.symmetric(horizontal:80,vertical: 5),
                    
//                    onPressed: () async {
//                     _uploadandsave();
//                                      },
//                                                     child: Text(
//                                       "REGISTER",
//                                       style: GoogleFonts.cinzel(
//                                         textStyle: TextStyle(
                                        
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.normal,
//                                       ))
//                                       ),
//                                                     //   borderSide: BorderSide(color:Colors.black),
//                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                       
//                                                        ),
              
                                          
//                                      SizedBox(
//                                        height:4
//                                      ),
//                                       InkWell(
//                                         onTap: (){
//                                            Navigator.pushReplacement(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) => LogInScreen(),
//                                       ));
//                                         },

//                                                                               child: Text(
//                                           "Already a User ? Login",
//                                           style: GoogleFonts.cinzel(
//                                          textStyle: TextStyle(
                                         
//                                          color: Colors.black,
//                                          fontSize: 12,
//                                          fontWeight: FontWeight.normal,
//                                           ))
//                                           ),
//                                       ),                   ],
//                               ),
//                             ),
//                             );
                        
//                       }
//  Future getImage() async {
//         final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
   
//              setState(() {
//              if (pickedFile != null) {
//                            _image = File(pickedFile.path);
//             } else {
//                  print('No image selected.');
//                 }
//              });
//       }
                    
//   Future <void> _uploadandsave() async {
//                 if(_image == null){
//                showDialog(context: context,
//               builder: (BuildContext context){
//                   return ErrorAlertDialog(message :"Pick an Image");
//                         }
//                         );
//                          }
//                       else
//                       {
//                         _pass.text.trim() == _cpass.text.trim() ?
//                         _email.text.isNotEmpty && 
//                         _pass.text.isNotEmpty &&
//                         _cpass.text.isNotEmpty &&
//                         _name.text.isNotEmpty 

//                         ?
//                         uploadtostorage()
                        
//                         :displayDialog("Fill Completely")

//                         :displayDialog("Password do not Match");

                        
                        
                        


//                       }
//                     }

//                     displayDialog(String msg)
//                     {
//                       showDialog(context: context,
//                         builder: (BuildContext context){
//                           return ErrorAlertDialog(message :msg);
//                         }
//                         );

//                     }

//  uploadtostorage()
//  async{
//    showDialog(context: context,
//    builder: (BuildContext context){
//    return SpinKitChasingDots(color: Colors.black);

//    });
//    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
//    StorageReference storageReference = FirebaseStorage.instance.ref().child(imageFileName);
//    StorageUploadTask storageUploadTask = storageReference.putFile(_image);
//    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
//    await taskSnapshot.ref.getDownloadURL().then((
//      urlImage) {
//      imageurl = urlImage;     
//      print("Image ID = " + imageurl);
//      _registeruser();
//    });
//   } 

// void _registeruser() async
// {
 
//  User firebaseUser;
//    await _auth.createUserWithEmailAndPassword(email: _email.text,password: _pass.text).then((auth){
//      firebaseUser = auth.user;
//    });    
//      print("uid = " + firebaseUser.uid);
//      Fluttertoast.showToast(msg: 'Registered In Successfully',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIos: 3,
//           backgroundColor: Colors.black,
//           textColor: Colors.white,
        
//       );  
//       Fluttertoast.showToast(msg: 'Welcome !',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIos: 3,
//           backgroundColor: Colors.black,
//           textColor: Colors.white,
        
//       );  
//      if(firebaseUser != null)
//      {
//        print("Account Created Successfully");       
//        saveusertofirestore(firebaseUser).then((value) {
//          Navigator.pop(context);
//          Route route = MaterialPageRoute(builder: (context) => HomeScreen());
//          Navigator.pushReplacement(context, route);
//        });

//      }
//     }

//  Future saveusertofirestore(User fUser)async
//      {
//        firestoreInstance.collection("users").doc(fUser.uid).set(
//    {
//   "uid" : fUser.uid,
//   "email" : fUser.email,
//   "name" : _name.text.trim(),
//   "password" : _pass.text.trim(),
//   "url" : imageurl,
//  EcommerceApp.userCartList: ["garbageValue"],
//      });
//     await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
//     await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, fUser.email);
//     await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName, _name.text.trim());
//     await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, imageurl);
//     await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ["garbageValue"]); 
//      print("Shared preferences saved successfully");
//   } 
// }
	
	
	
