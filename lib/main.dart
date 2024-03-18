import 'package:contact_center/l10n/all_locales.dart';
import 'package:contact_center/l10n/local_provider.dart';
import 'package:contact_center/src/common/blocks/cubit/auth_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/call_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/connect_cubit.dart';
import 'package:contact_center/src/common/blocks/cubit/cubit/update_id_cubit.dart';
import 'package:contact_center/src/common/dependencies/bramf_hive.dart';
import 'package:contact_center/src/common/dependencies/injection_container.dart';

import 'package:contact_center/src/common/router/router.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:contact_center/src/screens/call_screen/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

void main() async {
  await initHive();
  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

String route = RoutingConst.call;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleProvider>(
        create: (_) => LocaleProvider(),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UpdateIdCubit(service: getIt()),
              ),
              BlocProvider(
                create: (context) => AuthCubit(  service: getIt(),),
              ),
              BlocProvider(
                create: (context) => CallCubit(service: getIt()),
              ),
              BlocProvider(
                create: (context) => ConnectCubit(service: getIt()),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.yellow,
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Provider.of<LocaleProvider>(context).locale,
              supportedLocales: AllLocales.all,
              home: const CallScreen(),
              onGenerateRoute: MetaRouter.onGenerateRoute,
            ),
          );
        });
  }
}