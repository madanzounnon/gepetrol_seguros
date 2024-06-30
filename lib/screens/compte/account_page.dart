import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/helper/store.dart';
import 'package:gepetrol_eguros/models/pub.dart';
import 'package:gepetrol_eguros/models/user.dart';
import 'package:gepetrol_eguros/screens/splash_screen.dart';
import 'package:gepetrol_eguros/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/utile.dart';
import '../../services/api_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  static String routeName = "/compte";
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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

  _launchURL() async {
    final Uri url = Uri.parse(
        'https://www.africabourse-am.net/index.php?option=com_content&view=article&id=80&Itemid=178&lang=fr');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    photoprofile = null;
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: (user != null)
          ? ListView(
              children: [
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
                                  image:
                                      AssetImage("assets/images/Profile.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          width: double.infinity,
                          height: getProportionateScreenHeight(120),
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/decoruser.png"),
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
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.file(
                                              photoprofile!,
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            )),
                                      if (photoprofile == null)
                                        if (user!.profile_picture == null)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: const Icon(
                                              FontAwesomeIcons.userCircle,
                                              size: 100,
                                              color: kTextColor,
                                            ),
                                          ),
                                      if (photoprofile == null)
                                        if (user!.profile_picture == null)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
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
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      204, 221, 245, 1),
                                            ),
                                            onPressed: () {
                                              setState(() async {
                                                photoprofile =
                                                    await Utile.getImage();
                                                if (photoprofile != null) {
                                                  submitphoto({});
                                                }
                                              });
                                              setState(() {});
                                            },
                                            child: const Text(
                                              'Modifier',
                                              style: TextStyle(
                                                  color: pPrimaryColor),
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
                                          fontSize:
                                              getProportionateScreenWidth(17),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${user!.last_name}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenWidth(17),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, DemandeUpdate.routeName);
                        },
                        icon: const Icon(FontAwesomeIcons.edit)),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(204, 221, 245, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: Column(
                        children: List.generate(accountList.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 03),
                            child: Column(
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        //primary: Colors.black,
                                        ),
                                    onPressed: () => Navigator.pushNamed(
                                        context, accountList[index]["route"]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          accountList[index]["nom"],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black.withOpacity(0.5),
                                          size: getProportionateScreenWidth(17),
                                        )
                                      ],
                                    )),

                                /* Divider(
                      color: Colors.grey.withOpacity(0.8),
                    )*/
                              ],
                            ),
                          );
                        }),
                      ),
                    )),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(204, 221, 245, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                //primary: Colors.black,
                                ),
                            onPressed: () => {_launchURL()},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "FAQ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black.withOpacity(0.5),
                                  size: getProportionateScreenWidth(17),
                                )
                              ],
                            )))),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(204, 221, 245, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                //primary: Colors.black,
                                ),
                            onPressed: () => {
                                  StoreAuth().logout(),
                                  Navigator.pushReplacementNamed(
                                      context, SplashScreen1.routeName)
                                },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Se deconnecter",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black.withOpacity(0.5),
                                  size: getProportionateScreenWidth(17),
                                )
                              ],
                            ))))
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget getBody() {
    return ListView(
      children: [
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
                              if (user!.profile_picture != null)
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      "https://webapp.africabourse-am.net/backend/photos/${user!.profile_picture!}",
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
                              if (photoprofile == null &&
                                  user!.profile_picture == null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Icon(
                                    FontAwesomeIcons.userCircle,
                                    size: 100,
                                  ),
                                ),
                              Positioned(
                                right: 5,
                                bottom: 0,
                                child: SizedBox(
                                  height: 40,
                                  width: 90,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      //primary: Colors.white,
                                      backgroundColor: const Color.fromRGBO(
                                          204, 221, 245, 1),
                                    ),
                                    onPressed: () {
                                      // setState(() async {
                                      //   photoprofile = await Utile.getImage();
                                      //   if (photoprofile != null) {
                                      //     submitphoto({});
                                      //   }
                                      // });
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  //Navigator.pushNamed(context, DemandeUpdate.routeName);
                },
                icon: const Icon(FontAwesomeIcons.edit)),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(204, 221, 245, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                children: List.generate(accountList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 03),
                    child: Column(
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                //primary: Colors.black,
                                ),
                            onPressed: () => Navigator.pushNamed(
                                context, accountList[index]["route"]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  accountList[index]["nom"],
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black.withOpacity(0.5),
                                  size: getProportionateScreenWidth(17),
                                )
                              ],
                            )),

                        /* Divider(
                      color: Colors.grey.withOpacity(0.8),
                    )*/
                      ],
                    ),
                  );
                }),
              ),
            )),
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(204, 221, 245, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0)),
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextButton(
                    style: TextButton.styleFrom(
                        //primary: Colors.black,
                        ),
                    onPressed: () => {_launchURL()},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "FAQ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black.withOpacity(0.5),
                          size: getProportionateScreenWidth(17),
                        )
                      ],
                    )))),
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(204, 221, 245, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0)),
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextButton(
                    style: TextButton.styleFrom(
                        //primary: Colors.black,
                        ),
                    onPressed: () => {
                          StoreAuth().logout(),
                          Navigator.pushReplacementNamed(
                              context, SplashScreen1.routeName)
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Se deconnecter",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black.withOpacity(0.5),
                          size: getProportionateScreenWidth(17),
                        )
                      ],
                    ))))
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Mon compte",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
                color: pPrimaryColor),
          ),
        ]));
  }
}
