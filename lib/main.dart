import 'package:contact_center/l10n/all_locales.dart';
import 'package:contact_center/l10n/local_provider.dart';
import 'package:contact_center/src/common/dependencies/bramf_hive.dart';
import 'package:contact_center/src/common/dependencies/injection_container.dart';
import 'package:contact_center/src/common/router/router.dart';
import 'package:contact_center/src/common/router/routing_constant.dart';
import 'package:flutter/material.dart';
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
          return MaterialApp(
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
            initialRoute: route,
            onGenerateRoute: MetaRouter.onGenerateRoute,
          );
        });
  }
}
