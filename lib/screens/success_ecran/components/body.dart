import 'package:flutter/material.dart';

import '../../../../../components/default_button.dart';
import '../../../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/2.png",
          height: SizeConfig.screenHeight * 0.5, //50%
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
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Retour à l'accueil",
            press: () {
              // Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
