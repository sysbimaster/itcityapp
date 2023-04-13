import 'package:flutter/material.dart';

import 'package:itcity_online_store/components/CartCardNew.dart';

import 'package:itcity_online_store/components/components.dart';


import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  

    String? userId = '';
    String? currency ;
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      userId = prefs.getString('customerId');
      currency = prefs.getString('currency');
    });
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
      bottomNavigationBar: BottomNavigationCartNew(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: AppColors.LOGO_ORANGE,
          title: Text(
            'My Cart',
            style: TextStyle(color:AppColors.WHITE,fontSize: 25),
          ),


          elevation: 1.0,

      ),
      body: Container(
        margin: EdgeInsets.all(0),
      
        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
        //decoration: kContainerFullDecoration,
        child:        CartCardNew(),
      ),
    );
  }
}
