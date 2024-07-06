import 'package:flutter/material.dart';
import 'components/body.dart';

class ContactsScreen extends StatelessWidget {
  static String routeName = "/contacts";

  const ContactsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contáctenos"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
