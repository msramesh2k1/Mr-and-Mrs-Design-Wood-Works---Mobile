
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AdminAuthPage extends StatefulWidget {
  
  @override
  _AdminAuthPageState createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> 
{
   
  
 bool _passwordVisible = true;
  final TextEditingController adminidtexteditingcontroller  =  new TextEditingController();
 final TextEditingController passwordtexteditingcontroller  =  new TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
@override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
  
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
     //  key: _formkey, 
         body: Container(
           color:Colors.white,
    //  decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                       begin: Alignment.bottomLeft,
    //                       end: Alignment.topRight,
    //                       colors: [Colors.grey, Colors.white])),    
 
    padding: EdgeInsets.all(13.0),
     child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
         Container(
          padding: EdgeInsets.only(top:40),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //  ShopInTitle(),
            //  ShopInSubTitle(),
            ],
          ),
          ),
          SizedBox(height:30),
              
              
                            Form(
                              key: _formkey,
                                                          child: Expanded(  
                child: SingleChildScrollView(
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //   borderRadius:BorderRadius.circular(20),
                                      //   color:Colors.grey.withOpacity(0.1),
                                      // ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(              
                      "ADMIN LOGIN",
                      style: GoogleFonts.cinzel(
                        textStyle: TextStyle(
                        
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ))
                      ),
                      SizedBox(height:25),
   Container(
                              padding: EdgeInsets.only(left:20.0),
                               decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(20),
                                        color:Colors.grey.withOpacity(0.2),
                                      ),
                              
                              child: TextField(
                                style: TextStyle(color:Colors.black),
                                controller: adminidtexteditingcontroller,
                                keyboardType: TextInputType.emailAddress,
                                                           decoration: InputDecoration(
                                                             
                                 
                                  border: InputBorder.none,
                                                               labelText: "Email ",
                                  labelStyle: TextStyle(color: Colors.black54),
                                 
                                ),
                              ),
                          ),
                          SizedBox(height:20),
                          Container(
                              padding: EdgeInsets.only(left:20.0),
                             decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(20),
                                        color:Colors.grey.withOpacity(0.2),
                                      ),
                              child: TextField(
                                
                                obscureText: !_passwordVisible,
                                style: TextStyle(color:Colors.black),
                                controller: passwordtexteditingcontroller,
                                                          decoration: InputDecoration(
                                  suffixIcon: IconButton(
            icon: Icon(
               _passwordVisible
               ? Icons.visibility
               : Icons.visibility_off,
               color: Colors.black54
               ),
            onPressed: () {
               
               setState(() {
                   _passwordVisible = !_passwordVisible;
               });
             },
            ),
                                                                 border: InputBorder.none,
                                                          labelText: "Password ",
                                  labelStyle:                             
                                  
                                  TextStyle(color: Colors.black54),
                                 
                                ),
                              ),
                          ),


                  // FlatButton(
                  //   onPressed: (){
                  //      }),
//           if (!_open) {
//             _controller = _formkey.currentState.showBottomSheet(
//               (_) =>               
//                Container(
//                  height: 150,
//                             padding: EdgeInsets.all(20.0),
//                             decoration: BoxDecoration(
//                                color: Color(0xececec),
//                               border: Border(
//                               top: BorderSide(
//                                   width: 1,
//                               color:Colors.lightblue38,
//                                 ),
//                               ),
//                             ),
//                             child: Column(
//                               children: [
//                                 TextField(
//                                   style: TextStyle(color:Colors.black),
//                                   controller: resetemailtexteditingcontroller,
//                                   keyboardType: TextInputType.emailAddress,
//                                                              decoration: InputDecoration(
                                                                 
                                    
//                                     border: InputBorder.none,
//                                                                  labelText: "Email : ",
//                                     labelStyle: TextStyle(color: Colors.lightblue54),
                                     
//                                   ),
//                                 ),
//                                  OutlineButton(
                                 
//                   highlightedBorderColor: Colors.black,
//                   padding: EdgeInsets.symmetric(horizontal:26,vertical:10),
//                   onPressed: ()async
//                 { 
//                   resetemailtexteditingcontroller.text.isNotEmpty ?
                  
//     _auth.sendPasswordResetEmail(email: resetemailtexteditingcontroller.text.toString())
//     .then((value) => Navigator.pop(context)).then((value) => 

// Fluttertoast.showToast(msg: 'Reset Email has been sent',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIos: 5,
//           backgroundColor: Colors.lightblue54,
//           textColor: Colors.black,
          
         
//       ))
//     :
//    Fluttertoast.showToast(msg: 'Enter email to proceed',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIos: 5,
//           backgroundColor: Colors.lightblue54,
//           textColor: Colors.black,
        
//       );
    

//                  },
//              child: Text(
//                    "Proceed",
//                    style: GoogleFonts.juliusSansOne(
//                      textStyle: TextStyle(                    
//                      color:Colors.black,
//                      fontSize: 18,
//                      fontWeight: FontWeight.normal,
//                    ))
//                    ),
//                                     borderSide: BorderSide(color:Colors.black),
//                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),                                    
//                                     ),
                                                
//                               ],
//                             ),
//                           ),
   
              
//             );
//           } else {
//             _controller.close();
//           }
//           setState(() => _open = !_open);
                                       
        
//                     },
//                                     child: Center(
//                       child: Text(
                        
//                         "Forget Password ?",
//                         style: GoogleFonts.juliusSansOne(
//                           textStyle: TextStyle(
                          
                          
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontWeight: FontWeight.normal,
//                         ))
//                         ),
//                       ),
//                   ),
                 
                 
                  
                     ],
                    ),

                  ),
                )
              ),
                            ),
                           
                            
              FlatButton(
                    color: Colors.black,
                     padding: EdgeInsets.symmetric(horizontal:84,vertical: 5),
                    
                   onPressed: () async {

                    adminidtexteditingcontroller.text.isNotEmpty
                     && passwordtexteditingcontroller.text.isNotEmpty
                     ?
                     _adminform()

                     : showDialog(context: context,
                     builder : (c){
                       return 
                       Container();
                       //ErrorAlertDialog(message : "Write Email and Password");
                     });
//                      
                                     },
                                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.cinzel(
                                        textStyle: TextStyle(
                                        
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ))
                                      ),
                                                    //   borderSide: BorderSide(color:Colors.black),
                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                       
                                                       ),
              
          
                  
          
                  // OutlineButton(
                  //   highlightedBorderColor: Colors.black,
                  //    padding: EdgeInsets.symmetric(horizontal:73),
                    
                  //  onPressed: () async {
                  
                  //                    },
                  //                                   child: Text(
                  //                     "Login",
                  //                     style: GoogleFonts.cinzel(
                  //                       textStyle: TextStyle(
                                        
                  //                       color: Colors.black,
                  //                       fontSize: 20,
                  //                       fontWeight: FontWeight.normal,
                  //                     ))
                  //                     ),
                  //                                      borderSide: BorderSide(color:Colors.black),
                  //                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                       
                  //                                      ),
                                            
                                      
                                      
                                      
                                    
                                         SizedBox(height:5),
                                            
                                        
                                      
                                   
                                 ],
                               ),
                             ),
                             );
                         
                       }
                     
                     
  _adminform() {
                       
                     FirebaseFirestore.instance.collection("admins").get().then((snapshot) {
                       snapshot.docs.forEach((result) {
                        if(result.data()["id"] != adminidtexteditingcontroller.text.trim())
                         {
                           Scaffold.of(context).showSnackBar(SnackBar(content: Text("Your Id is Incorrect")));
                         }
                         if(result.data()["password"] != passwordtexteditingcontroller.text.trim())
                        {
                           Scaffold.of(context).showSnackBar(SnackBar(content: Text("Your Password is Incorrect")));
                         }
                        else{
                          
// // 
//  Route route = MaterialPageRoute(builder: (c) => 
//  UploadPage());
//  Navigator.pushReplacement(context, route);
                        
      //                     Fluttertoast.showToast
      //                     (
      //                       msg: 'Welcome ! Admin',
      //      toastLength: Toast.LENGTH_LONG,
      //      gravity: ToastGravity.BOTTOM,
      //      timeInSecForIos: 5,
      //      backgroundColor: Colors.black54,
      //      textColor: Colors.white,
      
         
      //  );
                          
                           Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome to Admin Panel" + result.data()["name"])));
 setState(() {
   adminidtexteditingcontroller.text = "";
   passwordtexteditingcontroller.text = "";
 });



                         }
                       });
                     }    );                 }
 
 
 
}
	
	
	
