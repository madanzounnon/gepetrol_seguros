import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _userId = "";

  @override
  void initState() {
    super.initState();
    //  _loadUserInfo();
  }

  // _loadUserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _userId = (prefs.getString('userId') ?? "");
  //   if (_userId == "") {
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, '/sign_in', ModalRoute.withName('/sign_in'));
  //   } else {
  //     //ApiResponse _apiResponse = await Api().getUserDetails(_userId);
  //     if ((_apiResponse.ApiError as ApiError) == null) {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, '/home', ModalRoute.withName('/home'),
  //           arguments: (_apiResponse.Data as User));
  //     } else {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, '/sign_in', ModalRoute.withName('/sign_in'));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
