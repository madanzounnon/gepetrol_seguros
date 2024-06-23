import 'package:flutter/material.dart';
import 'components/body.dart';

class ContactsScreen extends StatelessWidget {
  static String routeName = "/contacts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contactez-nous"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
