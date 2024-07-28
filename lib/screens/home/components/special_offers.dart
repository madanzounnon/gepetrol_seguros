import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helper/store.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../size_config.dart';

import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  ApiService apiService = ApiService();
  final bool _isLoading = true;
  User? user;

  getUser() async {
    User users = await StoreAuth().getUser();
    print(users);
    setState(() {
      user = users;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAlloffres();
    getUser();
  }

  launchURL() async {
    final Uri url = Uri.parse(
        'https://gepetrol-seguros.com/servicios/seguros-particulares/');
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
            title: "Nuestros servicios",
            press: () {
              launchURL();
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            SpecialOfferCard(
              image: "assets/images/o1.jpg",
              category: "Seguro Médico",
              numOfBrands:
                  "Este seguro cubre a los asegurados en caso de enfermedad. La aseguradora pagará al asegurado los siguientes gastos",
              //press: () {},
            ),
            SpecialOfferCard(
              image: "assets/images/o2.jpg",
              category: "Seguros de Automóvil",
              numOfBrands:
                  "Cubre los daños causados a terceros (daños materiales y corporales) y los que sufra el vehículo asegurado...",
              //press: () {},
            ),
            SpecialOfferCard(
              image: "assets/images/o4.jpg",
              category: "SEGURO MULTIRIESGO HOGAR",
              numOfBrands:
                  "Cuyas garantias son: Responsabilidad civil, Accidentes ocurridos en el centro y extraescolares, Accidentes en el trayecto entre la casa y el colegio, Gastos medicos",
              // press: () {},
            ),
            SpecialOfferCard(
              image: "assets/images/o3.jpg",
              category: "SEGURO DE ACCIDENTES",
              numOfBrands:
                  "Este seguro cubre los accidentes sufridos por el asegurado, bien sea en el ámbito privado como en el profesional.",
              // press: () {},
            )
          ]),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
  }) : super(key: key);

  final String category, image;
  final String numOfBrands;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          width: getProportionateScreenWidth(308),
          height: getProportionateScreenWidth(180),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  width: getProportionateScreenWidth(308),
                  height: getProportionateScreenWidth(180),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(308),
                  height: getProportionateScreenWidth(180),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(308),
                          height: getProportionateScreenWidth(180),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 117, 90, 0.80),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenWidth(10),
                            ),
                            child: Text.rich(
                              TextSpan(
                                style: const TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: "$category\n",
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "$numOfBrands\n".toLowerCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getProportionateScreenWidth(15))),
                                  // TextSpan(
                                  //   text: "Souscrire",
                                  //   style: TextStyle(
                                  //       decoration: TextDecoration.underline,
                                  //       fontWeight: FontWeight.w900,
                                  //       fontSize:
                                  //           getProportionateScreenWidth(18),
                                  //       color: Colors.white),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
