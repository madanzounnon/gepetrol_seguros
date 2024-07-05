import 'package:flutter/material.dart';

import '../../constants.dart';
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

  @override
  void initState() {
    super.initState();
    getAllDemanadeByAbonne();
  }

  Future<void> getAllDemanadeByAbonne() async {
    final res = await apiService.getAllPlainteByClient();
    if (res.statusCode == 200) {
      final maps = res.data["data"]["data"];
      setState(() {
        plaintes = List.generate(maps.length, (i) {
          return Plainte.fromMap(maps[i]);
        });
        _isLoading = false;
      });
      print(plaintes.toString());
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
            _showmenu();
          },
          label: const Text("Enviar una queja"),
          icon: const Icon(Icons.add, color: Colors.white)),
      //const Text("Envoyer une plainte")),
    );
  }

  _showmenu() async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        //backgroundColor: Colors.transparent,
        builder: (_) => Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              // this will prevent the soft keyboard from covering the text fields
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  getProportionateScreenHeight(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text(
                  "Selectionnez le type de plainte",
                  style: TextStyle(fontSize: getProportionateScreenWidth(17)),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),

                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                // GestureDetector(
                //   onTap: () => {
                //     Navigator.pushNamed(
                //       context,
                //       PlaintePartageScreen.routeName,
                //     ),
                //   },
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: Color.fromARGB(255, 231, 231, 231),
                //         maxRadius: 23,
                //         child: Icon(Icons.edit_document,
                //             size: getProportionateScreenWidth(27),
                //             color: kPrimaryColor),
                //       ),
                //       SizedBox(width: getProportionateScreenWidth(20)),
                //       Expanded(
                //         child: Text('Plainte de partage',
                //             maxLines: 1,
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w800,
                //                 color: Colors.black,
                //                 fontSize: getProportionateScreenWidth(19))),
                //       ),
                //       Icon(Icons.chevron_right,
                //           size: getProportionateScreenWidth(25),
                //           color: Colors.black),
                //     ],
                //   ),
                // ),
              ],
            )));
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Text(
      "Liste des plaintes",
      style: TextStyle(
          fontSize: getProportionateScreenWidth(20),
          fontWeight: FontWeight.bold),
    ),
  );
}
