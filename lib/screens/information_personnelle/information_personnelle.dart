import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/helper/store.dart';
import 'package:gepetrol_eguros/models/user.dart';
import 'package:gepetrol_eguros/screens/information_personnelle/item_element.dart';
import 'package:gepetrol_eguros/size_config.dart';

class InformationPersonnelleScreen extends StatefulWidget {
  @override
  static String routeName = "/information";
  _InformationPersonnelleScreenState createState() =>
      _InformationPersonnelleScreenState();
}

class _InformationPersonnelleScreenState
    extends State<InformationPersonnelleScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  User? user;
  getUser() async {
    User users = await StoreAuth().getUser();
    print(users);
    setState(() {
      user = users;
      print(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: getBody(user!),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }

  Widget getBody(User user) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        child: SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(170),
            child: Stack(children: [
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(170),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    image: const DecorationImage(
                        opacity: 0.02,
                        image: AssetImage("assets/images/Profile Image.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(170),
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("assets/images/decoruser.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(170),
                  decoration: const BoxDecoration(
                      // color: pPrimaryColor,
                      // borderRadius: BorderRadius.circular(10),
                      //image: DecorationImage( image: AssetImage("assets/images/decoruser.png"), fit: BoxFit.cover)
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            if (user != null && user.profile_picture != null)
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    "https://webapp.africabourse-am.net/backend/photos/${user!.profile_picture!}",
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )),
                            if (user != null)
                              if (user.profile_picture == null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Icon(
                                    FontAwesomeIcons.userCircle,
                                    size: 100,
                                    color: kTextColor,
                                  ),
                                ),
                            if (user == null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Icon(
                                  FontAwesomeIcons.userCircle,
                                  size: 100,
                                  color: kTextColor,
                                ),
                              ),
                            /* Positioned(
                                  right: 12,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 40,
                                    width: 90,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          side: BorderSide(color: Colors.white),
                                        ),
                                        primary: Colors.white,
                                        backgroundColor: Color.fromRGBO(204,221,245,1),
                                      ),
                                      onPressed: () {},
                                      child: Text('Modifier',style: TextStyle(color: pPrimaryColor),),
                                    ),
                                  ),
                                )*/
                          ],
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
                      ),
                    ],
                  ))
            ])),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: Text(
          'Mi cuenta',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(18),
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(8),
      ),
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(204, 221, 245, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: getProportionateScreenHeight(20)),
            child: Column(children: [
              ItemElement(
                cle: "Usuario no",
                textcolor: pPrimaryColor,
                valeur: user.username,
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              ItemElement(
                cle: 'Correo electrónico',
                textcolor: pPrimaryColor,
                valeur: user.email,
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              ItemElement(
                cle: 'Num de Tél',
                textcolor: pPrimaryColor,
                valeur: user.phone,
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              // ignore: prefer_const_constructors
              ItemElement(
                cle: 'Contraseña',
                textcolor: pPrimaryColor,
                valeur: '***********',
              ),
            ])),
      ),
      SizedBox(
        height: getProportionateScreenHeight(8),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: Text(
          'Información personal',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(18),
              fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(204, 221, 245, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: getProportionateScreenHeight(20)),
            child: Column(children: [
              ItemElement(
                cle: 'Apellido',
                textcolor: pPrimaryColor,
                valeur: user.first_name,
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              ItemElement(
                cle: 'Nombre',
                textcolor: pPrimaryColor,
                valeur: user.last_name,
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              ItemElement(
                cle: 'Civilidad',
                textcolor: pPrimaryColor,
                valeur: user.sex,
              ),
              SizedBox(
                height: getProportionateScreenHeight(8),
              ),
              ItemElement(
                cle: 'Teléfono"',
                textcolor: pPrimaryColor,
                valeur: user.phone,
              ),
            ])),
      ),
    ]);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Información personal",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 176, 249, 201),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Icon(
                //   FontAwesomeIcons.bell,
                //   color: Color.fromARGB(255, 3, 185, 66),
                //   size: 20,
                // ),
                // SizedBox(width: 2,),
                /* Padding(
                padding: EdgeInsets.only(left: 2,right: 8,top: 2,bottom: 2),
                child:Text("Dépôt",style: TextStyle(color: pPrimaryColor, fontSize: 14,fontWeight: FontWeight.bold),),)*/
              ],
            ),
          ),
        ]));
  }
}
