import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gepetrol_eguros/helper/CustomInputFormatter.dart';
import 'package:gepetrol_eguros/models/user.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../components/custom_surfix_icon.dart';
import '../../components/form_error.dart';
import '../../components/secondary_button.dart';
import '../../constants.dart';
import '../../helper/form.dart';
import '../../helper/store.dart';
import '../../helper/utile.dart';
import '../../models/accessorie.dart';
import '../../models/api_error.dart';
import '../../models/carburant.dart';
import '../../models/categories.dart';
import '../../models/marque.dart';
import '../../models/power.dart';
import '../../models/typeRemoque.dart';
import '../../models/typeVehicule.dart';
import '../../services/api_service.dart';
import '../../size_config.dart';
import '../success_ecran/success_screen.dart';
import 'marque/marque_provider_page.dart';
import 'providerCaburant/carburant_provider_page.dart';
import 'providerCategories/categorie_provider_page.dart';
import 'providerPower/power_provider_page.dart';
import 'providerTypeRemoque/type_vehicule_provider_page.dart';
import 'providerTypeVehicule/type_vehicule_provider_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddFactureScreen extends StatefulWidget {
  const AddFactureScreen({super.key});
  static String routeName = "/addfacture";
  @override
  State<AddFactureScreen> createState() => _AddFactureScreenState();
}

class _AddFactureScreenState extends State<AddFactureScreen> {
  TextEditingController montant = TextEditingController();
  TextEditingController loyer = TextEditingController();
  TextEditingController montantRemise = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController firstnameCtl = TextEditingController();
  TextEditingController lastnameCtl = TextEditingController();
  TextEditingController telephoneCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController typeCategories = TextEditingController();
  TextEditingController typeVehiculeCtl = TextEditingController();
  TextEditingController caburantCtl = TextEditingController();
  TextEditingController marqueCtl = TextEditingController();
  TextEditingController categorie = TextEditingController();
  TextEditingController typeRemoqueT = TextEditingController();
  TextEditingController placeNumberCtl = TextEditingController();
  TextEditingController regisNumberCtl = TextEditingController();
  TextEditingController modeloCtl = TextEditingController();
  TextEditingController powerCtl = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: ' AA-###-AS',
      filter: {
        "#": RegExp(r'[0-9]'),
        "A": RegExp(r'[A-Z]'),
        "S": RegExp(r'[A-Z]?'),
      },
      type: MaskAutoCompletionType.lazy);

  final _formKey4 = GlobalKey<FormState>();
  String? email = '';
  String? firstName = '';
  String? lastName = '';
  final ApiService apiService = ApiService();
  List<String> factures = [];
  List<Accessorie> accessorie = [];
  final maskedController = MaskedTextController(mask: 'AA-000-AA');
  int typeVehiculeId = 0;
  int categorieId = 0;
  int marqueId = 0;
  int caburantId = 0;
  int typeRemoqueId = 0;
  int powerId = 0;
  int _currentStep = 0;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  List<int> accessoireValue = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  getUser() async {
    User users = await StoreAuth().getUser();
    print(users);
    firstnameCtl.text = users.first_name;
    lastnameCtl.text = users.last_name;
    emailCtl.text = users.email;
    telephoneCtl.text = users.phone!;
    setState(() {
      userId = users.id;
    });
  }

  final List<String?> errors = [];

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  List<String>? userInfos;
  int total = 0;
  int userId = 0;
  @override
  void initState() {
    super.initState();
    total = 0;
    getAccessories();
    getUser();
  }

  Future<void> getAccessories() async {
    //Utile.loarder(context);
    final response = await apiService.getAccessories();
    print(response!.data["response"]);
    if (response.statusCode == 200) {
      final maps = response.data["response"];
      //setState(() {
      accessorie = List.generate(maps.length, (i) {
        return Accessorie.fromMap(maps[i]);
        // });
      });
      // Navigator.of(context).pop();
    } else {
      ApiError apiError = ApiError.fromMap(response.data.response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${apiError.message}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  Future<void> addFacture() async {
    print("ssssssssssssssssssss");
    print(_formKey1.currentState!.validate());
    print(_formKey2.currentState!.validate());
    if (_formKey1.currentState!.validate() &&
        _formKey2.currentState!.validate()) {
      accessoireValue.clear();
      List.generate(accessorie.length, (i) {
        if (accessorie[i].isChecked == true) {
          accessoireValue.add(accessorie[i].id);
        }
      });

      Map<String, dynamic> factureMap = {
        "user_id": (userId == 0) ? null : userId,
        "fuel_type": caburantId,
        'brands': marqueId,
        "power": powerId,
        "type_car": typeVehiculeId,
        "category": categorieId,
        "place_number": placeNumberCtl.text,
        "trailer": typeRemoqueId,
        "regis_number": regisNumberCtl.text,
        "model": modeloCtl.text,
        "first_name": firstnameCtl.text,
        "last_name": lastnameCtl.text,
        "email": emailCtl.text,
        "phone": telephoneCtl.text,
        "accessory": accessoireValue
      };
      //Utile.loarder(context);
      Response res = await apiService.addFacture(factureMap);
      if (res.statusCode == 200 && res.data["success"]) {
        // Utile.messageSuccess(context, res.data["message"]);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              redirectTo: "/factures",
              btnText: "Lista de mis Facturas",
              message:
                  "Información de la Factura \n Precio Inicial = ${res.data['response']['initial_price']} F CFA \n Precio Accesorios = ${res.data['response']['accessories_price']} F CFA \n Precio Atestación = ${res.data['response']['attestation_price']} F CFA  \n Sub-total = ${res.data['response']['sub_total']} F CFA \n IVA=${res.data['response']['vat']} F CFA\n Total = ${res.data['response']['total']} F CFA",
            ),
          ),
        );
      } else {
        ApiError apiError = ApiError.fromMap(res.data);
        Utile.messageErro(context, '${apiError.message}');
      }
    }
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  validestape(int current) {
    bool estVal = false;
    switch (current) {
      case 0:
        estVal = _formKey1.currentState!.validate();
        break;
      case 1:
        estVal = _formKey2.currentState!.validate();
        break;
      case 2:
        estVal = _formKey3.currentState!.validate();
        break;
      case 3:
        estVal = true;
        break;
    }
    return estVal;
  }

  bool isDetailComplete() {
    return false;
  }

  continued() {
    final islast = _currentStep == 3;
    bool isValid = validestape(_currentStep);
    if (isValid) {
      print("isValidisValidisValid");
      if (islast) {
        print("z2zz2z22z2z22z2z2z22z");
        addFacture();
        //total = int.parse(montant.text.trim());
      } else {
        _currentStep < 3 ? setState(() => _currentStep += 1) : _currentStep;
      }
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : _currentStep;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(children: [
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
                    return Column(
                      children: [
                        if (_currentStep > 0)
                          SecondaryButton(
                            width: 100,
                            textcolor: Colors.white,
                            text: 'Anterior'.toLowerCase(),
                            backcolor: kPrimaryColor,
                            press: details.onStepCancel,
                          ),
                        if (_currentStep > 0)
                          SizedBox(height: getProportionateScreenWidth(10)),
                        SecondaryButton(
                          width: 100,
                          textcolor: Colors.white,
                          text: _currentStep == 3
                              ? 'Facturar'.toUpperCase()
                              : 'Siguiente'.toUpperCase(),
                          backcolor: pPrimaryColor,
                          press: details.onStepContinue,
                        ),
                      ],
                    );
                  },
                  steps: <Step>[
                Step(
                  title: const Text('01.', maxLines: 1),
                  content: Form(
                    key: _formKey1,
                    child: Column(
                      children: [
                        // Text(
                        //   "Créer une Facture",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: getProportionateScreenWidth(20),
                        //     //color: pPrimaryColor,
                        //     fontWeight: FontWeight.w900,
                        //   ),
                        // ),
                        Text(
                          "Datos del vehículo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: pPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Por favor, completa los siguientes datos. ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            // color: pPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildSingleMarque(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        inputForm(
                            name: 'modelo',
                            controller: modeloCtl,
                            labeltext: "¿Y el modelo? ",
                            validInput: true,
                            estreadonly: false),
                        // inputForm(
                        //     name: 'regisNumberCtl',
                        //     controller: regisNumberCtl,
                        //     labeltext: "¿Cuál es la matrícula de tu coche? *",
                        //     hintText: "ej. AN - 252 - AZ",
                        //     validInput: true,
                        //     estreadonly: false,
                        //     inputFormatters: [maskFormatter],
                        //     regExp: RegExp(
                        //         r'^[A-Z]{2}\s*-\s*[0-9]{3}\s*-\s*[A-Z]{1,2}$'),
                        //     regExpmessage:
                        //         "Formato no válido.Formato esperado: XX-000-XX"),
                        TextFormField(
                          controller: regisNumberCtl,
                          inputFormatters: [maskFormatter],
                          decoration: const InputDecoration(
                            labelText: "¿Cuál es la matrícula de tu coche? *",
                            hintText: "ej. AN-252-AZ",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            //suffixIcon:CustomSurffixIcon(svgIcon: widget.urlsvgicon),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, la matrícula';
                            }
                            if (!RegExp(
                                    r'^[A-Z]{2}\s*-\s*[0-9]{3}\s*-\s*[A-Z]{1,2}$')
                                .hasMatch(value.trim())) {
                              print(value);
                              return 'Formato no válido.Formato esperado: XX-000-XX';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        inputForm(
                          name: 'placeNumberCtl',
                          type: TextInputType.number,
                          controller: placeNumberCtl,
                          labeltext: "¿Cuántas puertas tiene tu coche? *",
                          hintText: "ej. 1",
                          validInput: true,
                          estreadonly: false,
                        ),
                        buildSingleCategories(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('02', maxLines: 1),
                  content: Form(
                    key: _formKey2,
                    child: Column(
                      children: [
                        Text(
                          "Datos del vehículo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: pPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Por favor, completa los siguientes datos. ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            // color: pPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildSingleTypeVehicule(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        buildSingleCaburant(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        buildSinglePower(caburantId),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        buildSingleTypeRemoque(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 1,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: new Text('03'),
                  content: Form(
                      key: _formKey3,
                      child: Column(
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Container(
                                //   alignment: Alignment.center,
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal:
                                //           getProportionateScreenWidth(50)),
                                //   child: SvgPicture.asset(
                                //     'assets/images/logo.svg',
                                //     height: getProportionateScreenHeight(100),
                                //     width: getProportionateScreenHeight(100),
                                //   ),
                                // ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                const Text("Datos del Conductor",
                                    textAlign: TextAlign.center),
                              ]),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          buildFirstNameFormField(),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          buildLastNameFormField(),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          IntlPhoneField(
                            controller: telephoneCtl,
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
                            onSaved: (newValue) =>
                                telephoneCtl.text = newValue!.number,
                            showCountryFlag: true,
                            dropdownIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                            showDropdownIcon: false,
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
                          buildEmailFormField(),
                          FormError(errors: errors),
                          SizedBox(height: getProportionateScreenHeight(20)),
                        ],
                      )),
                  isActive: _currentStep >= 2,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('04', maxLines: 1),
                  content: Form(
                      key: _formKey4,
                      child: Column(children: [
                        Text(
                          "Accesorios Opcional",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: pPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("¿Quieres incluir algún accesorios?"),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Column(
                          children: List.generate(accessorie.length, (index) {
                            return CheckboxListTile(
                              title: Text(
                                  '${accessorie[index].title}(${accessorie[index].value}F)'),
                              value: accessorie[index].isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  accessorie[index].isChecked = value ?? false;
                                });
                              },
                            );
                          }),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ])),
                  isActive: _currentStep >= 3,
                  state: _currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ]))
        ]));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(
        "Crear una factura",
        style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
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

  Widget buildSingleCategories() {
    onTap() async {
      Categorie categories = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategorieProviderPage()),
      );
      if (categorie == null) return;
      setState(() {
        categorie.text = "${categories.code_category} [${categories.title}]";
        categorieId = categories.id;
      });
    }

    return buildCategoriesFormField(onTap);
  }

  TextFormField buildCategoriesFormField(VoidCallback onTap) {
    return TextFormField(
      controller: categorie,
      onTap: onTap,
      enabled: true,
      onSaved: (newValue) => categorie.text = newValue!,
      onChanged: (value) {
        setState(() {
          categorie.text = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Seleccione un tipo de vehículo';
        }
        return null;
      },
      readOnly: true,
      decoration: const InputDecoration(
          labelText: "¿Qué uso das al coche?*",
          hintText: "Seleccionar",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.chevron_right)),
    );
  }

  Widget buildSingleMarque() {
    onTap() async {
      Marque marque = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MarqueProviderPage()),
      );
      if (categorie == null) return;
      setState(() {
        marqueCtl.text = "${marque.title}";
        marqueId = marque.id;
      });
    }

    return buildMarqueFormField(onTap);
  }

  TextFormField buildMarqueFormField(VoidCallback onTap) {
    return TextFormField(
      controller: marqueCtl,
      onTap: onTap,
      enabled: true,
      onSaved: (newValue) => marqueCtl.text = newValue!,
      onChanged: (value) {
        setState(() {
          marqueCtl.text = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, seleccione una marca';
        }
        return null;
      },
      readOnly: true,
      decoration: const InputDecoration(
          labelText: "Marca",
          hintText: "seleccione una marca",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.chevron_right)),
    );
  }

  Widget buildSingleCaburant() {
    onTap() async {
      Caburant caburant = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CaburantProviderPage()),
      );
      if (caburant == null) return;
      setState(() {
        caburantCtl.text = "${caburant.code} [${caburant.title}]";
        caburantId = caburant.id;
      });
      caburantCtl.text = "${caburant.code} [${caburant.title}]";
    }

    return buildCaburantFormField(onTap);
  }

  TextFormField buildCaburantFormField(VoidCallback onTap) {
    return TextFormField(
      controller: caburantCtl,
      onTap: onTap,
      onSaved: (newValue) => caburantCtl.text = newValue!,
      onChanged: (value) {
        setState(() {
          print(value);
          caburantCtl.text = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, seleccionar';
        }
        return null;
      },
      readOnly: true,
      decoration: const InputDecoration(
          labelText: "¿Qué combustible usa tu coche?",
          hintText: "Por favor, seleccionar",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.chevron_right)),
    );
  }

  Widget buildSingleTypeRemoque() {
    onTap() async {
      TypeRemoque typeRemoque = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TypeRemoqueProviderPage()),
      );
      if (typeRemoque == null) return;
      setState(() {
        typeRemoqueT.text = "${typeRemoque.title}]";
        typeRemoqueId = typeRemoque.id;
      });
      typeRemoqueT.text = "${typeRemoque.title}";
    }

    return buildTypeRemoqueFormField(onTap);
  }

  TextFormField buildTypeRemoqueFormField(VoidCallback onTap) {
    return TextFormField(
      controller: typeRemoqueT,
      onTap: onTap,
      onSaved: (newValue) => typeRemoqueT.text = newValue!,
      onChanged: (value) {
        setState(() {
          print(value);
          typeRemoqueT.text = value;
          //produit.agenceName = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, seleccione un tipo';
        }
        return null;
      },
      readOnly: true,
      decoration: const InputDecoration(
          labelText: "Tipo de Remolque",
          hintText: "Por favor, seleccione un tipo",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.chevron_right)),
    );
  }

  Widget buildSingleTypeVehicule() {
    onTap() async {
      TypeVehicule typeVehicule = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const TypeVehiculeProviderPage()),
      );
      if (typeVehicule == null) return;
      setState(() {
        typeVehiculeCtl.text = "${typeVehicule.title}";
        typeVehiculeId = typeVehicule.id;
      });
      typeVehiculeCtl.text = "${typeVehicule.title}";
    }

    return buildTypeVehiculeFormField(onTap);
  }

  TextFormField buildTypeVehiculeFormField(VoidCallback onTap) {
    return TextFormField(
      controller: typeVehiculeCtl,
      onTap: onTap,
      onSaved: (newValue) => typeVehiculeCtl.text = newValue!,
      onChanged: (value) {
        setState(() {
          print(value);
          typeVehiculeCtl.text = value;
          //produit.agenceName = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'por favor seleccione';
        }
        return null;
      },
      readOnly: true,
      decoration: const InputDecoration(
          labelText: "Tipo de Coche*",
          hintText: "Tipo de Coche*",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.chevron_right)),
    );
  }

  Widget buildSinglePower(int carburantId) {
    onTap() async {
      if (carburantId > 0) {
        Power powers = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PowerProviderPage(
                    carburantId: carburantId,
                  )),
        );
        if (powers == null) return;
        setState(() {
          powerCtl.text = "${powers.min_power} CV - ${powers.max_power} ";
          powerId = powers.id;
        });
      } else {
        Utile.messageErro(context, "Seleccione primero el tipo de combustible");
      }
    }

    return buildPowerFormField(onTap);
  }

  TextFormField buildPowerFormField(VoidCallback onTap) {
    return TextFormField(
      controller: powerCtl,
      onTap: onTap,
      enabled: true,
      onSaved: (newValue) => powerCtl.text = newValue!,
      onChanged: (value) {
        setState(() {
          print(value);
          powerCtl.text = value;
          //produit.agenceName = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor seleccione una potencia';
        }
        return null;
      },
      readOnly: true,
      decoration: const InputDecoration(
          labelText: "¿Conoces la potencia de tu coche en",
          hintText: "Seleccionar",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.chevron_right)),
    );
  }
}

class SpecialMaskTextInputFormatter extends MaskTextInputFormatter {
  static String maskA = "S.####";
  static String maskB = "S.######";

  SpecialMaskTextInputFormatter({String? initialText})
      : super(
            mask: maskA,
            filter: {"#": RegExp('[0-9]'), "S": RegExp('[AB]')},
            initialText: initialText);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith("A")) {
      if (getMask() != maskA) {
        updateMask(mask: maskA);
      }
    } else {
      if (getMask() != maskB) {
        updateMask(mask: maskB);
      }
    }
    return super.formatEditUpdate(oldValue, newValue);
  }
}
