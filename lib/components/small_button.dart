import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(45),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          //primary: Colors.white,
          backgroundColor: pPrimaryColor,
        ),
        onPressed: press as void Function()?,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app),
              const SizedBox(width: 8),
              Text(text!,
                style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: Colors.white,
                ),
              ),
            ]
          ),
      )
    );
  }
}
