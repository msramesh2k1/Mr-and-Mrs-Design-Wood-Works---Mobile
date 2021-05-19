// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'Item.dart';
// import 'OrderDetailspage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// int counter = 0;
// class OrderCard extends StatelessWidget
//  {
//   final int itemCount;
//   final List<DocumentSnapshot>data;
//   final String orderID;

//   const OrderCard({Key key, this.itemCount, this.data, this.orderID}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Route route;
//         if(
//           counter == 0){
//         counter = counter+1;
//         route = MaterialPageRoute(builder: (c) => OrderDetails(orderID:orderID));

//         }
//         Navigator.push(context, route);
//       },
//       //color: Colors.amber,
      
//       child:Container(
//         color: Colors.black,
//               child: Container(
//            decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(15),
//                          color: Colors.white70
//                        ),
//           // decoration: new BoxDecoration(
//           //   gradient: LinearGradient(colors: 
//           //   [Colors.red,Colors.amber],
//           //   begin: FractionalOffset(0, 0),
//           //   end: FractionalOffset(0, 0),
//           //   stops: [0.0,1.0],
//           //   tileMode: TileMode.clamp)
//           // ),
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.all(10),
//           height: itemCount *  190.0,

//            child: ListView.builder(itemCount:itemCount,
//             physics:NeverScrollableScrollPhysics(),
//            itemBuilder:(c,index){
//              ItemModel model = ItemModel.fromJson(data[index].data());
//              return sourceOrderInfo(model,context);
//            }),
//         ),
//       )
//     );
//   }
// }
// Widget sourceOrderInfo(ItemModel model,BuildContext context,{
//   Color background
// }){
//   //width = MediaQuery.of(context).size.width;
//   return Padding(
    
//     padding: const EdgeInsets.all(1.0),
//     child: Container(
//      // padding: EdgeInsets.all(),
//       decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(15),
//                          color: Colors.white70
//                        ),
//                        //color: Colors.white70,
//                        height:160,                 
//                     child:
//                     Row
//                     (
//                       children: [
//                         SizedBox(width:8),
//            Container(
//     width: 100.00,
//     height: 100.00,
//     decoration: new BoxDecoration(
//       borderRadius: BorderRadius.circular(8),
//     image: new DecorationImage(    
//         image: NetworkImage(model.thumbnailUrl),
//         fit: BoxFit.fitHeight,
//         ),
//     )),
//                       SizedBox(
//                         width: 10.0,
//                       ),
//                       Expanded(child: 
//                       Column(
//                         crossAxisAlignment : CrossAxisAlignment.start,                      
//                         children: [
//                           SizedBox(
//                             height:7.0
//                           ),
//                           Container(
//                          //   color: Colors.amber,
//                             child:Row(mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Expanded(child: 
//                               Text(
//                       model.title,
//                       style: GoogleFonts.josefinSans(
//                         textStyle: TextStyle(
                        
//                         color: Colors.black,
//                         fontSize: 26.5,
//                         fontWeight: FontWeight.bold,
//                       ))
//                       ),),

// ],
//                             )
//                           ),
//                           SizedBox(height:2.5,),
//                           Container(
//                             child:Row(
//                               mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Container(
                              
//                                 decoration: BoxDecoration
//                                 (
//                                   borderRadius: BorderRadius.circular(4),
//                                   color: Colors.white60
//                                 ),
//                                 height: 38,
//                                 width: 250,
//                                 child: 
//                                                                                Padding(
//                                                                                  padding: const EdgeInsets.all(3.0),
//                                                                                  child: SingleChildScrollView(
//                                                                                     child: Text(
//                       model.shortInfo,
//                       style: GoogleFonts.josefinSans(
//                         textStyle: TextStyle(
                        
//                         color: Colors.black54,
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       ))
//                       ),
//                                                                                   ),
//                                                                                ),
                       
                                
//                               ),
//                       //         Expanded
//                       //         (child: 
//                       //         Text(
//                       // model.shortInfo,
//                       // style: GoogleFonts.josefinSans(
//                       //   textStyle: TextStyle(
                        
//                       //   color: Colors.black54,
//                       //   fontSize: 20,
//                       //   fontWeight: FontWeight.normal,
//                       // ))
//                       // ),),

// ],
//                             )
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Row(
//                             children:[
//                               // Container(
//                               //   decoration:BoxDecoration(
//                               //     borderRadius: BorderRadius.circular(5),
//                               //    // border: BorderRadius.circular(20),
//                               //    // shape:BoxShape.rectangle,
//                               //     color:Colors.white60,

//                               //   ),
//                               //   alignment: Alignment.topLeft,
//                               //   width: 40.0,
//                               //   height:30.0,
//                               //   // child: Center(child: 
//                               //   // Column(
//                               //   //   mainAxisAlignment: MainAxisAlignment.center,
//                               //   //   children: [
//                               //   //     Text(
//                               //   //       "50%",style: TextStyle(
//                               //   //         color:Colors.black,fontWeight: FontWeight.bold

//                               //   //       ),),
                                      
//                               //   //   ],
//                               //   // ),),
//                               // ),
//                               SizedBox(
//                                 width:10.0
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                   padding:EdgeInsets.only(top:0),
//                                   child: Row(
//                                     children:[
//                                       Text(
//                       "Total Price : ",
//                       style: GoogleFonts.josefinSans(
//                         textStyle: TextStyle(
                        
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ))
//                       ),
//                                        Text("₹ "+  model.price.toString(),
//                       style: GoogleFonts.josefinSans(
//                         textStyle: TextStyle(
                        
//                         color: Colors.black,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ))
//                       ),
//                                     ]
//                                   ),
//                                 ),
                                 
//                            ],)
//                             ]
//                           ),
//                            Flexible(
//                             child: 
//                           Container()
//                           ),
                         
//                         ],

//                       ))
//                     ],)

//                      ),
//   );

 
// }