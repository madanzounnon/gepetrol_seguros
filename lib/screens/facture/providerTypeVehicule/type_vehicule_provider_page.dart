// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/typeVehicule.dart';
import '../../../services/api_service.dart';
import '../../../size_config.dart';
import '../../country/component/search_widget.dart';
import 'type_vehicule_listtile_widget.dart';

class TypeVehiculeProviderPage extends StatefulWidget {
  final List<TypeVehicule> bureaux;
  const TypeVehiculeProviderPage({
    Key? key,
    this.bureaux = const [],
  }) : super(key: key);

  @override
  _TypeVehiculeProviderPageState createState() =>
      _TypeVehiculeProviderPageState();
}

class _TypeVehiculeProviderPageState extends State<TypeVehiculeProviderPage> {
  String text = '';
  final ApiService apiService = ApiService();

  List<TypeVehicule> selectedbureaux = [];
  List<TypeVehicule> allbureaux = [];
  List<TypeVehicule> toutbureaux = [];
  List<TypeVehicule> toutbureau = [];

  @override
  void initState() {
    super.initState();
    selectedbureaux = widget.bureaux;
    getAllTypeVehicules();
  }

  bool _isLoading = true;
  getAllTypeVehicules() async {
    final res = await apiService.getAllTypeVehicule();
    if (res!.statusCode != null && res.statusCode == 200) {
      final maps = res.data["response"];
      setState(() {
        allbureaux = List.generate(maps.length, (i) {
          return TypeVehicule.fromMap(maps[i]);
        });
        toutbureau = getPrioritizedbureaux(allbureaux);
        print('allbureaux');
        print(allbureaux);
        toutbureaux = toutbureau.where(containsSearchText).toList();
        print("toutbureaux.toString()");
        print(toutbureaux.toString());
        _isLoading = false;
      });
    }
  }

  bool containsSearchText(TypeVehicule typeVehicule) {
    final name = typeVehicule.title;
    final textLower = text.toLowerCase();
    final bureauLower = name.toLowerCase();
    return bureauLower.contains(textLower);
  }

  List<TypeVehicule> getPrioritizedbureaux(List<TypeVehicule> bureaux) {
    final notSelectedbureaux = List.of(bureaux)
      ..removeWhere((typeVehicule) => selectedbureaux.contains(typeVehicule));
    return [
      ...List.of(selectedbureaux)..sort(Utils.ascendingSort),
      ...notSelectedbureaux,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: toutbureaux.map((typeVehicule) {
                      final isSelected = selectedbureaux.contains(typeVehicule);
                      return TypeVehiculeListTileWidget(
                        typeVehicule: typeVehicule,
                        isSelected: isSelected,
                        onSelectedTypeVehicule: selectTypeVehicule,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: Text('seleccione el tipo de Vector',
          style: TextStyle(
              color: Colors.white, fontSize: getProportionateScreenWidth(20))),
      actions: [
        IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => {Navigator.pop(context, true)},
            color: Colors.white),
        const SizedBox(width: 8),
      ],
      titleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: pPrimaryColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() {
            this.text = text;
            this.toutbureaux =
                this.toutbureau.where(containsSearchText).toList();
          }),
          hintText: 'Búsqueda de tipoVehicule',
        ),
      ),
    );
  }

  void selectTypeVehicule(TypeVehicule typeVehicule) {
    Navigator.pop(context, typeVehicule);
  }

  void submit() => Navigator.pop(context, selectedbureaux);
}

class Utils {
  static int ascendingSort(TypeVehicule c1, TypeVehicule c2) =>
      c1.title.compareTo(c2.title);
}
