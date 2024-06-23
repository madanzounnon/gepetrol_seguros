import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/size_config.dart';

class ItemElement extends StatelessWidget {
  const ItemElement({
    Key? key,
    this.cle,
    this.valeur,
    this.couleur,
    this.textcolor,
    this.press,
    this.icon,
  }) : super(key: key);
  final String? cle, valeur;
  final IconData? icon;
  final Color? couleur;
  final Color? textcolor;
  final Function? press;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*FaIcon(icon,size: 15, color: couleur),
              SizedBox(width: 10),*/
            Expanded(
                child: Text(
              cle!,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15), color: textcolor),
            )),
            SizedBox(width: 5),
            Text("${valeur}",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: textcolor))
          ],
        ),
      ],
    );
    /*ListTile(
              title: Text(cle!)  ,
              leading: FaIcon(icon,size: 10, color: couleur),
              trailing: Text(valeur!,style: TextStyle(color: textcolor),),
            );*/
  }
}
