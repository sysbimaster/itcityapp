import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _token = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = await prefs.getString('token');
   // _token = await _flutterSecureStorage.read(key: 'token');
    
    if (_token == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      // ApiResponse _apiResponse = await getUserDetails(_userId);
      // if ((_apiResponse.ApiError as ApiError) == null) {
        
      Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        // arguments: (_apiResponse.Data)
      );
      // } else {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/login', ModalRoute.withName('/login'));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Container(
          color: Colors.white,
          child: Center(
              child: SpinKitCircle(
            color: Theme.of(context).primaryColor,
            size: 50,
          )),
        ));
  }
}
