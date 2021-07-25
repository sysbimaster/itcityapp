import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/intro_slides.dart';
import 'package:flutter/services.dart';
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
    print("preferance state1 >>>>>>>>>>" + firstTime.toString());
    // Encrypt();
    Future.delayed(Duration(seconds: 5), () {
      // Navigator.popUntil(context, ModalRoute.withName('/screen'));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => IntroSlides(),
      //     ));
      if (country== null) {
        prefs.setBool('initScreen', true);
        Navigator.popAndPushNamed(context, '/selectCountry');
      } else {
        Navigator.popAndPushNamed(context, '/home');
      }
      print("preferance state >>>>>>>>>>" + firstTime.toString());
    });
  }

  fetchDatas() async {
    BlocProvider.of<HomeBloc>(context).add(FetchHomeImages());
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    BlocProvider.of<HomeBloc>(context).add(FetchHomeAds());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (BlocProvider.of<HomeBloc>(context).state is HomeInitial) {

      // if(prefs.containsKey('currency')){
      //   BlocProvider.of<HomeBloc>(context)
      //       .add(FetchTodaysDealsByDate(prefs.getString('currency')));
      //
      //   BlocProvider.of<HomeBloc>(context).add(FetchFeaturedProduct(prefs.getString('currency')));
      //   BlocProvider.of<HomeBloc>(context).add(FetchPopularProduct(prefs.getString('currency')));
      //   BlocProvider.of<HomeBloc>(context).add(FetchComputerCollections(prefs.getString('currency')));
      //
      //   BlocProvider.of<HomeBloc>(context).add(FetchMobileCollections(prefs.getString('currency')));
      // }



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
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);

    // print(decrypted);
    // print(encrypted.bytes);
    // print(encrypted.base16);
    print('encrypted>>>>>>>>>>>>>>>>>>>' + encrypted.base64);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColors.LOGO_ORANGE);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        color: AppColors.LOGO_ORANGE,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [Colors.white10, Colors.white70])),
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
