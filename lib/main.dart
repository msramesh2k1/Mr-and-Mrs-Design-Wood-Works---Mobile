import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mr_and_mrs/cartvalue.dart';
import 'package:mr_and_mrs/models/category_model.dart';
import 'package:mr_and_mrs/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SplashScreen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'controllers/login_controller.dart';
import 'models/product_model.dart';
import 'models/user_model.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  MRANDMRS.sharedprefs = await SharedPreferences.getInstance();
  MRANDMRS.firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider.value(value: cartvalue()),
        StreamProvider<UserModel>.value(
          value: LoginController().user,
          initialData: null,
        ),
        StreamProvider<List<CategoryModel>>.value(
          value: DBService().getCategoryList(),
          initialData: null,
        ),
        StreamProvider<List<ProductModel>>.value(
          value: DBService().getProductList(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        theme: Theme.of(context).copyWith(
            textTheme: GoogleFonts.openSansTextTheme(),
            highlightColor: Colors.red,
            primaryColor: Colors.black,
            accentColor: Colors.black,
            buttonColor: Colors.grey
            // appBarTheme: Theme.of(context)
            //     .appBarTheme
            //     .copyWith(brightness: Brightness.dark)
            ),
        debugShowCheckedModeBanner: false,
        title: 'MR AND MRS',
        home: SplashScreen(),
      ),
    );
  }
}
