import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(5)),
      child: TextButton(
        style: TextButton.styleFrom(
          //primary: Colors.black,

          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.black,
              width: getProportionateScreenWidth(22),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Expanded(
                child: Text(
              text,
              style: const TextStyle(color: Colors.black),
            )),
            Icon(Icons.arrow_forward_ios,
                size: getProportionateScreenWidth(20)),
          ],
        ),
      ),
    );
  }
}
