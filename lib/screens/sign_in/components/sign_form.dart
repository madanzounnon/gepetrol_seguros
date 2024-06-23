import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gepetrol_eguros/components/custom_surfix_icon.dart';
import 'package:gepetrol_eguros/components/form_error.dart';
import 'package:gepetrol_eguros/helper/keyboard.dart';
import 'package:gepetrol_eguros/helper/store.dart';
import 'package:gepetrol_eguros/helper/utile.dart';
import 'package:gepetrol_eguros/models/api_error.dart';
import 'package:gepetrol_eguros/models/login_success.dart';
import 'package:gepetrol_eguros/screens/entry_point.dart';
import 'package:gepetrol_eguros/screens/forgot_password/forgot_password_screen.dart';
import 'package:gepetrol_eguros/services/auth.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCt = TextEditingController();
  TextEditingController passwordCt = TextEditingController();
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  bool? remember = false;
  final List<String?> errors = [];
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> loginUser(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Utile.loarder(context);
      Response res = await Auth().authenticate(email, password);
      if (res.statusCode == 200) {
        StoreAuth().restoreUser();
        LoginSuccess loginSuccess = LoginSuccess.fromMap(res.data);
        StoreAuth().saveUser(res.data["user"]);
        StoreAuth().saveToken(loginSuccess.token);
        Navigator.of(context).pop();
        KeyboardUtil.hideKeyboard(context);
        //Navigator.pushAndRemoveUntil(context, EntryPoint.routeName);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => EntryPoint()),
            (route) => false);
        Utile.messageSuccess(context, "Bonjour, Merci de vous revoir");
      } else {
        Navigator.of(context).pop();
        ApiError apiError = ApiError.fromMap(res.data);
        Utile.messageErro(context, '${apiError.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            children: [
              // Checkbox(
              //   value: remember,
              //   activeColor: pPrimaryColor,
              //   onChanged: (value) {
              //     setState(() {
              //       remember = value;
              //     });
              //   },
              // ),
              // Text("Souviens-toi de moi"),
              // Spacer(),
              SizedBox(width: getProportionateScreenWidth(10)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Mot de passe oublié",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: pPrimaryColor),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "S'identifier",
            press: () {
              loginUser(emailCt.text.trim(), passwordCt.text.trim());
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      controller: passwordCt,
      onSaved: (newValue) => passwordCt.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mot de passe*",
        hintText: "Tapez votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: hideShowpass(),
      ),
    );
  }

  Widget hideShowpass() {
    return Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          0,
          getProportionateScreenWidth(10),
          0,
        ),
        child: IconButton(
            icon: Icon(
                _obscureText ? Icons.remove_red_eye : FontAwesomeIcons.eye),
            onPressed: _toggle));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailCt,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => emailCt.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "E-mail*",
        hintText: "Entrer votre Email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
