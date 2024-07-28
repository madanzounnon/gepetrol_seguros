import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';
import '../../../models/marque.dart';
import '../../../size_config.dart';

class MarqueListTileWidget extends StatelessWidget {
  const MarqueListTileWidget({
    Key? key,
    required this.marque,
    required this.isSelected,
    required this.onSelectedMarque,
  }) : super(key: key);

  final Marque marque;
  final bool isSelected;
  final ValueChanged<Marque> onSelectedMarque;

  @override
  Widget build(BuildContext context) {
    List colors = [
      Colors.orange,
      Colors.green,
      Colors.yellow,
      Colors.blue,
      Colors.blueGrey,
      Colors.black,
      Colors.red,
      Colors.pink
    ];
    Random random = Random();
    Color color = colors[random.nextInt(7)];
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(
            fontSize: 18,
            color: selectedColor,
            fontWeight: FontWeight.bold,
          )
        : const TextStyle(fontSize: 18);
    return ListTile(
      onTap: () => {
        onSelectedMarque(marque),
      },
      leading: (marque.image != null)
          ? CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage:
                  NetworkImage("https://seguros.fifonsi.net${marque.image}"),
            )
          : CircleAvatar(
              radius: 30,
              // backgroundImage:
              //     NetworkImage("https://seguros.fifonsi.net${marque.image}"),
              backgroundColor: kPrimaryColor,
              child: Text(
                marque.title.split('')[0],
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20), color: color),
              ),
            ),
      title: Text(
        "${marque.title}",
        style: style,
      ),
      subtitle: Text(
        "Marca ${marque.title}",
        maxLines: 1,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
