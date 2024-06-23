import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class Souscrirebtn extends StatelessWidget {
  const Souscrirebtn({
    Key? key,
    this.text,
    this.press,
    this.backcolor,
    this.textcolor,
  }) : super(key: key);
  final String? text;
 final Color? backcolor,textcolor;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(140),
      height: getProportionateScreenHeight(45),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          //primary:backcolor,
          backgroundColor: backcolor,
        ),
        onPressed: press as void Function()?,
        child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text!,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color:textcolor,
                  ),
                ),
               // Icon(Icons.arrow_right),
              ],
            ) 
      ),
    );
  }
}
