import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/carburant.dart';
import '../../../models/categories.dart';
import '../../../size_config.dart';

class CategorieListTileWidget extends StatelessWidget {
  const CategorieListTileWidget({
    Key? key,
    required this.categorie,
    required this.isSelected,
    required this.onSelectedCategorie,
  }) : super(key: key);

  final Categorie categorie;
  final bool isSelected;
  final ValueChanged<Categorie> onSelectedCategorie;

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
        onSelectedCategorie(categorie),
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: color.withOpacity(0.30),
        child: Text(
          categorie.title.split('')[0],
          style: TextStyle(
              fontSize: getProportionateScreenHeight(20), color: color),
        ),
      ),
      title: Text(
        "${categorie.title} (code: ${categorie.code_category})",
        style: style,
      ),
      // subtitle: Text(
      //   "code: ${categorie.code_category}",
      //   maxLines: 1,
      // ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
