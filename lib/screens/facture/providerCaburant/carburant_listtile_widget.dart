import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/carburant.dart';
import '../../../size_config.dart';

class CaburantListTileWidget extends StatelessWidget {
  const CaburantListTileWidget({
    Key? key,
    required this.caburant,
    required this.isSelected,
    required this.onSelectedCaburant,
  }) : super(key: key);

  final Caburant caburant;
  final bool isSelected;
  final ValueChanged<Caburant> onSelectedCaburant;

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
        onSelectedCaburant(caburant),
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: color.withOpacity(0.30),
        child: Text(
          caburant.title.split('')[0],
          style: TextStyle(
              fontSize: getProportionateScreenHeight(20), color: color),
        ),
      ),
      title: Text(
        "${caburant.title} (code: ${caburant.code})",
        style: style,
      ),
      subtitle: Text(
        "code: ${caburant.code}",
        maxLines: 1,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
