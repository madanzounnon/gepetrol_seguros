import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
    this.content
  }) : super(key: key);
  final String? text, image, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(25),
            color: pPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SvgPicture.asset(
          'assets/icons/souligne.svg',
          width: getProportionateScreenWidth(100),
        ),
        // Text(
        //   'Asset Management'.toUpperCase(),
        //   textAlign: TextAlign.center,
        // ),
        Spacer(flex: 2),
         Image.asset(
          image!,
          height: getProportionateScreenHeight(230),
          width: getProportionateScreenWidth(235),
        ),
       /* SvgPicture.asset(
          image!,
          height: getProportionateScreenHeight(230),
          width: getProportionateScreenWidth(235),
        ),*/
        Spacer(flex: 2),
         Text(
          content!,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
