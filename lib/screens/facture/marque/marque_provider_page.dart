// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/marque.dart';
import '../../../services/api_service.dart';
import '../../../size_config.dart';
import '../../country/component/search_widget.dart';
import 'marque_listtile_widget.dart';

class MarqueProviderPage extends StatefulWidget {
  final List<Marque> bureaux;
  const MarqueProviderPage({
    Key? key,
    this.bureaux = const [],
  }) : super(key: key);

  @override
  _MarqueProviderPageState createState() => _MarqueProviderPageState();
}

class _MarqueProviderPageState extends State<MarqueProviderPage> {
  String text = '';
  final ApiService apiService = ApiService();

  List<Marque> selectedbureaux = [];
  List<Marque> allbureaux = [];
  List<Marque> toutbureaux = [];
  List<Marque> toutbureau = [];

  @override
  void initState() {
    super.initState();
    selectedbureaux = widget.bureaux;
    getAllMarques();
  }

  getAllMarques() async {
    final res = await apiService.getAllMarque();
    if (res!.statusCode != null && res.statusCode == 200) {
      final maps = res.data["data"];
      setState(() {
        allbureaux = List.generate(maps.length, (i) {
          return Marque.fromMap(maps[i]);
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

  bool containsSearchText(Marque marque) {
    final name = marque.title;
    final textLower = text.toLowerCase();
    final bureauLower = name.toLowerCase();
    return bureauLower.contains(textLower);
  }

  List<Marque> getPrioritizedbureaux(List<Marque> bureaux) {
    final notSelectedbureaux = List.of(bureaux)
      ..removeWhere((marque) => selectedbureaux.contains(marque));
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
              children: toutbureaux.map((marque) {
                final isSelected = selectedbureaux.contains(marque);
                return MarqueListTileWidget(
                  marque: marque,
                  isSelected: isSelected,
                  onSelectedMarque: selectMarque,
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
      title: Text('selectionnez le marque',
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
          hintText: 'Recherche de marque',
        ),
      ),
    );
  }

  void selectMarque(Marque marque) {
    Navigator.pop(context, marque);
  }

  void submit() => Navigator.pop(context, selectedbureaux);
}

class Utils {
  static int ascendingSort(Marque c1, Marque c2) =>
      c1.title.compareTo(c2.title);
}
