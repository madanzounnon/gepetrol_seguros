import 'package:gepetrol_eguros/models/country.dart';

class Utils {
  static int ascendingSort(Country c1, Country c2) =>
      c1.name.compareTo(c2.name);
}
