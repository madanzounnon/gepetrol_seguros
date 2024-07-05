import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/screens/home/components/actualites.dart';
import 'package:gepetrol_eguros/screens/home/components/chart.dart';

import '../../../size_config.dart';
import 'discount_banner.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DiscountBanner(),
            SizedBox(height: getProportionateScreenHeight(20)),
            ChartClient(),
            SizedBox(height: getProportionateScreenHeight(20)),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenHeight(20)),
            // Actualites()
            //SizedBox(height: getProportionateScreenHeight(10)),
            //Carouseelhome()
          ],
        ),
      ),
    );
  }
}
