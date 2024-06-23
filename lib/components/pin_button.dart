import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class PinButton extends StatelessWidget {
  const PinButton({
    Key? key,
    this.text,
    this.press,
    this.textStyle,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getProportionateScreenWidth(10)),
      height: getProportionateScreenHeight(70),
      width: getProportionateScreenHeight(70),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: CircleBorder(
                side: BorderSide(
                    color: const Color.fromARGB(31, 75, 75, 75),
                    width: 1,
                    style: BorderStyle.solid)),
            //primary: Colors.white,
            foregroundColor: pPrimaryColor.withOpacity(0.5)),
        onPressed: press as void Function()?,
        child: Text(text!, style: textStyle),
      ),
    );
  }
}
