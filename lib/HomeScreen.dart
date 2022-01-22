import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/Widgets/Custom_Widgets.dart';
import 'package:mr_and_mrs/Widgets/Responsive_widget.dart';
import 'package:video_player/video_player.dart';

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
    videoPlayerController = VideoPlayerController.asset("assets/videos/bg1.mp4")
      ..initialize().then((_) {
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Logo(),
            TopNavi(),
            Box(height: 20, width: 0),
            VideoBox(
                context: context, videoPlayerController: videoPlayerController),
          ],
        ),
      ),
      color: Colors.white,
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
