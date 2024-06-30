import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/power.dart';
import '../../../size_config.dart';

class PowerListTileWidget extends StatelessWidget {
  final Power power;
  final bool isSelected;
  final ValueChanged<Power> onSelectedPower;

  const PowerListTileWidget({
    Key? key,
    required this.power,
    required this.isSelected,
    required this.onSelectedPower,
  }) : super(key: key);

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
        onSelectedPower(power),
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: color.withOpacity(0.30),
        child: Text(
          'PT',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(20), color: color),
        ),
      ),
      title: Text(
        "${power.min_power}CV - ${power.max_power}CV",
        style: style,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
