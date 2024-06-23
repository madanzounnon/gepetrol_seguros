// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gepetrol_eguros/components/custom_surfix_icon.dart';
import 'package:gepetrol_eguros/components/default_button.dart';
import 'package:gepetrol_eguros/components/no_account_text.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/helper/keyboard.dart';
import 'package:gepetrol_eguros/helper/utile.dart';
import 'package:gepetrol_eguros/models/api_error.dart';
import 'package:gepetrol_eguros/screens/sign_in/sign_in_screen.dart';
import 'package:gepetrol_eguros/services/auth.dart';
import 'package:gepetrol_eguros/size_config.dart';

class NewPasswordScreen extends StatefulWidget {
  static String routeName = "/new_password";
  String email;
  NewPasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController conform_passwordCtl = TextEditingController();

  Future<void> resetpassword(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Utile.loarder(context);
      Response res = await Auth().resetPassword(email, password);
      if (res.statusCode == 200) {
        Navigator.of(context).pop();
        KeyboardUtil.hideKeyboard(context);
        Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
        Utile.messageSuccess(
            context, "Votre mot de passe a été réinitialisé avec succès");
      } else {
        Navigator.of(context).pop();
        ApiError apiError = ApiError.fromMap(res.data);
        Utile.messageErro(context, '${apiError.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mot de passe oublié"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Definir un nouveau \nmot de passe",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: pPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(50)),
                  child: SvgPicture.asset(
                    'assets/icons/locknew.svg',
                    height: getProportionateScreenHeight(120),
                    width: getProportionateScreenHeight(120),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "Veuillez entrer votre mot de passe et confirmez votre le mot de passe",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildPasswordFormField(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      buildConformPassFormField(),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      DefaultButton(
                        text: "Continuez",
                        press: () {
                          resetpassword(widget.email, passwordCtl.text.trim());
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      NoAccountText(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_passwordCtl.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
        } else if (value.isNotEmpty &&
            passwordCtl.text.trim() == conform_passwordCtl.text.trim()) {}
        conform_passwordCtl.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if ((passwordCtl.text.trim() != value)) {
          return kMatchPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirmez le mot de passe",
        hintText: "Entrez à nouveau votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordCtl,
      obscureText: true,
      onSaved: (newValue) => passwordCtl.text = newValue!,
      onChanged: (value) {
        passwordCtl.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mot de passe",
        hintText: "Tapez votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
