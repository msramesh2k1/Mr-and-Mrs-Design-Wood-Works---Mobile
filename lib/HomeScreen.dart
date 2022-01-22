import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_and_mrs/Widgets/Custom_Widgets.dart';
import 'package:mr_and_mrs/Widgets/Responsive_widget.dart';
import 'package:video_player/video_player.dart';

import 'categorypage.dart';
import 'constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController videoPlayerController;
  ScrollController _scrollController;
  double pixels = 0;
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
    return Container();
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
            TopNavi(),
            Box(height: 20, width: 0),
            VideoBox(
                context: context, videoPlayerController: videoPlayerController),
            Box(height: 40, width: 0),
            Poster(context: context),
            Box(height: 40, width: 0),
            CategoryPoster(pixels: pixels, context: context),
            Box(height: 40, width: 0),
            CustomizedPoster(context: context),
            Box(height: 40, width: 0)
          ],
        ),
      ),
      color: Colors.white,
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedAlign(
          duration: Duration(seconds: 1),
          alignment: pixels > 25 ? Alignment(0, 0) : Alignment(3, 0),
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
                                  horizontal: 10, vertical: 50),
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
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white)),
                                        child: Center(
                                          child: Text(
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
                                        ),
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
                    image: AssetImage("assets/videos/poster2.png"),
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
              style: GoogleFonts.montserrat(
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

class TopNavi extends StatelessWidget {
  const TopNavi({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.search_sharp),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.account_circle_outlined),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.shopping_cart_outlined),
        SizedBox(
          width: 20,
        )
      ],
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
