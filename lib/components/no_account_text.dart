import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/screens/sign_up/components/Souscrire.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas de compte ? ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Souscrire.routeName),
          //Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Ouvrez un compte",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(17),
                color: pPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
