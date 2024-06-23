import 'package:flutter/material.dart';
import '../size_config.dart';

class DropdowninputForm extends StatefulWidget {
  TextEditingController? controller;
  String? labeltext;
  String? hintText;
  RegExp? regExp;
  String? regExpmessage;
  String urlsvgicon;
  String? name;
  String? isNotEmptyMessage;
  bool estreadonly;
  bool validInput;
  Function? onChanged;
  List<String?>? data;
  DropdowninputForm(
      {Key? key,
      this.controller,
      this.isNotEmptyMessage = "est obligatoire",
      this.labeltext,
      this.hintText,
      this.regExp,
      this.regExpmessage,
      this.urlsvgicon = "assets/icons/Flash Icon.svg",
      this.name,
      this.estreadonly = false,
      this.validInput = true,
      this.onChanged,
      this.data})
      : super(key: key);

  @override
  State<DropdowninputForm> createState() => _dropdowninputFormState();
}

class _dropdowninputFormState extends State<DropdowninputForm> {
  List<DropdownMenuItem<String>> items = [];
  @override
  void initState() {
    super.initState();
    if (widget.data!.length > 0) {
      for (var i = 0; i < widget.data!.length; i++) {
        items.add(DropdownMenuItem<String>(
            value: widget.data![i],
            child: Text("${widget.data![i]}",
                style: TextStyle(fontSize: getProportionateScreenWidth(15)))));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.labeltext} "),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          DropdownButtonFormField<String>(
            icon: Icon(Icons.chevron_right),
            isExpanded: true,
            onSaved: (newValue) => widget.name = newValue,
            onChanged: (String? newValue) {
              if (newValue!.isNotEmpty) {
                setState(() {
                  widget.controller!.text = newValue;
                });
              }
            },
            validator: widget.validInput
                ? (value) {
                    if (value == null || value == "") {
                      return "${widget.labeltext} est ${widget.isNotEmptyMessage}";
                    }
                    return null;
                  }
                : null,
            items: items,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15)),
              hintText: (widget.hintText) != null
                  ? widget.hintText
                  : "Selectionnez une réponse",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ]);
  }
}
