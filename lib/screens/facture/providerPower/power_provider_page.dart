// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/power.dart';
import '../../../services/api_service.dart';
import '../../../size_config.dart';
import '../../country/component/search_widget.dart';
import 'power_listtile_widget.dart';

class PowerProviderPage extends StatefulWidget {
  PowerProviderPage({
    super.key,
    this.powers = const [],
    required this.carburantId,
  });

  final List<Power> powers;
  int carburantId;

  @override
  _PowerProviderPageState createState() => _PowerProviderPageState();
}

class _PowerProviderPageState extends State<PowerProviderPage> {
  List<Power> allpowers = [];
  final ApiService apiService = ApiService();
  List<Power> selectedpowers = [];
  String text = '';
  List<Power> toutpower = [];
  List<Power> toutpowers = [];

  @override
  void initState() {
    super.initState();
    selectedpowers = widget.powers;
    getAllPowers(widget.carburantId);
  }

  getAllPowers(int bureauId) async {
    final res = await apiService.getPowerByCaburant(bureauId);
    print(res);
    if (res!.statusCode != null && res.statusCode == 200) {
      final maps = res.data["response"];
      setState(() {
        allpowers = List.generate(maps.length, (i) {
          return Power.fromMap(maps[i]);
        });
        toutpower = getPrioritizedpowers(allpowers);
        toutpowers = toutpower.where(containsSearchText).toList();
      });
    }
  }

  bool containsSearchText(Power power) {
    final name = power.min_power;
    final textLower = text.toLowerCase();
    final powerLower = name.toString().toLowerCase();
    return powerLower.contains(textLower);
  }

  List<Power> getPrioritizedpowers(List<Power> powers) {
    final notSelectedpowers = List.of(powers)
      ..removeWhere((power) => selectedpowers.contains(power));

    return [
      ...List.of(selectedpowers)..sort(Utils.ascendingSort),
      ...notSelectedpowers,
    ];
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: Text('Seleccionado potencia',
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
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Conoces la potencia de tu coche en',
        ),
      ),
    );
  }

  void selectPower(Power power) {
    Navigator.pop(context, power);
  }

  void submit() => Navigator.pop(context, selectedpowers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: (allpowers.isEmpty)
          ? const Center(child: Text("No hay energía para combustible"))
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: toutpowers.map((power) {
                      final isSelected = selectedpowers.contains(power);
                      return PowerListTileWidget(
                        power: power,
                        isSelected: isSelected,
                        onSelectedPower: selectPower,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}

class Utils {
  static int ascendingSort(Power c1, Power c2) =>
      c1.min_power.compareTo(c2.min_power);
}
