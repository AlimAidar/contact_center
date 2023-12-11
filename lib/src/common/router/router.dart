import 'package:contact_center/src/common/blocks/bloc/login_bloc.dart';
import 'package:contact_center/src/common/blocks/cubit/call_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/connect_cubit.dart';
import 'package:contact_center/src/common/dependencies/injection_container.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/screens/call_screen/call_screen.dart';
import 'package:contact_center/src/screens/expectation/expectation_screen.dart';
import 'package:contact_center/src/screens/review/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginBloc(authService: getIt()),
              ),
              BlocProvider(
                create: (context) => CallCubit(service: getIt()),
              ),
              BlocProvider(
                create: (context) => ConnectCubit(service: getIt()),
              ),
            ],
            child: const CallScreen(),
          ),
          settings: routeSettings,
        );
      case RoutingConst.expectation:
        return MaterialPageRoute(
          builder: (context) => const ExpectationScreen(),
          settings: routeSettings,
        );
    }
    return null;
  }
}
