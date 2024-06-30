// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/carburant.dart';
import '../../../models/categories.dart';
import '../../../services/api_service.dart';
import '../../../size_config.dart';
import '../../country/component/search_widget.dart';
import 'categorie_listtile_widget.dart';

class CategorieProviderPage extends StatefulWidget {
  final List<Categorie> bureaux;
  final int communeId;
  const CategorieProviderPage({
    Key? key,
    this.bureaux = const [],
    required this.communeId,
  }) : super(key: key);
  //static String routeName ="categorie";

  @override
  _CategorieProviderPageState createState() => _CategorieProviderPageState();
}

class _CategorieProviderPageState extends State<CategorieProviderPage> {
  String text = '';
  final ApiService apiService = ApiService();

  List<Categorie> selectedbureaux = [];
  List<Categorie> allbureaux = [];
  List<Categorie> toutbureaux = [];
  List<Categorie> toutbureau = [];

  @override
  void initState() {
    super.initState();
    selectedbureaux = widget.bureaux;
    getAllCategories(widget.communeId);
  }

  getAllCategories(int bureauId) async {
    final res = await apiService.getAllCategorie();
    if (res.statusCode != null && res.statusCode == 200) {
      final maps = res.data["data"];
      setState(() {
        allbureaux = List.generate(maps.length, (i) {
          return Categorie.fromMap(maps[i]);
        });
        toutbureau = getPrioritizedbureaux(allbureaux);
        print('allbureaux');
        print(allbureaux);
        toutbureaux = toutbureau.where(containsSearchText).toList();
        print("toutbureaux.toString()");
        print(toutbureaux.toString());
      });
    }
  }

  bool containsSearchText(Categorie categorie) {
    final name = categorie.title;
    final textLower = text.toLowerCase();
    final bureauLower = name.toLowerCase();
    return bureauLower.contains(textLower);
  }

  List<Categorie> getPrioritizedbureaux(List<Categorie> bureaux) {
    final notSelectedbureaux = List.of(bureaux)
      ..removeWhere((categorie) => selectedbureaux.contains(categorie));
    return [
      ...List.of(selectedbureaux)..sort(Utils.ascendingSort),
      ...notSelectedbureaux,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: toutbureaux.map((categorie) {
                final isSelected = selectedbureaux.contains(categorie);
                return CategorieListTileWidget(
                  categorie: categorie,
                  isSelected: isSelected,
                  onSelectedCategorie: selectCategorie,
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
      title: Text('selectionnez le categorie',
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
      backgroundColor: kSecondaryColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() {
            this.text = text;
            this.toutbureaux =
                this.toutbureau.where(containsSearchText).toList();
          }),
          hintText: 'Recherche de categorie',
        ),
      ),
    );
  }

  void selectCategorie(Categorie categorie) {
    Navigator.pop(context, categorie);
  }

  void submit() => Navigator.pop(context, selectedbureaux);
}

class Utils {
  static int ascendingSort(Categorie c1, Categorie c2) =>
      c1.title.compareTo(c2.title);
}
