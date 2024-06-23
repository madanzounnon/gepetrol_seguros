import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gepetrol_eguros/components/custom_surfix_icon.dart';
import 'package:gepetrol_eguros/components/default_button.dart';
import 'package:gepetrol_eguros/components/form_error.dart';
import 'package:gepetrol_eguros/components/no_account_text.dart';
import 'package:gepetrol_eguros/size_config.dart';
import 'package:gepetrol_eguros/helper/keyboard.dart';
import 'package:gepetrol_eguros/helper/store.dart';
import 'package:gepetrol_eguros/helper/utile.dart';
import 'package:gepetrol_eguros/models/api_error.dart';
import 'package:gepetrol_eguros/screens/forgot_password/verify_code_screen.dart';
import 'package:gepetrol_eguros/services/auth.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Réinitialisez votre \nmot de passe",
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
                  height: getProportionateScreenHeight(150),
                  width: getProportionateScreenHeight(150),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                "Veuillez entrer votre e-mail et nous vous enverrons un code pour réinitialisez votre mot de passe",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCtl = TextEditingController();

  List<String> errors = [];
  String? email;
  int? codeEnvoyer;
  bool estEnvoyer = false;

  Future<void> sendCode(String email) async {
    Utile.loarder(context);
    StoreAuth().restoreUser();
    Response res = await Auth().sendVerifyCodeReset(email);
    if (res.statusCode == 200) {
      Navigator.of(context).pop();
      KeyboardUtil.hideKeyboard(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => VerifyCodeScreen(
                email: res.data["email"],
                codeEnvoyer: res.data["verification_code"])),
      );
      Utile.messageSuccess(
          context, 'Un code a été envoyé dans votre boîte email');
    } else {
      KeyboardUtil.hideKeyboard(context);
      Navigator.of(context).pop();
      ApiError apiError = ApiError.fromMap(res.data);
      Utile.messageErro(context, '${apiError.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailCtl,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              email = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                return kInvalidEmailError;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "E-mail",
              hintText: "Entrer votre Email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          //SizedBox(height: getProportionateScreenHeight(10)),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DefaultButton(
            text: "Continuez",
            press: () {
              if (_formKey.currentState!.validate()) {
                sendCode(emailCtl.text.trim());
              }
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          NoAccountText(),
        ],
      ),
    );
  }
}
