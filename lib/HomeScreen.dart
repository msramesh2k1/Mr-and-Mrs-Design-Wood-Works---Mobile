import 'package:flutter/material.dart';
import 'package:mr_and_mrs/Widgets/Responsive_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: desktop(),
      tab: tablet(),
      mobile: mobile(),
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
      color: Colors.white,
    );
  }
}
