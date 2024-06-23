// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gepetrol_eguros/components/default_button.dart';
import 'package:gepetrol_eguros/components/no_account_text.dart';

import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/helper/utile.dart';
import 'package:gepetrol_eguros/screens/new_%20password/new_password_screen.dart';
import 'package:gepetrol_eguros/size_config.dart';

import 'components/body.dart';

class VerifyCodeScreen extends StatefulWidget {
  VerifyCodeScreen({
    Key? key,
    required this.email,
    required this.codeEnvoyer,
  }) : super(key: key);

  static String routeName = "/forgot_password";

  int codeEnvoyer;
  String email;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  String? code1 = '';
  TextEditingController code1Ctl = TextEditingController();
  String? code2 = '';
  TextEditingController code2Ctl = TextEditingController();
  String? code3 = '';
  TextEditingController code3Ctl = TextEditingController();
  String? code4 = '';
  TextEditingController code4Ctl = TextEditingController();
  String? code5 = '';
  TextEditingController code5Ctl = TextEditingController();
  String? codes;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    //KeyboardUtil.hideKeyboard(context);
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vérification d'identité"),
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
                  "Vérification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: pPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: getProportionateScreenWidth(50)),
                //   child: SvgPicture.asset(
                //     'assets/icons/locknew.svg',
                //     height: getProportionateScreenHeight(150),
                //     width: getProportionateScreenHeight(150),
                //   ),
                // ),
                // SizedBox(height: getProportionateScreenHeight(30)),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(50)),
                          child: Image.asset(
                            'assets/images/phoneopt.png',
                            height: getProportionateScreenHeight(170),
                            width: getProportionateScreenHeight(170),
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.04),
                        Text("Veuillez insérer le code envoyé à",
                            textAlign: TextAlign.center),
                        Text(
                          "${widget.email}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: pPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Ce code expirera dans  15min "),
                            TweenAnimationBuilder(
                              tween: Tween(begin: 15, end: 0.0),
                              duration: Duration(minutes: 15),
                              builder: (_, dynamic value, child) => Text(
                                "00:${value.toInt()}",
                                style: TextStyle(color: pPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(45),
                              child: TextFormField(
                                controller: code1Ctl,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "oop";
                                  }
                                  return null;
                                },
                                autofocus: true,
                                obscureText: true,
                                style: TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                maxLength: 1,
                                onChanged: (value) {
                                  code1 = value;
                                  nextField(value, pin2FocusNode);
                                },
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(45),
                              child: TextFormField(
                                  controller: code2Ctl,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "oop";
                                    }
                                    return null;
                                  },
                                  focusNode: pin2FocusNode,
                                  maxLength: 1,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: otpInputDecoration,
                                  onChanged: (value) {
                                    code2 = value;
                                    nextField(value, pin3FocusNode);
                                  }),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(45),
                              child: TextFormField(
                                controller: code3Ctl,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "oop";
                                  }
                                  return null;
                                },
                                focusNode: pin3FocusNode,
                                maxLength: 1,
                                obscureText: true,
                                style: TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) {
                                  code3 = value;
                                  nextField(value, pin4FocusNode);
                                },
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(45),
                              child: TextFormField(
                                controller: code4Ctl,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "oop";
                                  }
                                  return null;
                                },
                                focusNode: pin4FocusNode,
                                maxLength: 1,
                                obscureText: true,
                                style: TextStyle(fontSize: 24),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) {
                                  code4 = value;
                                  nextField(value, pin5FocusNode);
                                },
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(45),
                              child: TextFormField(
                                controller: code5Ctl,
                                focusNode: pin5FocusNode,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "oop";
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: 24),
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: otpInputDecoration,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    code5 = value;
                                    // Then you need to check is the code is correct or not
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                          ],
                        ),

                        // GestureDetector(
                        //   onTap: () {
                        //     // OTP code resend
                        //   },
                        //   child: Text(
                        //     "Renvoyer un nouveau code",
                        //     style: TextStyle(
                        //         color: pPrimaryColor,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // SizedBox(height: getProportionateScreenHeight(20)),
                      ],
                    )),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                DefaultButton(
                  text: "Continuez",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      codes = "$code1$code2$code3$code4$code5";
                      print("$code1$code2$code3$code4$code5");
                      print(widget.codeEnvoyer.toString().length);
                      print(codes!.length);
                      print(codes!.compareTo(widget.codeEnvoyer.toString()));
                      print(codes!.trim() ==
                          widget.codeEnvoyer.toString().trim());
                      if (codes!.compareTo(widget.codeEnvoyer.toString()) ==
                          0) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewPasswordScreen(email: widget.email)),
                        );
                      } else {
                        Utile.messageErro(
                            context, "Le code de vérification est incorrect");
                      }
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                NoAccountText(),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
