import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: pPrimaryColor,
                    fontWeight: FontWeight.w900)),

            Text("¿Tienes alguna pero, queja o sugerencia? Hablemos de ello",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.bold)),
            SizedBox(height: getProportionateScreenWidth(18)),
            // Image.asset(
            //   'assets/images/phoneopt.png',
            //   height: getProportionateScreenHeight(120),
            // )
          ])),
      //SizedBox(height: getProportionateScreenWidth(20)),
      Expanded(
          child: ListView(
        children: data.map((item) {
          return Card(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(5)),
            color: const Color(0xFFF5F6F9),
            child: ListTile(
              onTap: () => _launchURL(item['url']),
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                child: FaIcon(
                  item['icon'],
                  color: item['color'],
                  size: getProportionateScreenWidth(20),
                ),
              ),
              title: Text(
                item['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(16),
                ),
              ),
              subtitle: Text(item['subtitle']),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: getProportionateScreenWidth(15),
              ),
            ),
          );
        }).toList(),
      ))
    ]);
  }

  void _launchURL(String urll) async {
    Uri url = Uri.parse(urll);
    if (!await launchUrl(url,
        mode: LaunchMode.platformDefault,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ))) {
      throw "Could not launch $urll";
    }
  }
}
