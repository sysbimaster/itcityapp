import 'package:flutter/material.dart';
import 'package:itcity_online_store/resources/values.dart';

class CurrencyBar extends StatefulWidget {
  const CurrencyBar({Key key}) : super(key: key);

  @override
  _CurrencyBarState createState() => _CurrencyBarState();
}

class _CurrencyBarState extends State<CurrencyBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(
        minHeight: 38,
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 35,
        ),
        decoration: BoxDecoration (
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
          color: AppColors.LOGO_ORANGE,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 2.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        //color: Colors.deepOrangeAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(

              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18, 2, 0, 2),
                    child: Icon(Icons.account_balance_wallet_rounded,color: Colors.white,)),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: Text('Currency : KWD',style: TextStyle(
                    color:Colors.white,fontSize: 16,fontWeight: FontWeight.w800
                  ), ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 2, 18, 2),
              child: Text('Change',style: TextStyle(
                  color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600, decoration: TextDecoration.underline,
              ), ),
            )
          ],
        ),
      ),
    );
  }
}
