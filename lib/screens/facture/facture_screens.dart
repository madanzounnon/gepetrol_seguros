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
      final maps = res.data["response"];

      setState(() {
        print('mapsmapsmapsmapsmapsmapsmaps');
        print(maps);
        Factures = List.generate(maps.length, (i) {
          return Facture.fromMap(maps[i]);
        });
        _isLoading = false;
      });
    }
  }

  Future<void> sendMail(int? id) async {
    final res = await apiService.sendEmail(id!);
    if (res.statusCode == 200) {
      Utile.messageSuccess(context, res.data["message"]);
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
                                      context: context,
                                      //sendMail:sendMail(Factures[index].id)
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(45),
                                  )
                                ]),
                        ),
                      )
                    : Utile.isEmpty("Usted no tiene facturas todavía"),
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
