import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/services/api_service.dart';
import 'package:gepetrol_eguros/size_config.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartClient extends StatefulWidget {
  ChartClient({Key? key}) : super(key: key);

  @override
  State<ChartClient> createState() => _ChartClientState();
}

class _ChartClientState extends State<ChartClient> {
  bool _isLoading = false;
  Map<String, double> dataMap = {};
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    getSatat();
  }

  Future<void> getSatat() async {
    final res = await apiService.getSatat();
    if (res!.statusCode == 200) {
      setState(() {
        dataMap["Factura"] =
            double.parse(res.data["response"]["invoices"].toString());
        dataMap["Sinietros progresso"] =
            double.parse(res.data["response"]["pending_complaints"].toString());
        dataMap["Sinietros abiertos"] =
            double.parse(res.data["response"]["opened_complaints"].toString());
        dataMap["Sinietros cerrados"] =
            double.parse(res.data["response"]["closed_complaints"].toString());
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        /* height:getProportionateScreenWidth(250),
        width: double.infinity,*/
        //margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          //vertical: getProportionateScreenWidth(15),
        ),
        /* decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),*/
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SectionTitle(
            //   title: "Mis estadísticas",
            //   press: () {},
            // ),
            Text(
              "Mis Estadísticas",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: pPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            (_isLoading)
                ? PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 1000),
                    chartLegendSpacing: 25,
                    chartRadius: MediaQuery.of(context).size.width / 1.8,
                    colorList: [
                      kPrimaryColor,
                      pPrimaryColor,
                      Colors.orange,
                      Colors.red,
                    ],
                    initialAngleInDegree: 0,
                    chartType: ChartType.disc,
                    ringStrokeWidth: 10,
                    //centerText: "Opération",
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  )
                : const Center(child: CircularProgressIndicator())
          ],
        ));
  }
}
