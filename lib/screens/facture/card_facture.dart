// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:gepetrol_eguros/services/api_service.dart';

import '../../components/secondary_button.dart';
import '../../constants.dart';
import '../../helper/utile.dart';
import '../../models/facture.dart';
import '../../size_config.dart';

class CartFacture extends StatelessWidget {
  final Facture facture;
  final BuildContext context;
  // final Future<void> sendMail;
  CartFacture({
    Key? key,
    required this.facture,
    required this.context,
  }) : super(key: key);
  ApiService apiService = ApiService();

  Future<void> sendMail(int? id) async {
    final res = await apiService.sendEmail(id!);
    print(res.data);
    if (res.statusCode == 200) {
      Utile.messageSuccess(context, res.data["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height:getProportionateScreenWidth(300),
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          //horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          //border: BoxBorder.lerp(a, b, t),
        ),
        child: Card(
            color: Color.fromARGB(255, 255, 255, 255),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            elevation: 10,
            child: Column(
                //mainAxisAlignment : MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                        left: 5, right: 16, top: 10, bottom: 5),
                    child: Row(children: [
                      const CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        maxRadius: 25,
                        child: Text(
                          "FV",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(10),
                      ),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${facture.code!.toUpperCase()} (${facture.regisNumber})",
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      15),
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text("Creado el ${facture.createdAt}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        11))),
                                        Text(
                                            "${facture.firstName} ${facture.lastName}(${facture.regisNumber})",
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //Text("Client: ${widget.facture.clientName.toUpperCase()}",maxLines: 1,style: TextStyle(fontSize: getProportionateScreenWidth(12),)),
                          ]))
                    ]),
                  ),
                  const Divider(
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20),
                          right: getProportionateScreenWidth(20),
                          top: 5,
                          bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Precio Inicial",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                ),
                              ),
                              Text(
                                "${Utile.formatCurrencit(facture.initialPrice)}F CFA",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Precio Accesorios",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                ),
                              ),
                              Text(
                                "${Utile.formatCurrencit(facture.accessoriesPrice)}F CFA",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sub-total:".toUpperCase(),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      Text(
                        "${Utile.formatCurrencit(facture.subTotal)}F CFA",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: getProportionateScreenWidth(19),
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total".toUpperCase(),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      Text(
                        "${Utile.formatCurrencit(facture.total)}F CFA",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),

                  ///SizedBox(height: getProportionateScreenHeight(10),),
                  Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(10),
                          right: getProportionateScreenWidth(10),
                          top: 10,
                          bottom: 10),
                      child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /*SecondaryButton(
                            text: "Detail",
                            backcolor: const Color.fromRGBO(255, 234, 225, 1),
                            textcolor: const Color.fromRGBO(255, 118, 67, 1),
                            press: () { },
                          ),*/
                            SecondaryButton(
                              width: 0.8,
                              text: "Enviar por email",
                              backcolor: kPrimaryColor,
                              textcolor: Colors.white,
                              press: () {
                                sendMail(facture.id);
                              },
                            ),
                          ]))
                ])));
  }
}
