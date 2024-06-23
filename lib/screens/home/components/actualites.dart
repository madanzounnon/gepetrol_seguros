import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class Actualites extends StatelessWidget {
  const Actualites({
    Key? key,
  }) : super(key: key);

  _launchURL(String path) async {
    //https://www.africabourse-am.net/fr/publications.html
    final Uri url = Uri.parse(path);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Nos Actualités",
            press: () {
              _launchURL(
                  "https://www.africabourse-am.net/fr/publications.html");
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ActualitesCard(
                image: "assets/images/actu1.jpeg",
                title: "HAUSSE DES MARCHES",
                smlldesc:
                    'Composante delta-gamma VAR : décomposition non linéaire du risque pour tout type de fonds.',
                press: () {
                  _launchURL(
                      "https://www.africabourse-am.net/index.php?option=com_content&view=article&id=110&catid=25&lang=fr&Itemid=188");
                },
              ),
              ActualitesCard(
                image: "assets/images/actu2.jpeg",
                title: "HAUSSE DES MARCHES",
                smlldesc: "Chiffres clés 2020 de la gestion d'actifs",
                press: () {
                  _launchURL(
                      "https://www.africabourse-am.net/index.php?option=com_content&view=article&id=101&catid=25&lang=fr&Itemid=188");
                },
              ),
              ActualitesCard(
                image: "assets/images/actu3.jpeg",
                title: "HAUSSE DES MARCHES",
                smlldesc:
                    "Gestion d'actifs : les supports d'investissement solidaire se diversifient",
                press: () {
                  _launchURL(
                      "https://www.africabourse-am.net/index.php?option=com_content&view=article&id=104&catid=25&lang=fr&Itemid=188");
                },
              ),
              ActualitesCard(
                image: "assets/images/actu4.jpeg",
                title: "HAUSSE DES MARCHES",
                smlldesc: "Investissement quantitatif dans des portefeuilles",
                press: () {
                  _launchURL(
                      "https://www.africabourse-am.net/index.php?option=com_content&view=article&id=111&catid=25&lang=fr&Itemid=188");
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class ActualitesCard extends StatelessWidget {
  const ActualitesCard({
    Key? key,
    required this.title,
    required this.image,
    required this.smlldesc,
    required this.press,
  }) : super(key: key);

  final String title, image;
  final String smlldesc;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
          onTap: press,
          child: SizedBox(
            width: getProportionateScreenWidth(308),
            height: getProportionateScreenHeight(390),
            child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 50,
                // margin: EdgeInsets.all(5),
                shadowColor: Colors.black,
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(180),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                      height: getProportionateScreenHeight(180),
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //SizedBox
                          // Text(
                          //   title,
                          //   style: TextStyle(
                          //     fontSize: getProportionateScreenWidth(20),
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.bold,
                          //   ), //Textstyle
                          // ), //Text
                          // SizedBox(
                          //   height: getProportionateScreenHeight(8),
                          // ), //SizedBox
                          Text(
                            smlldesc,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: kSecondaryColor,
                            ), //Textstyle
                          ), //Text
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          /* SmallButton(text: "Lire la suite",
                          press: () => {}
                        ),*/ //SizedBox
                          DefaultButton(text: 'Lire la suite', press: press)
                        ]),
                  ),
                ])),
          )),
    );
  }
}
