import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < ResponsiveConsts.smallScreen;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > ResponsiveConsts.largeScreen;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= ResponsiveConsts.smallScreen &&
        MediaQuery.of(context).size.width <= ResponsiveConsts.largeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > ResponsiveConsts.largeScreen) {
          return largeScreen;
        } else if (constraints.maxWidth <= ResponsiveConsts.largeScreen &&
            constraints.maxWidth >= ResponsiveConsts.smallScreen) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
class ResponsiveConsts {
  static const double smallScreen = 800;
  static const double largeScreen = 1200;
  static const double maxWidthScreen = 1920;
}