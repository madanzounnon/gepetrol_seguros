import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/screens/home/components/section_title.dart';
import 'package:gepetrol_eguros/size_config.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartClient extends StatelessWidget {
  ChartClient({Key? key}) : super(key: key);

  Map<String, double> dataMap = {
    "Depôt": 19000,
    "Solde": 15000,
    "Retrait": 6000,
    "Gain": 5000,
  };

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
          children: [
            SectionTitle(
              title: "Mes Statistiques",
              press: () {},
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 1000),
              chartLegendSpacing: 25,
              chartRadius: MediaQuery.of(context).size.width / 1.8,
              colorList: [
                kPrimaryColor,
                pPrimaryColor,
                kSecondaryColor,
                Colors.green
              ],
              initialAngleInDegree: 0,
              chartType: ChartType.disc,
              ringStrokeWidth: 10,
              //centerText: "Opération",
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            )
          ],
        ));
  }
}
