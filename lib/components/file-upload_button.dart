import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../size_config.dart';

class FileUploadButton extends StatelessWidget {
  const FileUploadButton({
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
      height: getProportionateScreenHeight(65),
      child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            //primary: Colors.white,
            backgroundColor: kSecondaryColor,
          ),
          onPressed: press as void Function()?,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.upload,
                    size: 20,
                  ),
                  SizedBox(width: getProportionateScreenWidth(18)),
                  Expanded(
                      child: Text(
                    text!,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: Colors.white,
                    ),
                  )),
                ],
              ))),
    );
  }
}
