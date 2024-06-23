import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/components/default_button.dart';
import 'package:gepetrol_eguros/screens/entry_point.dart';
import 'package:gepetrol_eguros/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Connexion réussie",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Retour à l\'acceuil",
            press: () {
              Navigator.pushNamed(context, EntryPoint.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
