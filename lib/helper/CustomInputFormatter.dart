import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputFormatter extends TextInputFormatter {
  final RegExp regExp;

  CustomInputFormatter(this.regExp);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
