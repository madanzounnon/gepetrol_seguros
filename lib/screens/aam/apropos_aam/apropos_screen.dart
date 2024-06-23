import 'package:flutter/material.dart';
import 'components/body.dart';

class AproposScreen extends StatelessWidget {
  static String routeName = "/apropos";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A propos de nous"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
