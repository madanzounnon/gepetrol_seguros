import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/components/custom_surfix_icon.dart';
import 'package:gepetrol_eguros/components/form_error.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final _formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? conform_password;

  String? typepiece;
  int? numpiece;
  String? photo;
  String? pieceidentite;
  String? signanture;

  String? civilite;
  String? country;
  String? phoneNumber;
  String? address;
  bool remember = false;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  final List<String?> errors = [];

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            // Text("Nous avons envoyé votre code au\n +229 00 00 00 ", textAlign:TextAlign.center),
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Adresse'),
                    content: Column(
                      children: <Widget>[
                        buildPhoneNumberFormField(),
                        // buildshowCountryPicker(context),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        buildEmailFormField(),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        buildPhoneNumberFormField(),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(10)),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('OTP'),
                    content: const Column(
                      children: <Widget>[
                        /*Text(
                            "Vérification OTP",
                            style: headingStyle,
                          ),
                          Text("Nous avons envoyé votre code au\n +229 00 00 00 ", textAlign:TextAlign.center),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Ce code expirera dans  "),
                              TweenAnimationBuilder(
                                tween: Tween(begin: 30.0, end: 0.0),
                                duration: Duration(seconds: 30),
                                builder: (_, dynamic value, child) => Text(
                                  "00:${value.toInt()}",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: getProportionateScreenWidth(60),
                                child: TextFormField(
                                  autofocus: true,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: otpInputDecoration,
                                  onChanged: (value) {
                                    nextField(value, pin2FocusNode);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(60),
                                child: TextFormField(
                                  focusNode: pin2FocusNode,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: otpInputDecoration,
                                  onChanged: (value) => nextField(value, pin3FocusNode),
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(60),
                                child: TextFormField(
                                  focusNode: pin3FocusNode,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: otpInputDecoration,
                                  onChanged: (value) => nextField(value, pin4FocusNode),
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(60),
                                child: TextFormField(
                                  focusNode: pin4FocusNode,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: otpInputDecoration,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      pin4FocusNode!.unfocus();
                                      // Then you need to check is the code is correct or not
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.1),
                          GestureDetector(
                            onTap: () {
                              // OTP code resend
                            },
                            child: Text(
                              "Renvoyer le code OTP",
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                          )
                        */
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Mobile Number'),
                    content: const Column(
                      children: <Widget>[
                        //DropdownItem(),
                        //SizedBox(height: getProportionateScreenHeight(15)),
                        /* buildFirstNameFormField(),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          buildLastNameFormField(),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          buildPhoneNumberFormField(),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          buildEmailFormField(),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          buildAddressFormField(),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          FormError(errors: errors)*/
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
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
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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
      decoration: const InputDecoration(
        labelText: "Mot de passe",
        hintText: "Tapez votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
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
      decoration: const InputDecoration(
        labelText: "E-mail",
        hintText: "Entrer votre Email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Adresse",
        hintText: "Entrez votre adresse",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Numéro de téléphone",
        hintText: "Entrez votre numéro de téléphone",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: const InputDecoration(
        labelText: "Nom",
        hintText: "Entrez votre nom",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Prénom(s)",
        hintText: "Entrez vos prénoms",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
