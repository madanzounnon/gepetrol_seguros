import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/models/pub.dart';

class DropdownItem extends StatefulWidget {
  @override
  _DropdownItemState createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _dropdownFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Ordre",
                  hintText: "Selectionnez l'ordre",
                  /*enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),*/
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Bell.svg"),
                  filled: true,
                  //fillColor: Colors.blueAccent,
                ),
                //dropdownColor: Colors.blueAccent,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems)
          ],
        ));
  }
}
