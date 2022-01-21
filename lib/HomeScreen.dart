import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_and_mrs/Widgets/Responsive_widget.dart';

import 'constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Logo(), top_navi()],
      ),
      color: Colors.white,
    );
  }
}

class top_navi extends StatelessWidget {
  const top_navi({
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
