import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gepetrol_eguros/components/secondary_button.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  launchURL() async {
    final Uri url = Uri.parse(
        'https://www.africabourse-am.net/index.php?option=com_content&view=article&id=2&catid=2/&Itemid=311&lang=fr#who');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: getProportionateScreenWidth(240),
        width: double.infinity,
        //margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(15),
        ),
        decoration: BoxDecoration(
          color: pPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          // borderRadius: BorderRadius.circular(20),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(70),
                vertical: getProportionateScreenHeight(15)),
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenHeight(50),
            ),
          )),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "¿Quiénes somos?\n",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(13)),
                      text:
                          "GEPetrol Seguros, S.A. es la primera empresa de seguros de derecho nacional en Guinea Ecuatorial. Disponemos de la licencia CIMA obtenida en diciembre del 2018 y nuestra sede se encuentra en Malabo."),
                ],
              ),
            ),
          ),
          // SecondaryButton(
          //   text: "Lire la suite",
          //   backcolor: Color.fromRGBO(208, 248, 238, 1),
          //   textcolor: Colors.black,
          //   press: () {
          //     launchURL();
          //   },
          // ),
          /*GestureDetector(
            onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
            child: Text(
              "Souscrire",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: kPrimaryColor),
            ),
          ),*/
        ]));
  }
}
