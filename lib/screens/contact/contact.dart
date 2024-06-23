import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/components/default_button.dart';
import 'package:gepetrol_eguros/size_config.dart';

import '../../../constants.dart';
import '../../helper/form.dart';

class ContactScreen extends StatelessWidget {
  static String routeName = "/contact";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Nous contacter",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
                color: pPrimaryColor),
          ),
        ]));
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Nous sommes avec disposition pour \nvos diverses preocupation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(17),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              ContactForm(),
            ],
          ),
        ),
      ),
    ));
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController object = TextEditingController();
  TextEditingController message = TextEditingController();

  List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          inputForm(
            name: 'email',
            controller: email,
            labeltext: "Email",
            validInput: false,
            type: TextInputType.emailAddress,
          ),
          inputForm(
            name: 'object',
            controller: object,
            labeltext: "Object",
            validInput: true,
          ),
          inputForm(
            name: 'message',
            controller: message,
            labeltext: "Message",
            minLines: 5,
            maxLines: 5,
            type: TextInputType.multiline,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          DefaultButton(
            text: "Envoyez un mail",
            press: () {
              if (_formKey.currentState!.validate()) {}
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
        ],
      ),
    );
  }
}
