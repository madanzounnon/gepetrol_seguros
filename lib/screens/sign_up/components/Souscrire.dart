import 'package:gepetrol_eguros/screens/aam/terme_condiction/terme_condiction.dart';
import 'package:gepetrol_eguros/screens/sign_in/sign_in_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:gepetrol_eguros/components/custom_surfix_icon.dart';
import 'package:gepetrol_eguros/components/default_button.dart';
import 'package:gepetrol_eguros/components/secondary_button.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/helper/form.dart';
import 'package:gepetrol_eguros/helper/store.dart';
import 'package:gepetrol_eguros/helper/utile.dart';
import 'package:gepetrol_eguros/models/api_error.dart';
import 'package:gepetrol_eguros/models/country.dart';
import 'package:gepetrol_eguros/models/login_success.dart';
import 'package:gepetrol_eguros/services/auth.dart';
import 'package:gepetrol_eguros/size_config.dart';
import 'package:gepetrol_eguros/components/form_error.dart';

import '../../../helper/keyboard.dart';

class Souscrire extends StatefulWidget {
  @override
  static String routeName = "/souscrires";
  @override
  _SouscrireState createState() => _SouscrireState();
}

class _SouscrireState extends State<Souscrire> {
  Country? country;
  // List<Country> countries = [];
  String? codeEnvoyer = "";
  bool estEnvoyer = false;

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  String? firstName = '';
  String? lastName = '';
  String? civilite = null;
  String? address = '';
  TextEditingController dateCtl = TextEditingController();
  DateTime? date = DateTime(DateTime.now().year - 18);

  String? email = '';
  String? pays = '';
  bool? termecondition = false;
  bool? modeenvoi = false;
  bool? modeenvoi1 = false;
  String? prefix = '';
  DateTime initialDate = DateTime(DateTime.now().year - 18);

  TextEditingController passwordCtl = TextEditingController();
  TextEditingController conform_passwordCtl = TextEditingController();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController firstnameCtl = TextEditingController();
  TextEditingController lastnameCtl = TextEditingController();
  TextEditingController telephoneCtl = TextEditingController();
  TextEditingController bithdayCtl = TextEditingController();
  TextEditingController civiliteCtl = TextEditingController();
  TextEditingController addressCtl = TextEditingController();
  TextEditingController countryCtl = TextEditingController();
  TextEditingController birthPlaceCtl = TextEditingController();

  bool estphone = false;

  bool remember = false;
  final List<String?> infopass = [
    "au mois 8 caractères",
    "des lettres majuscules et minuscules ",
    "au mois  un chiffre",
    "au mois  un caractère special(@, #, &,...)"
  ];

  TextEditingController code1Ctl = TextEditingController();
  TextEditingController code2Ctl = TextEditingController();
  TextEditingController code3Ctl = TextEditingController();
  TextEditingController code4Ctl = TextEditingController();
  TextEditingController code5Ctl = TextEditingController();

  String? code1 = '';
  String? code2 = '';
  String? code3 = '';
  String? code4 = '';
  String? code5 = '';
  String? codes;
  String? typepiece = null;
  int? numpiece = 0;
  String? photo = '';
  String? pieceidentite = '';
  String? signanture = '';

  bool iscomplete = false;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;

  @override
  void initState() {
    super.initState();
    dateCtl.text = '';
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    //KeyboardUtil.hideKeyboard(context);
  }

  Future<bool> sendCode(String email) async {
    Utile.loarder(context);
    StoreAuth().restoreUser();
    Response res = await Auth().sendVerifyCode(email);
    if (res.statusCode == 201) {
      setState(() {
        estEnvoyer = res.data["success"];
        codeEnvoyer = res.data["response"];
      });
      print(codeEnvoyer);
      Navigator.of(context).pop();
      FocusScopeNode currentFocus = FocusScope.of(context);
      currentFocus.unfocus();
      //KeyboardUtil.hideKeyboard(context);
      Utile.messageSuccess(context, res.data["message"]);
      return true;
    } else {
      Navigator.of(context).pop();
      ApiError apiError = ApiError.fromMap(res.data);
      Utile.messageErro(context, '${apiError.message}');
      return false;
    }
  }

  Future<void> register() async {
    Utile.loarder(context);

    Map<String, dynamic>? userData = {
      "email": email,
      "code": codeEnvoyer,
      "first_name": firstnameCtl.text.trim(),
      "last_name": lastnameCtl.text.trim(),
      "username": usernameCtl.text.trim(),
      "phone": telephoneCtl.text.trim(),
      "sex": civiliteCtl.text.trim(),
      "password": passwordCtl.text.trim(),
    };

    Response res = await Auth().register(userData);
    if (res.statusCode == 201) {
      Navigator.of(context).pop();
      StoreAuth().restoreUser();
      Navigator.of(context).pop();
      KeyboardUtil.hideKeyboard(context);
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      Utile.messageSuccess(context, "Su cuenta ha sido creada con éxito");
    } else {
      Navigator.of(context).pop();
      ApiError apiError = ApiError.fromMap(res.data);
      Utile.messageErro(context, '${apiError.message}');
    }
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
  }

  /*bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }*/

  Future<void> _showDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1978),
      lastDate: DateTime(2023),
    ).then((value) => {
          if (value != null)
            {
              setState(() {
                initialDate = value;
              })
            }
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date ?? now,
        firstDate: DateTime(1920),
        lastDate: DateTime(2003));
    if (picked != null && picked != date) {
      //print('hello $picked');
      setState(() {
        date = picked;
      });
    }
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
    return Scaffold(
      /* appBar: AppBar(
          automaticallyImplyLeading: false,
            title: Text('Flutter Stepper Demo'),
          centerTitle: true,
        ),*/
      body: iscomplete
          ? sucess()
          : SafeArea(
              child: Column(children: [
                Expanded(
                  child: Stepper(
                    type: StepperType.horizontal,
                    physics: const ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      final isLast = _currentStep == 2;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SecondaryButton(
                            width: 100,
                            textcolor: Colors.white,
                            text: isLast ? 'Registrar' : 'Siguiente',
                            backcolor: pPrimaryColor,
                            press: details.onStepContinue,
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          if (_currentStep > 0)
                            SecondaryButton(
                              width: 100,
                              textcolor: Colors.white,
                              text: 'Anterior',
                              backcolor: kPrimaryColor,
                              press: details.onStepCancel,
                            ),
                        ],
                      );
                    },
                    steps: <Step>[
                      Step(
                        title: new Text('CT'),
                        content: Form(
                            key: _formKey1,
                            child: Column(
                              children: <Widget>[
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(
                                                    50)),
                                        child: SvgPicture.asset(
                                          'assets/images/logo.svg',
                                          height:
                                              getProportionateScreenHeight(100),
                                          width:
                                              getProportionateScreenHeight(100),
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(10)),
                                      const Text(
                                          "Sírvase proporcionar la información",
                                          textAlign: TextAlign.center),
                                    ]),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                buildCivilite(context),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                buildFirstNameFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                buildLastNameFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                IntlPhoneField(
                                  countries: const [
                                    Country(
                                      name: "Equatorial Guinea",
                                      nameTranslations: {
                                        "sk": "Rovníková Guinea",
                                        "se": "Ekvatoriála Guinea",
                                        "pl": "Gwinea Równikowa",
                                        "no": "Ekvatorial-Guinea",
                                        "ja": "赤道ギニア",
                                        "it": "Guinea Equatoriale",
                                        "zh": "赤道几内亚",
                                        "nl": "Equatoriaal-Guinea",
                                        "de": "Äquatorialguinea",
                                        "fr": "Guinée équatoriale",
                                        "es": "Guinea Ecuatorial",
                                        "en": "Equatorial Guinea",
                                        "pt_BR": "Guiné Equatorial",
                                        "sr-Cyrl": "Екваторијална Гвинеја",
                                        "sr-Latn": "Ekvatorijalna Gvineja",
                                        "zh_TW": "赤道幾內亞",
                                        "tr": "Ekvator Ginesi",
                                        "ro": "Guineea Ecuatorială",
                                        "ar": "غينيا الاستوائية",
                                        "fa": "گینه استوایی",
                                        "yue": "赤道幾內亞"
                                      },
                                      flag: "🇬🇶",
                                      code: "GQ",
                                      dialCode: "240",
                                      minLength: 9,
                                      maxLength: 9,
                                    ),
                                  ],
                                  //controller: telephoneCtl,
                                  onSaved: (newValue) =>
                                      telephoneCtl.text = newValue!.number,
                                  showCountryFlag: true,
                                  dropdownIcon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                  invalidNumberMessage: "Invalid Mobile Number",
                                  decoration: const InputDecoration(
                                    labelText: "Teléfono",
                                    hintText: "Teléfono",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    filled: false,
                                    suffixIcon: Icon(FontAwesomeIcons.phone),
                                  ),
                                  initialCountryCode: 'GQ',
                                  onChanged: (text) => setState(() {
                                    if (text.isValidNumber()) {
                                      telephoneCtl.text = text.number;
                                    }
                                  }),
                                ),
                                buildEmailFormField(estphone),
                                FormError(errors: errors),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                              ],
                            )),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('OTP'),
                        content: Form(
                            key: _formKey2,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(45)),
                                  child: Image.asset(
                                    'assets/images/phoneopt.png',
                                    height: getProportionateScreenHeight(170),
                                    width: getProportionateScreenHeight(170),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight * 0.04),
                                const Text("Introduzca el código enviado a",
                                    textAlign: TextAlign.center),
                                Text(
                                  " $email ",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: pPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "Este código expirará en 15min (900s) "),
                                    TweenAnimationBuilder(
                                      tween: Tween(begin: 15, end: 0.0),
                                      duration: const Duration(seconds: 900),
                                      builder: (_, dynamic value, child) =>
                                          Text(
                                        "00:${value.toInt()}",
                                        style: const TextStyle(
                                            color: pPrimaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight * 0.01),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: getProportionateScreenWidth(45),
                                      child: TextFormField(
                                        controller: code1Ctl,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "";
                                          }
                                          return null;
                                        },
                                        autofocus: true,
                                        obscureText: true,
                                        style: const TextStyle(fontSize: 24),
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
                                              return "";
                                            }
                                            return null;
                                          },
                                          focusNode: pin2FocusNode,
                                          maxLength: 1,
                                          obscureText: true,
                                          style: const TextStyle(fontSize: 24),
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
                                            return "";
                                          }
                                          return null;
                                        },
                                        focusNode: pin3FocusNode,
                                        maxLength: 1,
                                        obscureText: true,
                                        style: const TextStyle(fontSize: 24),
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
                                            return "";
                                          }
                                          return null;
                                        },
                                        focusNode: pin4FocusNode,
                                        maxLength: 1,
                                        obscureText: true,
                                        style: const TextStyle(fontSize: 24),
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
                                            return "";
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(fontSize: 24),
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
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight * 0.01),
                                GestureDetector(
                                  onTap: () {
                                    // OTP code resend
                                  },
                                  child: const Text(
                                    "Reenviar un nuevo código",
                                    style: TextStyle(
                                        color: pPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                FormError(errors: errors)
                              ],
                            )),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('MP'),
                        content: Form(
                            key: _formKey3,
                            child: Column(
                              children: <Widget>[
                                Column(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Establece tu contraseña y \nnombre de usuario",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(18),
                                          // color: pPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(30)),
                                      //Text("Veuillez fournir les informations \n ci-dessous.", textAlign:TextAlign.center),
                                    ]),
                                inputForm(
                                  controller: usernameCtl,
                                  validInput: true,
                                  labeltext: "Nombre del usuario",
                                ),
                                buildPasswordFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                buildConformPassFormField(),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Su contraseña debe incluir:",
                                        style: TextStyle(
                                            color: pPrimaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(10)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/Error.svg",
                                            height:
                                                getProportionateScreenWidth(15),
                                            width:
                                                getProportionateScreenWidth(15),
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(10),
                                          ),
                                          const Text("Al menos "),
                                          const Text(
                                            "8 carácteres",
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(7)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/Error.svg",
                                            height:
                                                getProportionateScreenWidth(15),
                                            width:
                                                getProportionateScreenWidth(15),
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(10),
                                          ),
                                          const Text("letras "),
                                          const Text(
                                            "mayúsculas y minúsculas ",
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(7)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/Error.svg",
                                            height:
                                                getProportionateScreenWidth(15),
                                            width:
                                                getProportionateScreenWidth(15),
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(10),
                                          ),
                                          const Text("al menos "),
                                          const Text(
                                            "un dígito",
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(7)),
                                    ]),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                              ],
                            )),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    validestape(_currentStep);
    setState(() => _currentStep = step);
    //print(errors);
  }

  Future<bool> validestape(int current) async {
    bool estvalide = false;
    switch (current) {
      case 0:
        {
          if (email != null) {
            print(email);
            print(codeEnvoyer!);
            print(estEnvoyer);
            if (_formKey1.currentState!.validate()) {
              _formKey1.currentState!.save();
              estvalide = await sendCode(email!);
              //estvalide = _formKey1.currentState!.validate();
            }
          }
        }
        break;
      case 1:
        {
          if (_formKey2.currentState!.validate()) {
            codes = "$code1$code2$code3$code4$code5";
            print("$code1$code2$code3$code4$code5");
            print(codeEnvoyer!.length);
            print(codes!.length);
            print(codes!.compareTo(codeEnvoyer!));
            print(codes!.trim() == codeEnvoyer);
            if (codes!.compareTo(codeEnvoyer!) == 0) {
              estvalide = _formKey2.currentState!.validate();
            } else {
              Utile.messageErro(context, "Le code est incorrect");
            }
            //estvalide = _formKey2.currentState!.validate();
          }
        }
        break;
      case 2:
        {
          if (_formKey3.currentState!.validate()) {
            _formKey3.currentState!.save();
          }
          estvalide = _formKey3.currentState!.validate();
        }
        break;
    }
    return estvalide;
  }

  continued() async {
    final islast = _currentStep == 2;
    //validestape(_currentStep);
    if (await validestape(_currentStep)) {
      for (var i = 0; i < errors.length; i++) {
        errors.clear();
      }
      if (islast) {
        register();
        //setState((() => iscomplete = true));
        print(iscomplete);
      } else {
        _currentStep < 2 ? setState(() => _currentStep += 1) : null;
      }
    }
  }

  cancel() {
    for (var i = 0; i < errors.length; i++) {
      errors.clear();
    }
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_passwordCtl!.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty &&
            passwordCtl!.text.trim() == conform_passwordCtl!.text.trim()) {
          removeError(error: kMatchPassError);
        }
        conform_passwordCtl!.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if ((passwordCtl!.text.trim() != value)) {
          return kMatchPassError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirmar Contraseña*",
        hintText: "Confirmar Contraseña",
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
      onSaved: (newValue) => passwordCtl!.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
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
      decoration: const InputDecoration(
        labelText: "Contraseña*",
        hintText: "Contraseña",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(bool estphone) {
    return TextFormField(
      controller: emailCtl,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        email = value;
      },
      validator: (estphone == false)
          ? (value) {
              if (value!.isEmpty) {
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                return kInvalidEmailError;
              }
              return null;
            }
          : null,
      decoration: const InputDecoration(
        labelText: "Correo Electronico*",
        hintText: "Correo Electronico",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastnameCtl,
      onSaved: (newValue) => lastnameCtl.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        lastName = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Nombre*",
        hintText: "Introduzca su nombre",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstnameCtl,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNamelNullError);
        }
        firstName = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kFirstNamelNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Apellidos*",
        hintText: "Introduzca su apellidos",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  bool isDetailComplete() {
    if (_currentStep == 0) {
      if (telephoneCtl.text.isEmpty ||
          email!.isEmpty ||
          pays!.isEmpty ||
          !emailValidatorRegExp.hasMatch(email!)) {
        return false;
      } else {
        return true; //if all fields are not empty
      }
    } else if (_currentStep == 1) {
      codes = "$code1$code2$code2$code4";
      //check receiver fields
      if (code1!.isEmpty ||
          code2!.isEmpty ||
          code3!.isEmpty ||
          code4!.isEmpty ||
          codes!.length != 4) {
        return false;
      } else {
        return true;
      }
    } else if (_currentStep == 2) {
      if (lastName!.isEmpty ||
          firstName!.isEmpty ||
          civilite!.isEmpty ||
          address!.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else if (_currentStep == 3) {
      if (typepiece!.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  /* Widget buildMultipleCountry() {
    final countriesText = countries.map((country) => country.name).join(', ');
    final onTap = () async {
      final countries = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryPage(
                  isMultiSelection: true,
                  countries: List.of(this.countries),
                )),
      );

      if (countries == null) return;

      setState(() => this.countries = countries);
    };

    return buildCountryPicker(
      title: 'Select Countries',
      child: countries.isEmpty
          ? buildListTile(title: 'No Countries', onTap: onTap)
          : buildListTile(title: countriesText, onTap: onTap),
    );
  }
*/
  Widget buildListTile({
    required String title,
    required VoidCallback onTap,
    Widget? leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
              margin: EdgeInsets.zero,
              child: child,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ],
      );
  Widget buildCivilite(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: "Civilidad*",
              hintText: "Elige tu propia civilidad",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Bell.svg"),
              filled: true,
              //fillColor: Colors.blueAccent,
            ),
            //dropdownColor: Colors.blueAccent,
            value: civilite,
            onChanged: (String? newValue) {
              if (newValue!.isNotEmpty) {
                removeError(error: kcivilitelNullError);
              }
              setState(() {
                civiliteCtl.text = newValue;
              });
              //civilite = newValue;
            },
            validator: (value) {
              if (value == null) {
                return kcivilitelNullError;
              }
              return null;
            },
            items: const [
              DropdownMenuItem(child: Text("Masculin"), value: "Masculin"),
              DropdownMenuItem(child: Text("Féminim"), value: "Féminim"),
              // DropdownMenuItem(child: Text("Mademoiselle"), value: "Mdme"),
            ])
      ],
    );
  }

  Widget sucess() {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.06),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Felicitaions!",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.8,
          child: DefaultButton(
            text: "Sécurisez mon compte",
            press: () {
              //Navigator.pushReplacementNamed(context, SecuritePage.routeName);
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
