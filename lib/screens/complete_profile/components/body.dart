import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/size_config.dart';

import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                // Text("PASSER UN ORDRE", style: headingStyle),
                const Text(
                  "Renseignez vos informations",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
                const Text(
                    "En continuant, confirmez que vous acceptez \n nos termes et conditions",
                    textAlign: TextAlign.center,
                    style: TextStyle(decoration: TextDecoration.underline)
                    // Theme.of(context).textTheme.caption,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
