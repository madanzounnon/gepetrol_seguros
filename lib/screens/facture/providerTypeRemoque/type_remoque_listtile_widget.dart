import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/typeRemoque.dart';
import '../../../size_config.dart';

class TypeRemoqueListTileWidget extends StatelessWidget {
  const TypeRemoqueListTileWidget({
    Key? key,
    required this.typeRemoque,
    required this.isSelected,
    required this.onSelectedTypeRemoque,
  }) : super(key: key);

  final TypeRemoque typeRemoque;
  final bool isSelected;
  final ValueChanged<TypeRemoque> onSelectedTypeRemoque;

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
        onSelectedTypeRemoque(typeRemoque),
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: color.withOpacity(0.30),
        child: Text(
          typeRemoque.title.split('')[0],
          style: TextStyle(
              fontSize: getProportionateScreenHeight(20), color: color),
        ),
      ),
      title: Text(
        "${typeRemoque.title}",
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
