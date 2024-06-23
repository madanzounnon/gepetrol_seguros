import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as pth;
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/helper/store.dart';
import 'package:gepetrol_eguros/models/user.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);
typedef ResFailure = Future<void> Function(dynamic);

class Utile {
  Utile({this.user});
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  User? user;

  Future<void> getUser() async {
    user = await StoreAuth().getUser();
    //user = sharedPreferences.getStringList("abonne");
    //userInfos = sharedPreferences.getStringList("abonne");
  }

  static Map<String, dynamic> statut = {
    "pending": 'En attente',
    "rejected": 'Rejeté',
    "cancelled": 'Annulé',
    "approved": 'Approuvé',
  };

  static String formatCurrencit(dynamic valeur) {
    if (valeur != null) {
      var formatter = NumberFormat("#,###.##", 'fr');
      return formatter.format(valeur).toString();
    }
    return "0";
  }

  static void messageSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: pPrimaryColor));
  }

  static void messageErro(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 245, 100, 100)));
  }

  // Get date as a string for display.
  static String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy à HH:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  static Future<dynamic> getImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //TO convert Xfile into file
    File file = File(image!.path);
    return file;
  }

  // Get date as a string for display.
  static String getFormattedDate1(String date) {
    initializeDateFormatting('fr_FR', null);
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    return DateFormat.yMMMd('fr_FR').format(inputDate).toString();
    // var outputFormat = DateFormat('dd-MM-yyyy à HH:mm');
    // var outputDate = outputFormat.format(inputDate);
    // return outputDate.toString();
  }

  static String getFormattedDateEn(String? date) {
    print(date);
    var localDate = DateTime.parse(date!);
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(localDate.toString());
    print(inputDate);
    print(inputDate);
    return inputDate.toString();
    // var outputFormat = DateFormat('dd-MM-yyyy à HH:mm');
    // var outputDate = outputFormat.format(inputDate);
    // return outputDate.toString();
  }

  static Future<void> multipart(Map<String, String> parameter, String path,
      {bool isTokenApi = false,
      Map<String, File>? imgObj,
      ResSuccess? withSuccess,
      ResFailure? failure}) async {
    final Future<SharedPreferences> _sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    final token = sharedPreferences.getString("token");
    Future(() {
      try {
        var uri = Uri.parse(path);
        var request = http.MultipartRequest('POST', uri);
        request.fields.addAll(parameter);

        if (isTokenApi) {
          request.headers.addAll({"Authorization": "Bearer $token"});
        }

        if (kDebugMode) {
          print('Service Call: $path');
          print('Service para: ${parameter.toString()}');
          print('Service header: ${request.headers.toString()}');
        }

        if (imgObj != null) {
          imgObj.forEach((key, value) async {
            if (value != null) {
              var multipartFile = http.MultipartFile(
                  key, value.readAsBytes().asStream(), value.lengthSync(),
                  filename: pth.basename(value.path));
              request.files.add(multipartFile);
            }
          });
        }

        request.send().then((response) async {
          var value = await response.stream.transform(utf8.decoder).join();

          try {
            if (kDebugMode) {
              print(value);
            }

            var jsonObj = json.decode(value) as Map<String, dynamic>? ?? {};
            if (withSuccess != null) {
              withSuccess(jsonObj);
            }
          } catch (e) {
            if (failure != null) failure(e.toString());
          }
        }).catchError((err) {
          if (failure != null) failure(err.toString());
        });
      } on SocketException catch (e) {
        if (failure != null) failure(e.toString());
      } catch (e) {
        if (failure != null) failure(e.toString());
      }
    });
  }

  static Widget preloader() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const CircularProgressIndicator(),
        SizedBox(height: getProportionateScreenWidth(20)),
        const Text('Veuillez patienter SVP, le traitement est en cours')
      ]),
    );
  }

  static Widget isEmpty(String message) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "assets/images/success.png",
          width: getProportionateScreenWidth(300),
          // height: getProportionateScreenHeight(300),
        ),
        SizedBox(height: getProportionateScreenWidth(30)),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(20),
                horizontal: getProportionateScreenHeight(40)),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  color: pPrimaryColor,
                  fontWeight: FontWeight.w700),
            )),
      ]),
    );
  }

  static void loarder(BuildContext context) async {
    showDialog(
        barrierDismissible: false, //Don't close dialog when click outside
        context: context,
        builder: (_) {
          return const Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(), //Loading Indicator you can use any graphic
                  SizedBox(
                    height: 20,
                  ),
                  Text('Veuillez patienter SVP')
                ],
              ),
            ),
          );
        });
  }
}
