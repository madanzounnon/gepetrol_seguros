// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gepetrol_eguros/constants.dart';
import 'package:flutter/material.dart';

import 'package:gepetrol_eguros/helper/fileDownload.dart';

class DownloadProgressDialog extends StatefulWidget {
  String typeFile;
  String baseUrl;
  DownloadProgressDialog({
    Key? key,
    required this.typeFile,
    required this.baseUrl,
  }) : super(key: key);
  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double progress = 0.0;

  @override
  void initState() {
    print("objectobjectobjectobject");
    _startDownload(widget.typeFile, widget.baseUrl);
    super.initState();
  }

  void _startDownload(String typeFile, String baseUrl) {
    print(typeFile);
    print(baseUrl);
    FileDownload().startDownloading(context, (recivedBytes, totalBytes) {
      setState(() {
        progress = recivedBytes / totalBytes;
      });
    }, typeFile, baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    String downloadingProgress = (progress * 100).toInt().toString();
    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            "téléchargement...",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey,
          color: pPrimaryColor,
          minHeight: 10,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "$downloadingProgress %",
          ),
        )
      ],
    ));
  }
}
