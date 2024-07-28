import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: pPrimaryColor,
              fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "Ver todo",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}
