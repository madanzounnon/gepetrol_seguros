import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/screens/sign_in/sign_in_screen.dart';
import 'package:gepetrol_eguros/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Bienvenida che\n GEPetrol Seguros",
      "content":
          "Gepetrol Seguros, S.A. es la primera empresa de seguros de derecho Nacional en Guinea Ecuatorial, con Autorizaciones Nacionales e Internacionales.​",
      "image": "assets/images/bienvenu.png"
    },
    {
      "text": "GEPetrol Seguros",
      "content": "TU SEGURO DE CONFIANZA HOY, MAÑANA Y SIEMPRE",
      "image": "assets/images/2.png"
    },
    {
      "text": "Seguro Médico",
      "content": "Una vida sin Seguro Médico, es una vida sin tranquilidad  ",
      "image": "assets/images/3.png"
    },
    {
      "text": "Seguros de Automóvil",
      "content": "¿Quieres Asegurar tu vehículo sin tener que desplazarte?",
      "image": "assets/images/4.png"
    },
    {
      "text": "SEGURO MULTIRIESGO HOGAR",
      "content":
          """Cuyas garantias son: Responsabilidad civil, Accidentes ocurridos en el centro y extraescolares, Accidentes en el trayecto entre la casa y el colegio, Gastos medicos""",
      "image": "assets/images/5.png"
    },
    {
      "text": "SEGURO MULTIRIESGO HOGAR",
      "content":
          "Este seguro cubre la reparación de los daños que sufra su inmueble (vivienda) a consecuencia de:Incendio,Robo, Filtración de agua, Responsabilidad civil",
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
