import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../size_config.dart';
import 'data.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: getProportionateScreenWidth(20)),
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(children: [
            Text("GEPetrol Seguros",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(25),
                    color: pPrimaryColor,
                    fontWeight: FontWeight.w900)),
            SizedBox(height: getProportionateScreenWidth(18)),
            Row(
              children: [
                Image.asset('assets/images/1.png',
                    height: getProportionateScreenHeight(110)),
                SizedBox(
                  width: getProportionateScreenWidth(5),
                ),
                Expanded(
                  child: Text(
                      "GEPetrol Seguros, S.A. es la primera empresa de seguros de derecho nacional en Guinea Ecuatorial.",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(13))),
                )
              ],
            ),
            Text(
                " Creación de GEPETROL SEGUROS S.A por GEPETROL, S.A. mediante Decreto presidencial número 56/2007. NIF. 01983GS-21. Registro de comercio Núm. 2794. Capital social 5.000.000.000 FCFA....",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                )),
          ])),
      SizedBox(height: getProportionateScreenWidth(20)),
      Expanded(
          child: ListView(
        children: data.map((item) {
          return Card(
            child: ListTile(
              //onTap: () => _launchURL(item['url']),
              // leading: CircleAvatar(
              //   backgroundColor: Colors.grey.shade100,
              //   child: FaIcon(
              //     item['icon'],
              //     color: item['color'],
              //     size: 25,
              //   ),
              // ),
              title: Text(
                item['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(18),
                ),
              ),
              subtitle: Text(
                item['subtitle'],
                textAlign: TextAlign.justify,
              ),
              //trailing:  Icon(Icons.arrow_forward_ios,size: getProportionateScreenWidth(20),),
            ),
          );
        }).toList(),
      ))
    ]);
  }

  void _launchURL(String _url) async {
    Uri url = Uri.parse(_url);
    if (!await launchUrl(url,
        mode: LaunchMode.platformDefault,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ))) throw 'Could not launch $_url';
  }
}
