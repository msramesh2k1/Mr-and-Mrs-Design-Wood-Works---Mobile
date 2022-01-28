import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_and_mrs/DetailedScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/constants.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchcontroller = new TextEditingController();
  String name = '';
  List _category = ["chair", "bed", "sofa"];
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
    title: Text(
      "Explore Items",
      style: GoogleFonts.josefinSans(
        textStyle: TextStyle(
            fontWeight: FontWeight.w800,
            color: kBackgroundColor,
            fontSize: 16,
            letterSpacing:0),
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
        ),         
   
        backgroundColor: Colors.white,
        body: Container(
    child: Column(
      children: [
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(7)),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
                // cursorColor: Colors.red[900],
                controller: searchcontroller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,

                  // border: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.black,width:5)),
                  hintText: "SEARCH HERE ...",
                  hintStyle:
                      TextStyle(color: Colors.grey, letterSpacing: 1),
                ),
              ),
            ),
          ),
        ),
       
        Expanded(
          child: Container(
            // child: ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     itemCount: resultlist.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => DetailScreen(
            //                         queryDocumentSnapshot:
            //                             resultlist[index],
            //                       )));
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.all(5.0),
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: Colors.black,
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //             child: Row(
            //               children: [
            //                 SizedBox(
            //                   width: 20,
            //                 ),
            //                 //  Container(
            //                 //         height: 120,
            //                 //         width: 120,
            //                 //         decoration: BoxDecoration(
            //                 //             image: DecorationImage(
            //                 //                 image: NetworkImage(
            //                 //                   resultlist[index].data()['image']
            //                 //                  ),
            //                 //                 fit: BoxFit.fill),
            //                 //             color: Colors.grey.shade300,
            //                 //             borderRadius:
            //                 //                 BorderRadius.circular(20)),
            //                 //       ),

            //                 Text(
            //                   resultlist[index].data()['name'],
            //                   style: GoogleFonts.lato(
            //                     textStyle: TextStyle(
            //                         fontWeight: FontWeight.normal,
            //                         color: Colors.white,
            //                         fontSize: 14,
            //                         letterSpacing: 2),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             height: 80,
            //           ),
            //         ),
            //       );
            //     }),

            child: StreamBuilder<QuerySnapshot>(
              stream: (name != "" && name != null)
                  ? FirebaseFirestore.instance
                      .collection("SearchProducts")
                      .where('index', arrayContains: name)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("SearchProducts")
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading"));
                } else {
                  return GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: snapshot.data.docs
                        .map((DocumentSnapshot documentSnapshot) {
                      return Container(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            // queryDocumentSnapshot:
                                            //     documentSnapshot,
                                          )));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 130,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(documentSnapshot.data()["mainimage"])),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    ),
                                    SizedBox(height: 2,),
                                    Center(
                                  child: Text(
                                    documentSnapshot
                                        .data()['name']
                                        ,
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBackgroundColor,
                                          fontSize: 14,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),

            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
        ),
      );
  }
}
