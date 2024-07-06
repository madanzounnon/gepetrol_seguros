import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gepetrol_eguros/helper/utile.dart';
import 'package:gepetrol_eguros/screens/facture/facture_screens.dart';
import 'package:gepetrol_eguros/screens/information_personnelle/information_personnelle.dart';
import 'package:gepetrol_eguros/screens/plainte/plainte.dart';
import 'package:gepetrol_eguros/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../helper/store.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../aam/apropos_aam/apropos_screen.dart';
import '../../aam/contact/contact_screen.dart';
import '../../splash_screen.dart';
import 'profile_menu.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  // StoreAuth storeAuth = StoreAuth();
  // String? nom;
  // String? email;
  // String? telephone;

  // Future<void> getUser() async {
  //   final SharedPreferences sharedPreferences = await _sharedPreferences;
  //   setState(() {
  //     telephone = sharedPreferences.getStringList("abonne")?[1];
  //     nom = sharedPreferences.getStringList("abonne")?[0];
  //     email = sharedPreferences.getStringList("abonne")?[1];
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getUser();
  // }

  User? user;
  File? photoprofile;

  getUser() async {
    User users = await StoreAuth().getUser();
    print(users);
    setState(() {
      user = users;
    });
  }

  void submitphoto(Map<String, String> parameter) {
    Utile.loarder(context);
    Utile.multipart(
        {}, 'https://webapp.africabourse-am.net/api/add-profile-pic',
        isTokenApi: true,
        imgObj: {
          "photo": photoprofile!,
        }, withSuccess: (responseObj) async {
      Navigator.of(context).pop();
      if (responseObj["success"] == true) {
        Response? ress = await ApiService().getUser();
        if (ress != null) {
          StoreAuth().saveUser(ress.data["user"]);
          setState(() {});
          // Navigator.pushNamed(context, "/information");
          Utile.messageSuccess(context, responseObj["message"]);
        }
      } else {
        Utile.messageErro(context, '${responseObj["message"]}');
      }
    }, failure: (err) async {
      Utile.messageErro(context, 'ooooooop!!!!');
    });
  }

  @override
  void initState() {
    super.initState();
    photoprofile = null;
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          /*Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                children: [
                  const ProfilePic(),
                  SizedBox(width: getProportionateScreenWidth(20)),
                  Expanded(
                      child: Column(children: [
                    Text("$nom",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                        )),
                    // Text("$email",
                    //     maxLines: 1,
                    //     style: TextStyle(
                    //         fontSize: getProportionateScreenWidth(15),
                    //         fontWeight: FontWeight.bold)),
                    Text("$telephone",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                        ))
                  ]))
                ],
              )),*/
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
                            image: AssetImage("assets/images/Profile.png"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(120),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              fit: StackFit.expand,
                              clipBehavior: Clip.none,
                              children: [
                                if (user != null)
                                  if (user!.profile_picture != null)
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "https://webapp.africabourse-am.net/backend/photos/${user!.profile_picture}",
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )),
                                if (photoprofile != null)
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        photoprofile!,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )),
                                if (photoprofile == null)
                                  if (user!.profile_picture == null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Icon(
                                        FontAwesomeIcons.userCircle,
                                        size: 100,
                                        color: kTextColor,
                                      ),
                                    ),
                                if (photoprofile == null)
                                  if (user!.profile_picture == null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Icon(
                                        FontAwesomeIcons.userCircle,
                                        size: 100,
                                        color: kTextColor,
                                      ),
                                    ),
                                Positioned(
                                  right: 12,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 40,
                                    width: 90,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        //primary: Colors.white,
                                        backgroundColor: const Color.fromRGBO(
                                            204, 221, 245, 1),
                                      ),
                                      onPressed: () {
                                        setState(() async {
                                          photoprofile = await Utile.getImage();
                                          if (photoprofile != null) {
                                            submitphoto({});
                                          }
                                        });
                                        setState(() {});
                                      },
                                      child: const Text(
                                        'Modifier',
                                        style: TextStyle(color: pPrimaryColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(10),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${user!.first_name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionateScreenWidth(17),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${user!.last_name}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionateScreenWidth(17),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${user!.email}",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          )
                        ],
                      ))
                ])),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileMenu(
            text: "Mi perfil",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(
                  context, InformationPersonnelleScreen.routeName)
            },
          ),
          ProfileMenu(
            text: "Mis facturas",
            icon: "assets/icons/Error.svg",
            press: () {
              Navigator.pushNamed(context, FactureScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Siniestros",
            icon: "assets/icons/Conversation.svg",
            press: () {
              Navigator.pushNamed(context, PlainteScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Acerca de gepetrol Seguros",
            icon: "assets/icons/Flash Icon.svg",
            press: () {
              Navigator.pushNamed(context, AproposScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Contacto",
            icon: "assets/icons/Call.svg",
            press: () {
              Navigator.pushNamed(context, ContactsScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Desconectar",
            icon: "assets/icons/Log out.svg",
            press: () {
              StoreAuth().logout();
              Navigator.pushReplacementNamed(context, SplashScreen1.routeName);
            },
          ),
        ],
      ),
    );
  }
}
