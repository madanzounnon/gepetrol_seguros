// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/helper/store.dart';
import 'package:gepetrol_eguros/helper/utile.dart';
import 'package:gepetrol_eguros/screens/entry_point.dart';
import 'package:gepetrol_eguros/screens/home/home_screen.dart';
import 'package:gepetrol_eguros/size_config.dart';

import '../../components/pin_button.dart';

class CodePinLoginScreen extends StatefulWidget {
  static String routeName = "/CodePinLogin";
  CodePinLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CodePinLoginScreenState createState() => _CodePinLoginScreenState();
}

class _CodePinLoginScreenState extends State<CodePinLoginScreen> {
  var selectedindex = 0;
  String code = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenHeight(25),
      fontWeight: FontWeight.w700,
      color: pPrimaryColor,
    );

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("Code is $code");
    return Scaffold(
      //appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(40)),
            child: SvgPicture.asset(
              'assets/icons/logoligth.svg',
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenHeight(50),
            ),
          ),
          Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              width: width,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(20)),
                            child: Text(
                              "Saisissez votre code PIN pour déverrouiller",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(25),
                                color: pPrimaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  SizedBox(
                    child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DigitHolder(
                              width: width,
                              index: 0,
                              selectedIndex: selectedindex,
                              code: code,
                            ),
                            DigitHolder(
                                width: width,
                                index: 1,
                                selectedIndex: selectedindex,
                                code: code),
                            DigitHolder(
                                width: width,
                                index: 2,
                                selectedIndex: selectedindex,
                                code: code),
                            DigitHolder(
                                width: width,
                                index: 3,
                                selectedIndex: selectedindex,
                                code: code),
                            DigitHolder(
                                width: width,
                                index: 4,
                                selectedIndex: selectedindex,
                                code: code),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  SizedBox(
                    child: Container(
                      margin: EdgeInsets.all(getProportionateScreenHeight(20)),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    child: PinButton(
                                        press: () {
                                          addDigit(1);
                                        },
                                        textStyle: textStyle,
                                        text: '1')),
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(2);
                                      },
                                      textStyle: textStyle,
                                      text: '2'),
                                ),
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(3);
                                      },
                                      textStyle: textStyle,
                                      text: '3'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(4);
                                      },
                                      textStyle: textStyle,
                                      text: '4'),
                                ),
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(5);
                                      },
                                      textStyle: textStyle,
                                      text: '5'),
                                ),
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(6);
                                      },
                                      textStyle: textStyle,
                                      text: '6'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(7);
                                      },
                                      textStyle: textStyle,
                                      text: '7'),
                                ),
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(8);
                                      },
                                      textStyle: textStyle,
                                      text: '8'),
                                ),
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(9);
                                      },
                                      textStyle: textStyle,
                                      text: '9'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    child: Container(
                                  margin: EdgeInsets.all(
                                      getProportionateScreenWidth(10)),
                                  height: getProportionateScreenHeight(60),
                                  width: getProportionateScreenHeight(60),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          shape: CircleBorder(
                                              side: BorderSide(
                                                  color: const Color.fromARGB(
                                                      31, 75, 75, 75),
                                                  width: 1,
                                                  style: BorderStyle.solid)),
                                          //primary: Colors.white,
                                          foregroundColor:
                                              pPrimaryColor.withOpacity(0.3)),
                                      onPressed: () {
                                        backspace();
                                      },
                                      child: Icon(Icons.backspace_outlined,
                                          color: pPrimaryColor,
                                          size: getProportionateScreenHeight(
                                              30))),
                                )),
                                SizedBox(
                                  child: PinButton(
                                      press: () {
                                        addDigit(0);
                                      },
                                      textStyle: textStyle,
                                      text: '0'),
                                ),
                                SizedBox(
                                    child: Container(
                                  margin: EdgeInsets.all(
                                      getProportionateScreenWidth(10)),
                                  height: getProportionateScreenHeight(60),
                                  width: getProportionateScreenHeight(60),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          shape: CircleBorder(
                                              side: BorderSide(
                                                  color: const Color.fromARGB(
                                                      31, 75, 75, 75),
                                                  width: 1,
                                                  style: BorderStyle.solid)),
                                          //primary: Colors.white,
                                          foregroundColor:
                                              pPrimaryColor.withOpacity(0.3)),
                                      onPressed: () async {
                                        if (code.length == 5) {
                                          String? pin =
                                              await StoreAuth().getCode();
                                          if (pin != null &&
                                              pin == code.trim()) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EntryPoint(
                                                              currentPage: 0,
                                                            )),
                                                    (route) => false);
                                          } else {
                                            Utile.messageErro(context,
                                                "Le code est incorrect");
                                          }
                                        } else {
                                          Utile.messageErro(context,
                                              "Le code doit être de cinq chiffres");
                                        }
                                      },
                                      child: Icon(Icons.check,
                                          color: pPrimaryColor,
                                          size:
                                              getProportionateScreenWidth(30))),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Code PIN de sécurité",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
                color: pPrimaryColor),
          ),
          // Container(
          //   height: 30,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       Icon(
          //         FontAwesomeIcons.bell,
          //         color: Color.fromARGB(255, 3, 185, 66),
          //         size: 20,
          //       ),
          //     ],
          //   ),
          // ),
        ]));
  }

  addDigit(int digit) {
    if (code.length > 4) {
      return;
    }
    setState(() {
      code = code + digit.toString();
      print('Code est $code');
      selectedindex = code.length;
    });
  }

  backspace() {
    if (code.length == 0) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedindex = code.length;
    });
  }
}

class DigitHolder extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String code;
  final double width;

  const DigitHolder({
    required this.selectedIndex,
    Key? key,
    required this.width,
    required this.index,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: getProportionateScreenWidth(2),
                color: Color.fromARGB(66, 101, 100, 100))),
      ),
      child: code.length > index
          ? Container(
              alignment: Alignment.center,
              width: getProportionateScreenWidth(35),
              height: getProportionateScreenWidth(35),
              child: Text(
                code.split("")[index],
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: getProportionateScreenWidth(25),
                    fontWeight: FontWeight.w900),
              ),
            )
          : Container(),
    );
  }
}
// class DigitHolder extends StatelessWidget {
//   final int selectedIndex;
//   final int index;
//   final String code;
//   final double width;

//   const DigitHolder({
//     required this.selectedIndex,
//     Key? key,
//     required this.width,
//     required this.index,
//     required this.code,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       height: getProportionateScreenWidth(40),
//       width: getProportionateScreenWidth(40),
//       margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
//       decoration: BoxDecoration(
//       border: Border(bottom: BorderSide(width: 2, color: const Color.fromARGB(66, 101, 100, 100))),
//           //   boxShadow: [
//           //   BoxShadow(
//           //     color: index == selectedIndex ? pPrimaryColor : Color.fromARGB(0, 24, 24, 24),
//           //     offset: Offset(0, 0),
//           //     spreadRadius: 1.5,
//           //     blurRadius: 2,
//           //   )
//           // ]
//         ),
//       child: code.length > index
//           ? Container(
//               width: 15,
//               height: 15,
//               /*decoration: BoxDecoration(
//                 color: Colors.black.withBlue(40),
//                 shape: BoxShape.circle,
//               ),*/
//               child: Text('*',style: TextStyle(fontSize: getProportionateScreenWidth(15),fontWeight: FontWeight.w400),),
//             )
//           : Container(),
//     );
//   }
// }
