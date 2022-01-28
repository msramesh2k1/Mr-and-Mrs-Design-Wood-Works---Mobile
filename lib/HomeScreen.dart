import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/Stepper.dart';
import 'package:mr_and_mrs/Widgets/Custom_Widgets.dart';
import 'package:mr_and_mrs/Widgets/Responsive_widget.dart';
import 'package:mr_and_mrs/categorypage.dart';
import 'package:mr_and_mrs/services/database.dart';
import 'package:mr_and_mrs/userScreen.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_player/video_player.dart';
import 'constants.dart';
import 'controllers/login_controller.dart';
import 'models/category_model.dart';
import 'models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController videoPlayerController;
  String registeremail = '';
  String password = '';
  String loginemail = '';
  String loginpassword = '';
  String name = '';
  ScrollController _scrollController;
  PageController pageController = PageController();
  double pixels = 0;

  bool via = true;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        pixels = _scrollController.position.pixels;
        print("Rames" + pixels.toString());
      });
    });
    videoPlayerController = VideoPlayerController.asset("assets/videos/bg1.mp4")
      ..initialize().then((_) {
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        videoPlayerController.setVolume(0);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        desktop: desktop(),
        tab: tablet(),
        mobile: mobile(),
      ),
    );
  }

  Widget desktop() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Logo(),
              // TopNavi(),
              Box(height: 20, width: 0),
              VideoBox(
                  context: context,
                  videoPlayerController: videoPlayerController),
              Box(height: 40, width: 0),
              Poster(context: context),
              Box(height: 40, width: 0),
              CategoryPoster(pixels: pixels, context: context),
              Box(height: 40, width: 0),
              CustomizedPoster(context: context),
              // Box(height: 40, width: 0),
              // NewArrival(),
              // Box(height: 40, width: 0),
              // ItemPoster(pixels: pixels, context: context),
              // Box(height: 40, width: 0),
              // CustomizedPoster2(context: context),
              // Box(height: 40, width: 0),
              // Customers(),
              // Box(height: 40, width: 0),
              // CustomizedPoster3(context: context),
              // Box(height: 20, width: 0),
              // Row(
              //   children: [
              //     Box(height: 0, width: 20),
              //     Image.network(
              //       "https://cdn-icons-png.flaticon.com/128/1384/1384063.png",
              //       height: 25,
              //     ),
              //     Box(height: 0, width: 20),
              //     Image.network(
              //       "https://cdn-icons-png.flaticon.com/128/733/733547.png",
              //       height: 25,
              //     ),
              //   ],
              // ),
              // Box(height: 30, width: 0),
              // OfficeLocation(),
              // Box(height: 30, width: 0),
            ],
          ),
        ),
      ),
      color: Colors.white,
    );
  }

  Widget tablet() {
    return Container();
  }

  Widget mobile() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Logo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.search_sharp),
                SizedBox(
                  width: 20,
                ),
                Consumer<LoginController>(builder: (context, value, __) {
                  return GestureDetector(
                      onTap: () {
                        // value.signIn(
                        //     email: "msrameshnavee@gmail.com",
                        //     password: "123456789");
                        if (MRANDMRS.sharedprefs.getString("uid") == null) {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                            builder: (context) {
                              return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20),
                                        child: PageView(
                                            controller: pageController,
                                            children: [
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SmallLogo(),
                                                    Box(height: 10, width: 0),
                                                    Text(
                                                      "Create an Account",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            letterSpacing: 0),
                                                      ),
                                                    ),
                                                    TextField(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          name = val;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "Full Name"),
                                                    ),
                                                    TextField(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          setState(() {
                                                            registeremail = val;
                                                          });
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "Email"),
                                                    ),
                                                    TextField(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          password = val;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "Password"),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                LoginController>()
                                                            .signUp(
                                                                email:
                                                                    registeremail,
                                                                password:
                                                                    password)
                                                            .whenComplete(() =>
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (_) =>
                                                                                UserScreen())));
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        child: Center(
                                                          child: Text(
                                                            "Register",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .openSans(
                                                              textStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                          ),
                                                        ),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Box(height: 10, width: 0),
                                                    Column(children: [
                                                      Text(
                                                        "By signing up you are agreeing to our",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              letterSpacing: 0),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Terms and Conditions",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              letterSpacing: 0),
                                                        ),
                                                      ),
                                                      Box(height: 10, width: 0),
                                                      GestureDetector(
                                                        onTap: () {
                                                          pageController
                                                              .jumpToPage(1);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Have an Account ?",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                textStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0),
                                                              ),
                                                            ),
                                                            Text(
                                                              " Login",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                textStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                            .blue[
                                                                        700],
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ])
                                                  ]),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SmallLogo(),
                                                    Box(height: 10, width: 0),
                                                    Text(
                                                      "Sign In",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            letterSpacing: 0),
                                                      ),
                                                    ),
                                                    TextField(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          loginemail = value;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "Email"),
                                                    ),
                                                    TextField(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          loginpassword = value;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "Password"),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                LoginController>()
                                                            .signIn(
                                                                email:
                                                                    loginemail,
                                                                password:
                                                                    loginpassword)
                                                            .whenComplete(() =>
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (_) =>
                                                                                UserScreen())));
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        child: Center(
                                                          child: Text(
                                                            "Login",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .openSans(
                                                              textStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                          ),
                                                        ),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Box(height: 10, width: 0),
                                                    Column(children: [
                                                      Box(height: 10, width: 0),
                                                      GestureDetector(
                                                        onTap: () {
                                                          pageController
                                                              .jumpToPage(0);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Don't have an Account",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                textStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0),
                                                              ),
                                                            ),
                                                            Text(
                                                              "Register",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                textStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                            .blue[
                                                                        700],
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ])
                                                  ]),
                                            ]),
                                      )));
                            },
                          );
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => UserScreen()));
                        }
                      },
                      child: Icon(Icons.account_circle_outlined));
                }),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StepperCart()));
                    },
                    child: Icon(Icons.shopping_cart_outlined)),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            Box(height: 20, width: 0),
            VideoBox(
                context: context, videoPlayerController: videoPlayerController),
            Box(height: 40, width: 0),
            Poster(context: context),
            Box(height: 40, width: 0),
            CategoryPoster(pixels: pixels, context: context),
            CategoryPoster(pixels: pixels, context: context),
            Box(height: 40, width: 0),
            CustomizedPoster(context: context),
            Box(height: 40, width: 0),
            NewArrival(),
            Box(height: 40, width: 0),
            ItemPoster(pixels: pixels, context: context),
            Box(height: 40, width: 0),
            CustomizedPoster2(context: context),
            Box(height: 40, width: 0),
            Customers(),
            Box(height: 40, width: 0),
            CustomizedPoster3(context: context),
            Box(height: 20, width: 0),
            Row(
              children: [
                Box(height: 0, width: 20),
                Image.network(
                  "https://cdn-icons-png.flaticon.com/128/1384/1384063.png",
                  height: 25,
                ),
                Box(height: 0, width: 20),
                Image.network(
                  "https://cdn-icons-png.flaticon.com/128/733/733547.png",
                  height: 25,
                ),
              ],
            ),
            Box(height: 30, width: 0),
            OfficeLocation(),
            Box(height: 30, width: 0),
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}

class OfficeLocation extends StatelessWidget {
  const OfficeLocation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Box(height: 0, width: 20),
            Text(
              "Office Location",
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 20,
                    letterSpacing: 0.5),
              ),
            ),
          ],
        ),
        Box(height: 20, width: 0),
        Row(
          children: [
            Box(height: 0, width: 20),
            Text(
              "4/2/6 A RSPR Nagar 3rd Street,\nKTC Nagar (west) \nThoothukudi - 628002 ",
              style: GoogleFonts.josefinSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16,
                    letterSpacing: 0.5),
              ),
            ),
          ],
        ),
        Box(height: 5, width: 0),
        Row(
          children: [
            Box(height: 0, width: 20),
            Row(
              children: [
                Text(
                  "Phones : ",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: 0.5),
                  ),
                ),
                Text(
                  "7540032123",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
        Box(height: 5, width: 0),
        Row(
          children: [
            Box(height: 0, width: 20),
            Row(
              children: [
                Text(
                  "Email : ",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: 0.5),
                  ),
                ),
                Text(
                  "mrandmrsdesignwoodworks@gmail.com",
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class NewArrival extends StatelessWidget {
  const NewArrival({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Box(height: 0, width: 20),
        Text(
          "New Arrivals",
          textAlign: TextAlign.center,
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 24,
                letterSpacing: 0.5),
          ),
        ),
        Box(height: 0, width: 20),
        Expanded(
          child: Container(
            height: 5,
            width: 20,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class Customers extends StatelessWidget {
  const Customers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Box(height: 0, width: 20),
        Text(
          "Customers",
          textAlign: TextAlign.center,
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 24,
                letterSpacing: 0.5),
          ),
        ),
        Box(height: 0, width: 20),
        Expanded(
          child: Container(
            height: 5,
            width: 20,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class CategoryPoster extends StatelessWidget {
  const CategoryPoster({
    Key key,
    @required this.pixels,
    @required this.context,
  }) : super(key: key);

  final double pixels;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList =
        Provider.of<List<CategoryModel>>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedAlign(
          duration: Duration(seconds: 1),
          alignment: pixels > 25 ? Alignment(0, 0) : Alignment(3, 0),
          child: Container(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 50),
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(categoryList[index].url),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.brown.withOpacity(0.3),
                                    BlendMode.srcATop))),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: Text(
                                    categoryList[index].title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          fontSize: 24,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            height: 300,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/videos/poster2.png"),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.white, width: 1)),
          ),
        ),
      ],
    );
  }
}

class CategoryPoster2 extends StatelessWidget {
  const CategoryPoster2({
    Key key,
    @required this.pixels,
    @required this.context,
  }) : super(key: key);

  final double pixels;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryList =
        Provider.of<List<CategoryModel>>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedAlign(
          duration: Duration(seconds: 1),
          alignment: pixels > 25 ? Alignment(0, 0) : Alignment(3, 0),
          child: Container(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 50),
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(categoryList[index].url),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.brown.withOpacity(0.3),
                                    BlendMode.srcATop))),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: Text(
                                    categoryList[index].title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          fontSize: 24,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            height: 300,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/videos/poster2.png"),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.white, width: 1)),
          ),
        ),
      ],
    );
  }
}

class ItemPoster extends StatelessWidget {
  const ItemPoster({
    Key key,
    @required this.pixels,
    @required this.context,
  }) : super(key: key);

  final double pixels;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedAlign(
          duration: Duration(seconds: 1),
          alignment: pixels > 255 ? Alignment(0, 0) : Alignment(3, 0),
          child: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("category")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Lottie.network(
                            "https://assets1.lottiefiles.com/packages/lf20_vIuhQq.json"));
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Container(
                                height: 100,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data.docs[index]['url']),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.brown.withOpacity(0.3),
                                            BlendMode.srcATop))),
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            snapshot.data.docs[index]['name'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                          Box(height: 20, width: 0),
                                          Container(
                                            height: 40,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: Center(
                                              child: Text(
                                                "View",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Box(height: 20, width: 0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
            height: 300,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/videos/poster5.png"),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.white, width: 1)),
          ),
        ),
      ],
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CategoryPage()));
        },
        child: Container(
          height: 200,
          child: Center(
            child: Container(
              child: Center(
                child: Text(
                  "EXPLORE   BY   ROOMS",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                        letterSpacing: 0),
                  ),
                ),
              ),
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/videos/poster1.jpg",
                  ),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black12, BlendMode.darken)),
              border: Border.all(color: Colors.transparent)),
          width: MediaQuery.of(context).size.width - 40,
        ),
      ),
    );
  }
}

class CustomizedPoster3 extends StatelessWidget {
  const CustomizedPoster3({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Box(height: 40, width: 0),
                  Text(
                    "Contact \nUs",
                    style: GoogleFonts.josefinSans(
                      height: 1.2,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 25,
                          letterSpacing: 2),
                    ),
                  ),
                  Box(height: 10, width: 0),
                  Text(
                    "for product related enquiry ....",
                    style: GoogleFonts.josefinSans(
                      height: 1,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 0.5),
                    ),
                  ),
                  Box(height: 30, width: 0),
                  Container(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              hintText: 'Name',
                              border: InputBorder.none)),
                    )),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                  Box(height: 20, width: 0),
                  Container(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none)),
                    )),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                  Box(height: 20, width: 0),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Query',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                ],
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/videos/poster7.png",
                ),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black12, BlendMode.darken)),
            border: Border.all(color: Colors.transparent)),
        width: MediaQuery.of(context).size.width - 40,
      ),
    );
  }
}

class CustomizedPoster extends StatelessWidget {
  const CustomizedPoster({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Center(
              child: Container(
                child: Center(
                  child: Text(
                    "ORDER \nCUSTOMIZED \nFURNITURES",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      height: 1.5,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2),
                    ),
                  ),
                ),
                height: 130,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2)),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/videos/poster4.png",
                ),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black12, BlendMode.darken)),
            border: Border.all(color: Colors.transparent)),
        width: MediaQuery.of(context).size.width - 40,
      ),
    );
  }
}

class CustomizedPoster2 extends StatelessWidget {
  const CustomizedPoster2({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Center(
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "COMPLETE FURNITURE \nSOLUTIONS",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          height: 1.5,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 17,
                              letterSpacing: 1),
                        ),
                      ),
                      Container(
                        height: 35,
                        child: Center(
                          child: Text(
                            "View All",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.josefinSans(
                              height: 1.5,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 17,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                        width: 100,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                height: 150,
                width: MediaQuery.of(context).size.width - 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/videos/poster6.png",
              ),
              fit: BoxFit.cover,
            ),
            // colorFilter: ColorFilter.mode(
            //     Colors.bla, BlendMode.darken)),
            border: Border.all(color: Colors.transparent)),
        width: MediaQuery.of(context).size.width - 40,
      ),
    );
  }
}

class VideoBox extends StatelessWidget {
  const VideoBox({
    Key key,
    @required this.context,
    @required this.videoPlayerController,
  }) : super(key: key);

  final BuildContext context;
  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width - 40,
            child: videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 130,
            child: Text(
              "Reimagine your place \nwith Modern Furnitures",
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 19,
                    letterSpacing: 1),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            child: Container(
              child: Center(
                child: Text(
                  "EXPLORE",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 1),
                  ),
                ),
              ),
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2)),
            ),
          )
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Mr & Mrs",
            style: GoogleFonts.novaSlim(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBackgroundColor,
                  fontSize: 25,
                  letterSpacing: 0),
            ),
          ),
          Text(
            "Design Wood Works",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 11,
                  letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallLogo extends StatelessWidget {
  const SmallLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Mr & Mrs",
            style: GoogleFonts.novaSlim(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBackgroundColor,
                  fontSize: 20,
                  letterSpacing: 0),
            ),
          ),
          Text(
            "Design Wood Works",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 8,
                  letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }
}
