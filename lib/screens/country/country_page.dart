import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gepetrol_eguros/constants.dart';

import 'package:gepetrol_eguros/models/country.dart';

import 'component/country_listtile_widget.dart';
import 'component/search_widget.dart';
import 'provider/country_provider.dart';
import 'utils.dart';

class CountryPage extends StatefulWidget {
  final bool isMultiSelection;
  final List<Countryz> countries;
  //static String routeName ="country";
  const CountryPage({
    Key? key,
    this.isMultiSelection = false,
    this.countries = const [],
  }) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  String text = '';
  List<Countryz> selectedCountries = [];
  bool isNative = false;

  @override
  void initState() {
    super.initState();

    selectedCountries = widget.countries;
  }

  bool containsSearchText(Countryz country) {
    final name = isNative ? country.nativeName : country.name;
    final textLower = text.toLowerCase();
    final countryLower = name.toLowerCase();

    return countryLower.contains(textLower);
  }

  List<Countryz> getPrioritizedCountries(List<Countryz> countries) {
    final notSelectedCountries = List.of(countries)
      ..removeWhere((country) => selectedCountries.contains(country));

    return [
      ...List.of(selectedCountries)..sort(Utils.ascendingSort),
      ...notSelectedCountries,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context);
    final allCountries = getPrioritizedCountries(provider.countries);
    final countries = allCountries.where(containsSearchText).toList();

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: countries.map((country) {
                final isSelected = selectedCountries.contains(country);
                return CountryListTileWidget(
                  country: country,
                  isNative: isNative,
                  isSelected: isSelected,
                  onSelectedCountry: selectCountry,
                );
              }).toList(),
            ),
          ),
          buildSelectButton(context),
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    final label = widget.isMultiSelection ? 'Pays' : 'Pays';

    return AppBar(
      title:
          Text('selectionnez le $label', style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
            icon: Icon(isNative ? Icons.close : Icons.language),
            onPressed: () => setState(() => this.isNative = !isNative),
            color: Colors.white),
        const SizedBox(width: 8),
      ],
      titleTextStyle: TextStyle(color: Colors.white),
      backgroundColor: pPrimaryColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'recherche $label',
        ),
      ),
    );
  }

  Widget buildSelectButton(BuildContext context) {
    final label = widget.isMultiSelection
        ? 'Select ${selectedCountries.length} Countries'
        : 'Continue';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      color: Theme.of(context).primaryColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size.fromHeight(40),
          //primary: Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        onPressed: submit,
      ),
    );
  }

  void selectCountry(Countryz country) {
    if (widget.isMultiSelection) {
      final isSelected = selectedCountries.contains(country);
      setState(() => isSelected
          ? selectedCountries.remove(country)
          : selectedCountries.add(country));
    } else {
      Navigator.pop(context, country);
    }
  }

  void submit() => Navigator.pop(context, selectedCountries);
}
