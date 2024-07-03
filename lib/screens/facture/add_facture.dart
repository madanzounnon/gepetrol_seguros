import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/secondary_button.dart';
import '../../constants.dart';
import '../../helper/form.dart';
import '../../helper/utile.dart';
import '../../models/accessorie.dart';
import '../../models/api_error.dart';
import '../../models/accessorie.dart';
import '../../models/carburant.dart';
import '../../models/categories.dart';
import '../../models/marque.dart';
import '../../models/power.dart';
import '../../models/typeRemoque.dart';
import '../../models/typeVehicule.dart';
import '../../services/api_service.dart';
import '../../size_config.dart';
import 'marque/marque_provider_page.dart';
import 'providerCaburant/carburant_provider_page.dart';
import 'providerCategories/categorie_provider_page.dart';
import 'providerPower/power_provider_page.dart';
import 'providerTypeRemoque/type_vehicule_provider_page.dart';
import 'providerTypeVehicule/type_vehicule_provider_page.dart';

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
  TextEditingController email = TextEditingController();
  TextEditingController lastNameCtl = TextEditingController();

  TextEditingController firstNameCtl = TextEditingController();
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

  final ApiService apiService = ApiService();
  List<String> factures = [];
  List<Accessorie> accessorie = [];

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

  List<String>? userInfos;
  int total = 0;
  @override
  void initState() {
    total = 0;
    getAccessories();
    super.initState();
  }

  Future<void> getAccessories() async {
    Utile.loarder(context);
    final response = await apiService.getAccessories();
    print(response!.data["response"]);
    if (response.statusCode == 200) {
      final maps = response.data["response"];
      setState(() {
        accessorie = List.generate(maps.length, (i) {
          return Accessorie.fromMap(maps[i]);
        });
      });
      Navigator.of(context).pop();
    } else {
      ApiError apiError = ApiError.fromMap(response.data.response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${apiError.message}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  Future<void> addFacture(response, redirectTo, btnText) async {
    if (_formKey1.currentState!.validate() &&
        _formKey1.currentState!.validate()) {
      Map<String, dynamic> factureMap = {
        "fuel_type": caburantId,
        'brands': marqueId,
        "power": powerId,
        "type_car": typeVehiculeId,
        "category": categorieId,
        "place_number": placeNumberCtl.text,
        "trailer": typeRemoqueId,
        "regis_number": regisNumberCtl.text,
        "model": modeloCtl.text,
        "first_name": firstNameCtl.text,
        "last_name": lastNameCtl.text,
        "email": email.text,
        "phone": phoneCtl.text,
      };
      //Utile.loarder(context);
      Response res = await apiService.addFacture(factureMap);
      if (res.statusCode == 201) {
        Utile.messageSuccess(context, res.data["message"]);
      } else {
        Navigator.of(context).pop();
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
    }
    return estVal;
  }

  bool isDetailComplete() {
    return false;
  }

  continued() {
    final islast = _currentStep == 2;
    bool isValid = validestape(_currentStep);
    if (isValid) {
      if (islast) {
        setState(() {
          total = int.parse(montant.text.trim());
        });
      } else {
        _currentStep < 2 ? setState(() => _currentStep += 1) : _currentStep;
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
                            text: 'Précédent'.toLowerCase(),
                            backcolor: kPrimaryColor,
                            press: details.onStepCancel,
                          ),
                        if (_currentStep > 0)
                          SizedBox(height: getProportionateScreenWidth(10)),
                        SecondaryButton(
                          width: 100,
                          textcolor: Colors.white,
                          text: _currentStep == 2
                              ? 'Faire un facture'.toUpperCase()
                              : 'Suivant'.toUpperCase(),
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
                        inputForm(
                          name: 'regisNumberCtl',
                          controller: regisNumberCtl,
                          labeltext: "¿Cuál es la matrícula de tu coche? *",
                          hintText: "ej. AN - 252 - AZ",
                          validInput: true,
                          estreadonly: false,
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
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('03', maxLines: 1),
                  content: Form(
                      key: _formKey3,
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
                        Column(
                          children: List.generate(accessorie.length, (index) {
                            return CheckboxListTile(
                              title: Text('${accessorie[index].title}'),
                              value: accessorie[index].isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  accessorie[index].isChecked = value ?? false;
                                });
                              },
                            );
                          }),
                        ),
                      ])),
                  isActive: _currentStep >= 1,
                  state: _currentStep >= 2
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
        "Créer une Facture",
        style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold),
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
