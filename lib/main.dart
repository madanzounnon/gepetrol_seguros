import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:gepetrol_eguros/routes.dart';
import 'package:gepetrol_eguros/screens/country/provider/country_provider.dart';
//import 'package:gepetrol_eguros/screens/profile/profile_screen.dart';
//import 'package:gepetrol_eguros/screens/splash/splash_screen.dart';
import 'package:gepetrol_eguros/screens/splash_screen.dart';
import 'package:gepetrol_eguros/size_config.dart';
import 'package:gepetrol_eguros/theme.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: pPrimaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: pPrimaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CountryProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: theme(),
          initialRoute: SplashScreen1.routeName,
          routes: routes,
        ),
      );
}
