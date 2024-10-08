// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/carburant.dart';
import '../../../services/api_service.dart';
import '../../../size_config.dart';
import '../../country/component/search_widget.dart';
import 'carburant_listtile_widget.dart';

class CaburantProviderPage extends StatefulWidget {
  final List<Caburant> bureaux;
  const CaburantProviderPage({
    Key? key,
    this.bureaux = const [],
  }) : super(key: key);
  //static String routeName ="caburant";

  @override
  _CaburantProviderPageState createState() => _CaburantProviderPageState();
}

class _CaburantProviderPageState extends State<CaburantProviderPage> {
  String text = '';
  final ApiService apiService = ApiService();
  bool _isLoading = true;

  List<Caburant> selectedbureaux = [];
  List<Caburant> allbureaux = [];
  List<Caburant> toutbureaux = [];
  List<Caburant> toutbureau = [];

  @override
  void initState() {
    super.initState();
    selectedbureaux = widget.bureaux;
    getAllCaburants();
  }

  getAllCaburants() async {
    final res = await apiService.getAllCaburant();
    if (res!.statusCode != null && res.statusCode == 200) {
      final maps = res.data["response"];
      setState(() {
        allbureaux = List.generate(maps.length, (i) {
          return Caburant.fromMap(maps[i]);
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

  bool containsSearchText(Caburant caburant) {
    final name = caburant.title;
    final textLower = text.toLowerCase();
    final bureauLower = name.toLowerCase();
    return bureauLower.contains(textLower);
  }

  List<Caburant> getPrioritizedbureaux(List<Caburant> bureaux) {
    final notSelectedbureaux = List.of(bureaux)
      ..removeWhere((caburant) => selectedbureaux.contains(caburant));
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
                    children: toutbureaux.map((caburant) {
                      final isSelected = selectedbureaux.contains(caburant);
                      return CaburantListTileWidget(
                        caburant: caburant,
                        isSelected: isSelected,
                        onSelectedCaburant: selectCaburant,
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
      title: Text('seleccione el caburant',
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
          hintText: 'Búsqueda de caburant',
        ),
      ),
    );
  }

  void selectCaburant(Caburant caburant) {
    Navigator.pop(context, caburant);
  }

  void submit() => Navigator.pop(context, selectedbureaux);
}

class Utils {
  static int ascendingSort(Caburant c1, Caburant c2) =>
      c1.title.compareTo(c2.title);
}
