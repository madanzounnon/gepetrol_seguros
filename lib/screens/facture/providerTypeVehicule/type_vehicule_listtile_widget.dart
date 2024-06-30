import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/typeVehicule.dart';
import '../../../size_config.dart';

class TypeVehiculeListTileWidget extends StatelessWidget {
  const TypeVehiculeListTileWidget({
    Key? key,
    required this.typeVehicule,
    required this.isSelected,
    required this.onSelectedTypeVehicule,
  }) : super(key: key);

  final TypeVehicule typeVehicule;
  final bool isSelected;
  final ValueChanged<TypeVehicule> onSelectedTypeVehicule;

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
        onSelectedTypeVehicule(typeVehicule),
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: color.withOpacity(0.30),
        child: Text(
          typeVehicule.title.split('')[0],
          style: TextStyle(
              fontSize: getProportionateScreenHeight(20), color: color),
        ),
      ),
      title: Text(
        "${typeVehicule.title}",
        style: style,
      ),
      subtitle: const Text(
        "",
        maxLines: 1,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
