import 'package:contact_center/src/common/local/expectation_args.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/screens/call_screen/call_screen.dart';
import 'package:contact_center/src/screens/expectation/expectation_screen.dart';
import 'package:contact_center/src/screens/review/review_screen.dart';
import 'package:flutter/material.dart';

class MetaRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutingConst.review:
        return MaterialPageRoute(
          builder: (context) => const ReviewScreen(),
          settings: routeSettings,
        );
      case RoutingConst.call:
        return MaterialPageRoute(
          builder: (context) => const CallScreen(
              ),
          settings: routeSettings,
        );
      case RoutingConst.expectation:
        ExpectationArgs args = routeSettings.arguments as ExpectationArgs;
        return MaterialPageRoute(
          builder: (context) => ExpectationScreen(
            managerData: args.managerData,
            idRoom: args.idRoom,
            creatorConnection: args.creatorConnection,
            pageViewController: args.pageViewController,
            remoteRTCVideoRenderer: args.remoteVideo,
            localRTCVideoRenderer: args.localVideo,
            remoteRTCVideoRendererScreen: args.remoteVideoScreen,
          ),
          settings: routeSettings,
        );
    }
    return null;
  }
}
