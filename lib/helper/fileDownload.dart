import 'dart:io';

import 'package:gepetrol_eguros/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';

import 'utile.dart';

class FileDownload {
  Dio dio = Dio();
  bool isSuccess = false;

  void startDownloading(BuildContext context, final Function okCallback,
      String typeFile, String baseUrl) async {
    String fileName = typeFile + ".pdf";

    // String baseUrl =
    //     "https://file-examples.com/wp-content/uploads/2017/10/file-example_PDF_1MB.pdf";

    String path = await getFilePath(fileName);

    try {
      await dio.download(
        baseUrl,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          okCallback(recivedBytes, totalBytes);
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      Navigator.pop(context);
      if (typeFile == "releve") {
        Utile.messageSuccess(context,
            "Votre relevé est téléchargé dans le dossier téléchargement de votre téléphone");
      } else {
        Utile.messageSuccess(context,
            "Votre portefeuillr est téléchargé dans le dossier téléchargement de votre téléphone");
      }
    }
  }

  Future<String> getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Impossible d’obtenir le chemin du dossier de téléchargement $err");
    }
    return "${dir?.path}$filename";
  }
}
