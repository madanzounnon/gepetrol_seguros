import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/models/api_error.dart';

import '../../components/default_button.dart';
import '../../constants.dart';
import '../../helper/form.dart';
import '../../helper/utile.dart';
import '../../models/Plainte.dart';
import '../../services/api_service.dart';
import '../../size_config.dart';
import 'plainte_card.dart';

class PlainteScreen extends StatefulWidget {
  static String routeName = "/plaintes";
  const PlainteScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PlainteScreenState createState() => _PlainteScreenState();
}

class _PlainteScreenState extends State<PlainteScreen> {
  bool _isLoading = true;
  List<Plainte> plaintes = [];
  ApiService apiService = ApiService();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController titulosController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getAllPlainteByClient();
  }

  Future<void> getAllPlainteByClient() async {
    final res = await apiService.getAllPlainteByClient();
    if (res.statusCode == 200) {
      final maps = res.data["complaints"];
      setState(() {
        plaintes = List.generate(maps.length, (i) {
          return Plainte.fromMap(maps[i]);
        });
        _isLoading = false;
      });
    }
  }

  Future<void> addPlainte() async {
    Map<String, dynamic> plaintMap = {
      "title": titulosController.text.trim(),
      'description': descripcionController.text.trim(),
    };
    if (_formKey.currentState!.validate()) {
      //Utile.loarder(context);
      Response res = await apiService.addPlainte(plaintMap);
      if (res.statusCode == 200 && res.data["success"]) {
        Navigator.of(context).pop();
        Utile.messageSuccess(context, res.data["message"]);
        getAllPlainteByClient();
      } else {
        ApiError apiError = ApiError.fromMap(res.data);
        Utile.messageErro(context, '${apiError.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: (plaintes.isNotEmpty)
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(15)),
                        child: Column(children: [
                          ListView.builder(
                            itemCount: plaintes.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                PlainteCard(plainte: plaintes[index]),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(45),
                          )
                        ]),
                      ))
                  : Utile.isEmpty("No tiene ninguna queja pendiente")),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            _showForm();
          },
          label: const Text("Enviar un Nuevo Ticket"),
          icon: const Icon(Icons.add, color: Colors.white)),
      //const Text("Envoyer une plainte")),
    );
  }

  void _showForm() async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
                //Cela empêchera le clavier logiciel de couvrir les champs de texte
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    getProportionateScreenHeight(100),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text("Enviar una queja",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getProportionateScreenWidth(18))),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    inputForm(
                        name: "Titulos",
                        controller: titulosController,
                        validInput: true,
                        estreadonly: false,
                        hintText: "Títulos",
                        labeltext: "Títulos"),
                    inputForm(
                      type: TextInputType.multiline,
                      maxLines: 7,
                      minLines: 7,
                      name: "Descripcion",
                      controller: descripcionController,
                      labeltext: "Descripción",
                      hintText: '',
                      validInput: true,
                      onChanged: (value) {},
                    ),
                    DefaultButton(
                        press: () async {
                          addPlainte();
                        },
                        text: "Enviar un Nuevo Ticket")
                  ],
                ),
              ),
            ));
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Text(
      "Lista de denuncias",
      style: TextStyle(
          fontSize: getProportionateScreenWidth(20),
          fontWeight: FontWeight.bold),
    ),
  );
}
