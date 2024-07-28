// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/typeRemoque.dart';
import '../../../services/api_service.dart';
import '../../../size_config.dart';
import '../../country/component/search_widget.dart';
import 'type_remoque_listtile_widget.dart';

class TypeRemoqueProviderPage extends StatefulWidget {
  final List<TypeRemoque> bureaux;
  const TypeRemoqueProviderPage({
    Key? key,
    this.bureaux = const [],
  }) : super(key: key);

  @override
  _TypeRemoqueProviderPageState createState() =>
      _TypeRemoqueProviderPageState();
}

class _TypeRemoqueProviderPageState extends State<TypeRemoqueProviderPage> {
  String text = '';
  final ApiService apiService = ApiService();

  List<TypeRemoque> selectedbureaux = [];
  List<TypeRemoque> allbureaux = [];
  List<TypeRemoque> toutbureaux = [];
  List<TypeRemoque> toutbureau = [];

  @override
  void initState() {
    super.initState();
    selectedbureaux = widget.bureaux;
    getAllTypeRemoques();
  }

  bool _isLoading = true;
  getAllTypeRemoques() async {
    final res = await apiService.getAllTypeRemoque();
    if (res!.statusCode != null && res.statusCode == 200) {
      final maps = res.data["response"];
      setState(() {
        allbureaux = List.generate(maps.length, (i) {
          return TypeRemoque.fromMap(maps[i]);
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

  bool containsSearchText(TypeRemoque typeRemoque) {
    final name = typeRemoque.title;
    final textLower = text.toLowerCase();
    final bureauLower = name.toLowerCase();
    return bureauLower.contains(textLower);
  }

  List<TypeRemoque> getPrioritizedbureaux(List<TypeRemoque> bureaux) {
    final notSelectedbureaux = List.of(bureaux)
      ..removeWhere((typeRemoque) => selectedbureaux.contains(typeRemoque));
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
                    children: toutbureaux.map((typeRemoque) {
                      final isSelected = selectedbureaux.contains(typeRemoque);
                      return TypeRemoqueListTileWidget(
                        typeRemoque: typeRemoque,
                        isSelected: isSelected,
                        onSelectedTypeRemoque: selectTypeRemoque,
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
      title: Text('seleccione el tipo de Remolque',
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
          hintText: 'Búsqueda de tipoRemoque',
        ),
      ),
    );
  }

  void selectTypeRemoque(TypeRemoque typeRemoque) {
    Navigator.pop(context, typeRemoque);
  }

  void submit() => Navigator.pop(context, selectedbureaux);
}

class Utils {
  static int ascendingSort(TypeRemoque c1, TypeRemoque c2) =>
      c1.title.compareTo(c2.title);
}
