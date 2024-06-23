import 'package:flutter/material.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PASSER UN ORDRE",
              style: TextStyle(color: Colors.black),
            ),
          ],
      ),
      ),
      body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.ordre),
    );
  }
}
