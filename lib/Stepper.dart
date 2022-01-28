import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_and_mrs/Address.dart';
import 'package:mr_and_mrs/CartPage.dart';
import 'package:mr_and_mrs/Orders.dart';
import 'package:mr_and_mrs/controllers/cart_controller.dart';
import 'package:mr_and_mrs/paymentpage.dart';
import 'package:provider/src/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

import 'Helper.dart';

class StepperCart extends StatefulWidget {
  @override
  _StepperCartState createState() => _StepperCartState();
}

class _StepperCartState extends State<StepperCart> {
  var currentStep = 0;
  int totalAmount = 0;
  int quanity = 1;
  int cartno = 0;
  int addressid;
  final razorpay = Razorpay();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("address")
        .snapshots();
    // TODO: implement initState

    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("address")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        addressid = querySnapshot.docs.length;
      });
    });
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
      });
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          MRANDMRS.sharedprefs
              .setInt(element.data()['id'], element.data()['quanity']);
          totalAmount =
              totalAmount + element.data()["price"] * element.data()['quanity'];
        });
      });
    });
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
      });
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("cart")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          MRANDMRS.sharedprefs
              .setInt(element.data()['id'], element.data()['quanity']);
          // totalAmount =
          //     totalAmount + element.data()["price"] * element.data()['quanity'];
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
                  .doc(response.paymentId.toString())
                  .set({
                "id": response.paymentId.toString(),
                "status": "order Placed",
                "address": id,
                "payment": "PAID"
              });
              FirebaseFirestore.instance
                  .collection("orders")
                  .doc(MRANDMRS.sharedprefs.getString("uid"))
                  .collection("items")
                  .doc(response.paymentId.toString())
                  .collection("items")
                  .doc(element.data()['id'])
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
      // "addressid": id,
      // "amount": totalAmount,
//"orderBy":EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      //  "orderBy": MRANDMRS.sharedprefs.getString("uid"),
// EcommerceApp.productID:EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      //"method": "Cash On Delievery",
      "time": DateTime.now().millisecondsSinceEpoch.toString(),
      // "paid": true,
    }).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => Orders())));
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
      "amount": totalAmount.toDouble() * 100,
      "name": "Ramesh M S",
      "prefill": {"contact": "", "email": ""}
    };
    try {
      razorpay.open(option);
    } catch (e) {
      print("ERROR IS " + e.toString());
    }
  }

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

  int addressvalueno() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(MRANDMRS.sharedprefs.getString("uid"))
        .collection("address")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        addressid = querySnapshot.docs.length;
      });
    });
    return addressid;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    List<Step> steps = [
      Step(
          title: Text("cart"),
          content: cart(),
          state: StepState.indexed,
          isActive: true),
      Step(
          title: Text("Address"),
          content: Address(),
          state: StepState.indexed,
          isActive: true),
      Step(
          title: Text("Place Order"),
          content: PaymentPage(
            addressId: id,
            totalAmount: totalAmount.toDouble(),
            key: null,
          ),
          state: StepState.indexed,
          isActive: true)
    ];
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(Icons.arrow_back_ios_sharp,
      //           color: kBackgroundColor, size: 12)),
      //   leadingWidth: 25,
      //   title: Text(
      //     "Place Order",
      //     style: GoogleFonts.josefinSans(
      //       textStyle: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           color: kBackgroundColor,
      //           fontSize: 20,
      //           letterSpacing: 0),
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(
                    primary: Colors.brown[900].withOpacity(0.4)),
                accentColor: Colors.grey,
                primaryColor: Colors.grey[600],
                buttonColor: Colors.brown),
            child: Stepper(
              currentStep: this.currentStep,
              steps: steps,
              type: StepperType.horizontal,
              onStepContinue: () {
                print(currentStep);
                if (currentStep == 0) {
                  if (cartno == 0) {
                    context.read<CartController>().cartvaluefinder();
                    Toast.show("Add Items to Place Order", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  } else {
                    setState(() {
                      print(totalAmount);
                      currentStep = currentStep + 1;
                    });
                  }
                } else if (currentStep == 1) {
                  if (id == "") {
                    Toast.show("Select Address", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  } else {
                    setState(() {
                      currentStep = currentStep + 1;
                    });
                  }
                  print("Hi Hlo");
                  print("addresser" + id);
                } else if (currentStep == 2) {
                  getPayment();
                }
                // print(currentStep);

                // setState(() {
                //   if (currentStep < steps.length - 1) {
                //     if (currentStep == 0) {
                //       if (cartno == 0) {
                //         Toast.show("Add Items to Place Order", context,
                //             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                //         currentStep = currentStep;
                //       } else {
                //         currentStep = currentStep + 1;
                //       }
                //     } else if (currentStep == 1) {
                //       if (addressid == 0) {
                //         Toast.show("Add Address", context,
                //             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                //             setState(() {
                //               //  currentStep = currentStep - 2;
                //             });

                //       } else {
                //         currentStep = currentStep + 1;
                //       }
                //     }
                //   } else {
                //     currentStep = 0;
                //   }
                // });
              },
              onStepCancel: () {
                print(currentStep);
                setState(() {
                  if (currentStep == 0) {
                    Navigator.pop(context);
                  } else if (currentStep > 0) {
                    currentStep = currentStep - 1;
                  } else {
                    currentStep = 0;
                  }
                });
              },
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
