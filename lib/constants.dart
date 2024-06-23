import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/size_config.dart';

const kPrimaryColor = Color.fromRGBO(0, 30, 79, 1);
const pPrimaryColor = Color.fromRGBO(0, 118, 88, 1);
const pSuccessligthColor = Color.fromRGBO(164, 242, 221, 1);
const pSuccessColor = Color.fromRGBO(15, 178, 137, 1);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
const String kEmailNullError = "Veuillez saisir votre e-mail";
const String kInvalidEmailError = "Veuillez saisir une adresse e-mail valide";
const String kPassNullError = "S'il vous plait entrez votre mot de passe";
const String kShortPassError = "Le mot de passe est trop court";
const String kMatchPassError = "Les mots de passe ne correspondent pas";
const String kNamelNullError = "S'il vous plaît entrez votre nom";
const String kFirstNamelNullError = "S'il vous plaît entrez votre prénom";
const String kPhoneNumberNullError =
    "Veuillez entrer votre numéro de téléphone";
const String kAddressNullError = "Veuillez entrer votre adresse";
const String kDateNailNullError = "Veuillez entrer votre date de naissance";
const String kPieceNumberNullError = "Veuillez entrer votre numéro de la pièce";
const String KtypepiecelNullError = "Veuillez selectionner le type de pièce";
const String kcivilitelNullError = "Veuillez selectionner votre civilité";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(0),
  ),
  border: InputBorder.none,
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(0)),
    borderSide: BorderSide(color: kTextColor),
  );
}
