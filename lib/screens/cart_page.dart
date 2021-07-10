import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/blocs/cart/cart_bloc.dart';
import 'package:itcity_online_store/blocs/cart/cart_event.dart';
import 'package:itcity_online_store/blocs/cart/cart_state.dart';

import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/constants.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  int _itemCount = 0;
    String userId = '';
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = await prefs.getString('customerId');

  }

  @override
  void initState() {
    super.initState();
    this.getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      bottomNavigationBar: BottomNavigationCart(),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,

          elevation: 0.0,
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [Colors.orange, Colors.deepOrangeAccent])),
          // )
      ),
      body: Container(
        margin: EdgeInsets.all(0),
      
        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
        //decoration: kContainerFullDecoration,
        child:        CartCard(),
      ),
    );
  }
}
