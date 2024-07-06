import 'package:gepetrol_eguros/screens/aam/terme_condiction/terme_condiction.dart';
import 'package:flutter/widgets.dart';
import 'package:gepetrol_eguros/screens/aam/apropos_aam/apropos_screen.dart';
import 'package:gepetrol_eguros/screens/aam/contact/contact_screen.dart';
import 'package:gepetrol_eguros/screens/complete_profile/complete_profile_screen.dart';
import 'package:gepetrol_eguros/screens/compte/account_page.dart';
import 'package:gepetrol_eguros/screens/entry_point.dart';
import 'package:gepetrol_eguros/screens/forgot_password/forgot_password_screen.dart';
import 'package:gepetrol_eguros/screens/home/home_screen.dart';
import 'package:gepetrol_eguros/screens/information_personnelle/information_personnelle.dart';
import 'package:gepetrol_eguros/screens/login_success/login_success_screen.dart';
import 'package:gepetrol_eguros/screens/otp/otp_screen.dart';
import 'package:gepetrol_eguros/screens/securite/code_pin.dart';
import 'package:gepetrol_eguros/screens/securite/code_pin_confirmer.dart';
import 'package:gepetrol_eguros/screens/securite/code_pin_login.dart';
import 'package:gepetrol_eguros/screens/sign_in/sign_in_screen.dart';
import 'package:gepetrol_eguros/screens/sign_in_and_sign_up/sign_in_and_sign_up_ecran.dart';
import 'package:gepetrol_eguros/screens/sign_up/components/Souscrire.dart';
import 'package:gepetrol_eguros/screens/splash/splash_screen.dart';
import 'package:gepetrol_eguros/screens/splash_screen.dart';
import 'package:gepetrol_eguros/screens/test/test.dart';

import 'screens/contact/contact.dart';
import 'screens/facture/add_facture.dart';
import 'screens/facture/facture_screens.dart';
import 'screens/plainte/plainte.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Souscrire.routeName: (context) => Souscrire(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SplashScreen1.routeName: (context) => SplashScreen1(
        title: 'Gepetrol Seguros',
      ),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AccountPage.routeName: (context) => AccountPage(),
  StepperDemo.routeName: (context) => StepperDemo(),
  SignInAndSignUpScreen.routeName: (context) => SignInAndSignUpScreen(),
  InformationPersonnelleScreen.routeName: (context) =>
      InformationPersonnelleScreen(),
  CodePinScreen.routeName: (context) => CodePinScreen(),
  ContactScreen.routeName: (context) => ContactScreen(),
  EntryPoint.routeName: (context) => EntryPoint(),
  AproposScreen.routeName: (context) => AproposScreen(),
  ContactsScreen.routeName: (context) => ContactsScreen(),
  CodePinConrfirmerScreen.routeName: (context) => CodePinConrfirmerScreen(),
  CodePinLoginScreen.routeName: (context) => CodePinLoginScreen(),
  TermeCondictionScreen.routeName: (context) => TermeCondictionScreen(),
  AddFactureScreen.routeName: (context) => const AddFactureScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  FactureScreen.routeName: (context) => const FactureScreen(),
  PlainteScreen.routeName: (context) => const PlainteScreen(),
};
