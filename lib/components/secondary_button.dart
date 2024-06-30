import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    this.text,
    this.backcolor,
    this.textcolor,
    this.press,
    required this.width,
  }) : super(key: key);
  final String? text;
  final Color? backcolor;
  final Color? textcolor;
  final Function? press;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * width,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          //primary: kPrimaryColor,
          backgroundColor: backcolor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!.toUpperCase(),
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: textcolor,
          ),
        ),
      ),
    );
  }
}
