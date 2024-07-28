import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // backgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
            backgroundColor: Colors.white, cardColor: Colors.white)
        .copyWith(primary: pPrimaryColor),
    //cardColor: Colors.white,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodySmall: TextStyle(color: kTextColor),
    bodyMedium: TextStyle(color: kTextColor),
    bodyLarge: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    backgroundColor: pPrimaryColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
    titleTextStyle:
        TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: pPrimaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
}
