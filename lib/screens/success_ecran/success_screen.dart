// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/components/secondary_button.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/screens/entry_point.dart';
import 'package:gepetrol_eguros/size_config.dart';

class SuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  String message;
  String? title;
  String redirectTo;
  String btnText;
  SuccessScreen({
    Key? key,
    required this.message,
    this.title = "Succès",
    required this.redirectTo,
    required this.btnText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: SizedBox(),
        //   title: const Text("Connexion réussie"),
        // ),
        backgroundColor: pPrimaryColor,
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Image.asset(
                "assets/images/3.png",
                height: SizeConfig.screenHeight * 0.30, //50%
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                title!,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(40),
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              SecondaryButton(
                width: 100,
                textcolor: const Color.fromARGB(255, 0, 0, 0),
                backcolor: Color.fromRGBO(208, 248, 238, 1),
                text: btnText,
                press: () {
                  //Navigator.pushReplacementNamed(context, redirectTo);
                  Navigator.pushReplacementNamed(context, redirectTo);
                },
              ),
            ],
          ),
        )));
  }
}
