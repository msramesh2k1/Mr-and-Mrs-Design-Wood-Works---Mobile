import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/HomScreen.dart';
import 'package:mr_and_mrs/HomeScreen.dart';
import 'package:mr_and_mrs/constants.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DetailedScreen.dart';

class PaymentPage extends StatefulWidget {
  final String addressId;
  final double totalAmount;

  const PaymentPage({Key key, this.addressId, this.totalAmount})
      : super(key: key);

  @override
  _PaymentpageState createState() => _PaymentpageState();
}

class _PaymentpageState extends State<PaymentPage> {
  num totalAmount = 0;
  int quanity = 1;
  int cartno = 0;

  int cartvalueno() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        cartno = querySnapshot.docs.length;
      });
    });
    return cartno;
  }
  


  final razorpay = Razorpay();
  @override
  void initState() {
    print(widget.addressId);
    // TODO: implement initState
    super.initState();
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paySuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, payError);
    FirebaseFirestore.instance
                                .collection("users")
                                .doc(MRANDMRS.sharedprefs.getString("uid"))
                                .collection("cart")
                                .snapshots();
    // TODO: implement initState
    super.initState();
      FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        cartno = querySnapshot.docs.length;
      });});
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        

        setState(() {
          MRANDMRS.sharedprefs.setInt(element.data()['id'], element.data()['quanity']);
          totalAmount = totalAmount + element.data()["price"] * element.data()['quanity'];
        });
      });
    });

  }
  

  void paySuccess(PaymentSuccessResponse response) {
    print("IOiooioiooioioi" + response.paymentId.toString());
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((value) => value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("orders")
                  .doc(MRANDMRS.sharedprefs.getString("uid"))
                  .collection("items")
                  .doc(element.data()["name"])
                  .set({
                "height": element.data()['height'],
                'width': element.data()['width'],
                "depth": element.data()['depth'],
                "weight": element.data()['weight'],
                "warranty": element.data()['warranty'],
                "status": "orderPlaced, Yet to Deliver",

                "category": element.data()['category'],
                "name": element.data()["name"],
                "quanity": element.data()['quanity'],
                "wood": element.data()['wood'],
                "id": element.data()['id'],
                'mainimage': element.data()['mainimage'],
                "Description": element.data()['Description'],
                'price': element.data()['price'],
                'oprice': element.data()['oprice']

// ********************//
              });
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(MRANDMRS.sharedprefs.getString("uid"))
                  .collection("cart")
                  .doc(element.data()['id'])
                  .delete();
            }));
    FirebaseFirestore.instance
        .collection("orders")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .set({
      "addressid": widget.addressId,
      "amount": widget.totalAmount,
//"orderBy":EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      "orderBy": MRANDMRS.sharedprefs.getString("uid"),
// EcommerceApp.productID:EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      "method": "Cash On Delievery",
      "time": DateTime.now().millisecondsSinceEpoch.toString(),
      "paid": true,
    }).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => HomeScreen())));
  }

  void payError(PaymentFailureResponse response) {
    print(response.message + response.code.toString());
  }

  void externalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  getPayment() {
    var option = {
      'wallets': ['paytm'],
      "key": "rzp_test_fLo6QLFO60RWDp",
      "amount": widget.totalAmount.toDouble() * 100,
      "name": "Ramesh M S",
      "prefill": {"contact": "7010862331", "email": "msramesh2k12gmail.com"}
    };
    try {
      razorpay.open(option);
    } catch (e) {
      print("ERROR IS " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Container(
          //     color: Colors.white,
          //     child: Center(
          //         child: RaisedButton(
          //             onPressed: () {
          //               //  addOrderDetails();
          //               getPayment();
          //             },
          //             //addOrderDetails(),
          //             child: Text("Place Order")))),
                       SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        
                        // SizedBox(height: 10),
                        Row(
                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: Text(
                                "Total No of Items : "+cartno.toString() ,
                                  
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 14,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: Text(
                                "Total Amount : " + widget.totalAmount.toString(),
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 14,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left:0.0,right:0,bottom: 0),
                          child: SingleChildScrollView(
                            //physics: NeverScrollableScrollPhysics(),
                                                    child: Container(
                              color: Colors.white,
                              height:MediaQuery.of(context).size.height * 0.4,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(MRANDMRS.sharedprefs.getString("uid"))
                                      .collection("cart")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        'Loading...',
                                      );
                                    } else {
                                      return Scrollbar(
                                       isAlwaysShown: true,
                                       thickness: 10,
                                     
                                        //  controller: _s`crollController,
                                        child: ListView.builder(
                                         // physics: NeverScrollableScrollPhysics(),
                                            // gridDelegate:
                                            //     SliverGridDelegateWithFixedCrossAxisCount(
                                            //         crossAxisCount: 1),
                                            //   controller: _scrollController,
                                            itemCount: snapshot.data.docs.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailScreen(
                                                                  queryDocumentSnapshot:
                                                                      snapshot.data
                                                                              .docs[
                                                                          index],
                                                                )));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(5)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 120,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                      .grey[200],
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(snapshot
                                                                                  .data
                                                                                  .docs[
                                                                              index][
                                                                          'mainimage']),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      top: 12),
                                                              child: Center(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      snapshot
                                                                          .data
                                                                          .docs[index]
                                                                              ['name']
                                                                          .toUpperCase(),
                                                                      style:
                                                                          GoogleFonts
                                                                              .lato(
                                                                        textStyle: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w700,
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                1),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                                  .only(
                                                                              right:
                                                                                  8.0),
                                                                      child: Center(
                                                                        child: Text(
                                                                          "₹ " +
                                                                              snapshot
                                                                                  .data
                                                                                  .docs[index]['price']
                                                                                  .toString(),
                                                                          style:
                                                                              GoogleFonts
                                                                                  .lato(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight
                                                                                    .w700,
                                                                                color: Colors
                                                                                    .black,
                                                                                fontSize:
                                                                                    15,
                                                                                letterSpacing:
                                                                                    1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                                  .only(
                                                                              right:
                                                                                  10.0),
                                                                      child: Text(
                                                                        "₹ " +
                                                                            snapshot
                                                                                .data
                                                                                .docs[
                                                                                    index]
                                                                                    [
                                                                                    "oprice"]
                                                                                .toString(),
                                                                        style:
                                                                            GoogleFonts
                                                                                .lato(
                                                                          textStyle: TextStyle(
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .bold,
                                                                              decoration:
                                                                                  TextDecoration
                                                                                      .lineThrough,
                                                                              color: Colors
                                                                                  .black54,
                                                                              fontSize:
                                                                                  12,
                                                                              letterSpacing:
                                                                                  0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child: Text(
                                                                        snapshot
                                                                            .data
                                                                            .docs[
                                                                                index]
                                                                                [
                                                                                'category']
                                                                            .toUpperCase(),
                                                                        style:
                                                                            GoogleFonts
                                                                                .lato(
                                                                          textStyle: TextStyle(
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .w700,
                                                                              color: Colors
                                                                                  .black54,
                                                                              fontSize:
                                                                                  12,
                                                                              letterSpacing:
                                                                                  1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(),
                                                                      child: Center(
                                                                        child: Text(
                                                                          "PRODUCT NO : " +
                                                                              snapshot
                                                                                  .data
                                                                                  .docs[index]['id']
                                                                                  .toUpperCase(),
                                                                          style:
                                                                              GoogleFonts
                                                                                  .lato(
                                                                            textStyle: TextStyle(
                                                                                fontWeight: FontWeight
                                                                                    .w700,
                                                                                color: Colors
                                                                                    .black54,
                                                                                fontSize:
                                                                                    10,
                                                                                letterSpacing:
                                                                                    1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child: Text(
                                                                        "WOOD : " +
                                                                            snapshot
                                                                                .data
                                                                                .docs[
                                                                                    index]
                                                                                    [
                                                                                    'wood']
                                                                                .toUpperCase(),
                                                                        style:
                                                                            GoogleFonts
                                                                                .lato(
                                                                          textStyle: TextStyle(
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .w700,
                                                                              color: Colors
                                                                                  .black54,
                                                                              fontSize:
                                                                                  12,
                                                                              letterSpacing:
                                                                                  1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              "QUANTITY : ",
                                                                              style: GoogleFonts
                                                                                  .lato(
                                                                                textStyle: TextStyle(
                                                                                    fontWeight: FontWeight.w700,
                                                                                    color: Colors.black54,
                                                                                    fontSize: 12,
                                                                                    letterSpacing: 1),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // IconButton(
                                                                          //     onPressed:
                                                                          //         () {
                                                                          //       setState(
                                                                          //           () {
                                                                          //        MRANDMRS.sharedprefs.setString(snapshot.data.docs[index]['id'], (snapshot.data.docs[index]['id']++).toString());
                                                                          //       });
                                                                          //     },
                                                                          //     icon: Icon(
                                                                          //         Icons.add_circle_outline)),
                                                                          Container(
                                                                              child:
                                                                                  Center(
                                                                                child:
                                                                                    Text(                                                                                
                                                                                snapshot.data.docs[index]['quanity'].toString(),
                                                                                  style:
                                                                                      GoogleFonts.lato(
                                                                                    textStyle: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 14, letterSpacing: 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.grey[
                                                                                      300],
                                                                                  borderRadius: BorderRadius.circular(
                                                                                      2)),
                                                                              height:
                                                                                  30,
                                                                              width:
                                                                                  30),
                                                                          // IconButton(
                                                                          //     onPressed:
                                                                          //         () {
                                                                          //       setState(
                                                                          //           () {
                                                                          //         if (
                                                                          //           snapshot.data.docs[index]['quanity'] >=
                                                                          //             2) {
                                                                          //           snapshot.data.docs[index]['quanity']--;
                                                                          //         }
                                                                          //       });
                                                                          //     },
                                                                          //     icon: Icon(
                                                                          //         Icons.remove_circle_outline)),
                                                                        ],
                                                                      ),
                                                                      height: 60,
                                                                      width: 200,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  5)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                     
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    }
                                  }),
                            ),
                          ),
                            ),
                     
                      ],
                    ),
                  ),
                ),
                
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(MRANDMRS.sharedprefs.getString("uid"))
                  .collection("address")
                  .where("id", isEqualTo: widget.addressId)
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : snapshot.data.docs.length == 0
                        ? SizedBox()
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 1.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(snapshot.data.docs[index]['name'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(
                                            snapshot.data.docs[index]
                                                    ['flatNumber'] +
                                                " " +
                                                snapshot.data.docs[index]
                                                    ['street1'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(
                                            snapshot.data.docs[index]
                                                ['street2'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(
                                            snapshot.data.docs[index]['city'] +
                                                "  -  " +
                                                snapshot.data.docs[index]
                                                    ['pincode'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(snapshot.data.docs[index]['state'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(
                                            snapshot.data.docs[index]
                                                ['country'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Text(
                                            snapshot.data.docs[index]
                                                ['phoneNumber'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.teal[900].withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                          );
              }),
        ],
      ),
    );
  }

  addOrderDetails() {
    writeOrderDetailsForUser({
      "addressid": widget.addressId,
      "amount": widget.totalAmount,
//"orderBy":EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      "orderBy": MRANDMRS.sharedprefs.getString("uid"),
// EcommerceApp.productID:EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      "method": "Cash On Delievery",
      "time": DateTime.now().millisecondsSinceEpoch.toString(),
      "paid": true,
    });

    writeOrderDetailsForAdmin({
//       EcommerceApp.addressID:widget.addressId,
// EcommerceApp.totalAmount:widget.totalAmount,
// "orderBy":EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
// EcommerceApp.productID:EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
// EcommerceApp.paymentDetails:"Cash On Delievery",
// EcommerceApp.orderTime:DateTime.now().millisecondsSinceEpoch.toString(),
// EcommerceApp.isSuccess:true,
    }).whenComplete(() => {emptyCartNow()});
  }

  emptyCartNow() {
    // EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ["garbageValue"]);
    // List tempList = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    // FirebaseFirestore.instance.collection("users")
    // .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
    // .update({
    //   EcommerceApp.userCartList:tempList,
    // }).then((value) => {
    //   EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, tempList),
    //   Provider.of<CartItemCounter>(context,listen:false).notifyListeners()

    // });
    // Fluttertoast.showToast(msg: "order placed");
    // Route route = MaterialPageRoute(builder: (c)=> SplashScreen());
    // Navigator.pushReplacement(context,route);
  }
  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    // await EcommerceApp.firestore.collection(EcommerceApp.collectionUser).doc(EcommerceApp.sharedPreferences.getString(
    //   EcommerceApp.userUID
    // )).collection(EcommerceApp.collectionOrders).doc(EcommerceApp.sharedPreferences.getString(
    //   EcommerceApp.userUID
    // )+data['orderTime']).set(data);
  }
  Future writeOrderDetailsForAdmin(Map<String, dynamic> data) async {
    // await EcommerceApp.firestore.collection(EcommerceApp.collectionOrders).doc(
    //   EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID)+data['orderTime']
    // ).set(data);
  }
}
