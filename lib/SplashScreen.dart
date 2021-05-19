import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/HomScreen.dart';
import 'package:mr_and_mrs/MainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mr_and_mrs/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _networkStatus1 = '';

  Connectivity connectivity = Connectivity();

  void checkConnectivity1() async {
    var connectivityResult = await connectivity.checkConnectivity();
    var conn = getConnectionValue(connectivityResult);
    setState(() {
      _networkStatus1 = 'Check Connection:: ' + conn;
      print(_networkStatus1);
    });
  }

  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'Wi-Fi';
        break;
      case ConnectivityResult.none:
        status = 'None';
        break;
      default:
        status = 'None';
        break;
    }
    return status;
  }

  @override
  void initState() {
    checkConnectivity1();
    Timer(
        Duration(seconds: 3),
        () => MRANDMRS.sharedprefs.getString("uid") == null
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => MainScreen()))
            : Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => HomeScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light
 ));
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? smallscreen()
            : largescreen();
      },
    );
  }

  Widget smallscreen() {
    return Scaffold(
          body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    'Mr & Mrs',
                    style: GoogleFonts.josefinSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBackgroundColor,
                          fontSize: 27,
                          letterSpacing: 1),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'DESIGN WOOD WORKS',
                    style: GoogleFonts.josefinSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                          fontSize: 14,
                          letterSpacing: 1),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 1,
                    color: kPrimaryColor,
                    width: 80,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: SpinKitDoubleBounce(
                  color: kBackgroundColor,
                  size: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget largescreen() {
    return Container(
      color: kBackgroundColor,
      child: Center(
        child: SpinKitDoubleBounce(
          color: kCaptionColor,
          size: 70.0,
        ),
      ),
    );
  }
}
