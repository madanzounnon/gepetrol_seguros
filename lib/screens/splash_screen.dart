import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/screens/entry_point.dart';
import 'package:gepetrol_eguros/screens/splash/splash_screen.dart';
import 'package:gepetrol_eguros/size_config.dart';

class SplashScreen1 extends StatefulWidget {
  SplashScreen1({Key? key, this.title}) : super(key: key);

  static String routeName = "/splash1";

  final String? title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen1> {
  _SplashScreenState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        print(token);
        (token != null)
            ? Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => EntryPoint(currentPage: 0)),
                (route) => false)
            : Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  String? token;

  bool _isVisible = false;
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    token = await sharedPreferences.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor,
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1500),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                //SizedBox(height:5),
                const Icon(
                  Icons.stars,
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(height: 5),
                const Text("Tu Seguro de confianza Hoy,\n Mañana y Siempre",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    )) //put your logo here
              ],
            )),
          ),
        ),
      ),
    );
  }
}
