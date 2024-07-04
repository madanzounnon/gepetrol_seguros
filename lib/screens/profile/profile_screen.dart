import 'package:flutter/material.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon compte"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
