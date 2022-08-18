import 'package:flutter/material.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyBar extends StatefulWidget {
  const CurrencyBar({Key? key,String? currency,String }) : super(key: key);

  @override
  _CurrencyBarState createState() => _CurrencyBarState();
}

class _CurrencyBarState extends State<CurrencyBar> {
  String? country ;
  String? currency ;
  getCountry() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');


    });

  }
  @override
  void initState() {
    getCountry();


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.LOGO_BLACK,
      constraints: BoxConstraints(
        minHeight: 33,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(

            children: [

              Padding(
                padding: EdgeInsets.fromLTRB(18, 2, 5, 2),
                child:this.currency != null ? Text("Country : " + this.country!,style: TextStyle(
                  color:Colors.white,fontSize: 14
                ), ): Text('Please select a country',style: TextStyle(
                    color:Colors.white,fontSize: 14
                ), ),
              ),

            ],
          ),

          this.currency!= null?Padding(
            padding: EdgeInsets.fromLTRB(5, 2, 18, 2),
            child: Text('CHANGE',style: TextStyle(
              color: Colors.white,fontSize: 14,), ),
          ): Container()

        ],
      ),
    );
  }
}
