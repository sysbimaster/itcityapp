import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:itcity_online_store/blocs/blocs.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // define it once at root level.
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  bool firstTime;
  String country;
  String email;
  void introslides() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstTime = (prefs.getBool('initScreen') ?? false);
    country = prefs.getString('country');

    Future.delayed(Duration(seconds: 5), () {

      if (country== null) {
        prefs.setBool('initScreen', true);
        Navigator.popAndPushNamed(context, '/selectCountry');
      } else {
        Navigator.popAndPushNamed(context, '/home');
      }

    });
  }

  fetchDatas() async {
    BlocProvider.of<HomeBloc>(context).add(FetchHomeImages());
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    BlocProvider.of<HomeBloc>(context).add(FetchHomeAds());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (BlocProvider.of<HomeBloc>(context).state is HomeInitial) {




    }
  }
  @override
  void initState() {

    fetchDatas();
    introslides();

    super.initState();
    print("splash is running");
  }

  void Encrypt() {
    final plainText = 'username';

    final keys =
        encrypt.Key.fromUtf8('tJnSSNRGBXwFQzCqzA/KWoQRmfQdeQRS8ButypQP+nc=');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(keys));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColors.LOGO_ORANGE);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        color: AppColors.LOGO_ORANGE,

        child: Center(
          child: Image.asset(
            'assets/images/logosplash1.png',
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
