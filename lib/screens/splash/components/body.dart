import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/screens/sign_in/sign_in_screen.dart';
import 'package:gepetrol_eguros/screens/sign_in_and_sign_up/sign_in_and_sign_up_ecran.dart';
import 'package:gepetrol_eguros/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Bienvenue chez \n AAM",
      "content":
          "AFRICABOURCE ASSET MANAGEMENT \n Le marché financier avec vous partout, à travers nos FCP​",
      "image": "assets/images/bienvenu.png"
    },
    {
      "text": "C’est quoi un FCP ?\n AAM",
      "content":
          "Un Fonds Commun de placement (FCP) est un ensemble de ressources collectées auprès d’une multitude d’investisseurs et investies collectivement pour leur compte sur le marché par un gestionnaire d’actifs.",
      "image": "assets/images/2.png"
    },
    {
      "text": "Investissez en \n un clic ",
      "content":
          "Les FCP offrent un accès simplifié à la bourse et un suivi professionnel de votre portefeuille. ",
      "image": "assets/images/3.png"
    },
    {
      "text": "Avec moins \n de frais ",
      "content":
          "Les seuls frais prélevés sont ceux de souscription et de rachat, ce qui réduit les frais supportés par l’investisseur.",
      "image": "assets/images/4.png"
    },
    {
      "text": "Un investissement \n multiple ",
      "content":
          "En investissant dans un FCP, vous investissez simultanément dans un panier de titre et bénéficiez de leurs avantages.",
      "image": "assets/images/5.png"
    },
    {
      "text": "Avec une garantie \n  assurée ",
      "content":
          "Les parts des FCP peuvent être mise en garantie auprès d’un établissement financier afin d’obtenir un prêt.",
      "image": "assets/images/6.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                  content: splashData[index]['content'],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 2),
                    DefaultButton(
                      text: "Continuer",
                      press: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                            (route) => false);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 7,
      width: currentPage == index ? 20 : 7,
      decoration: BoxDecoration(
        color: currentPage == index ? pPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
