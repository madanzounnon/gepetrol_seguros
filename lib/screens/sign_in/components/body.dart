import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gepetrol_eguros/components/no_account_text.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(300),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/back.svg',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                            width: double.infinity,
                            height: getProportionateScreenHeight(300),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: double.infinity,
                                      height: getProportionateScreenHeight(300),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                                getProportionateScreenHeight(
                                                    70),
                                            top: getProportionateScreenHeight(
                                                70)),
                                        child: SvgPicture.asset(
                                          'assets/images/logo.svg',
                                          height:
                                              getProportionateScreenHeight(40),
                                          width:
                                              getProportionateScreenHeight(40),
                                        ),
                                      )),
                                ]))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(children: [
                      //SizedBox(height: SizeConfig.screenHeight * 0.03),
                      SignForm(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      NoAccountText(),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
