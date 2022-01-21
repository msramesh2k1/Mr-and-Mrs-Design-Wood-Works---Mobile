import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tab;
  final Widget desktop;
  const ResponsiveWidget(
      {Key key,
      @required this.mobile,
      @required this.tab,
      @required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1100) {
        return desktop;
      } else if (constraints.maxWidth >= 650) {
        return tab;
      } else {
        return mobile;
      }
    });
  }
}
