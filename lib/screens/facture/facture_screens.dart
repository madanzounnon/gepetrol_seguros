import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/screens/facture/card_facture.dart';

import '../../components/default_button.dart';
import '../../helper/form.dart';
import '../../helper/utile.dart';
import '../../models/facture.dart';
import '../../services/api_service.dart';
import '../../size_config.dart';

class FactureScreen extends StatefulWidget {
  const FactureScreen({super.key});
  static String routeName = "/factures";
  @override
  State<FactureScreen> createState() => _FactureScreenState();
}

class _FactureScreenState extends State<FactureScreen> {
  List<Facture> Factures = [];
  ApiService apiService = ApiService();
  final TextEditingController _FactureController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController titulosController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  Utile utile = Utile();
  @override
  void initState() {
    getFactureById();
    super.initState();
  }

  Future<void> getFactureById() async {
    final res = await apiService.getFactureById();
    if (res.statusCode == 200) {
      final maps = res.data["data"]["data"];
      setState(() {
        Factures = List.generate(maps.length, (i) {
          return Facture.fromMap(maps[i]);
        });
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Factures.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(15)),
                          child: Factures.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Column(children: [
                                  ListView.builder(
                                    itemCount: Factures.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        CartFacture(
                                            facture: Factures[index],
                                            addRefacture: _showForm),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(45),
                                  )
                                ]),
                        ),
                      )
                    : Utile.isEmpty("Vous n'avez pas encore d'factures"),
              ));
  }

  void _showForm(Facture Facture) async {
    _FactureController.text = Facture.id.toString();
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
                    Text("Se réabonner à ${Facture.code}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getProportionateScreenWidth(18))),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    inputForm(
                        name: "Titulos",
                        controller: titulosController,
                        estreadonly: false,
                        type: TextInputType.multiline,
                        maxLines: 5,
                        hintText: "Títulos",
                        labeltext: "Títulos"),
                    inputForm(
                      type: TextInputType.number,
                      name: "Descripción",
                      controller: descripcionController,
                      labeltext: "Descripción",
                      onChanged: (value) {
                        setState(() {
                          titulosController.text = (Facture.total).toString();
                        });
                      },
                    ),
                    DefaultButton(press: () async {}, text: "Se réabonner")
                  ],
                ),
              ),
            ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        "Mes Factures",
        style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
