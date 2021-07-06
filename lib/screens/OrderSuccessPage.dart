import 'package:flutter/material.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/resources/values.dart';

import '../constants.dart';

class OrderSuccessPage extends StatefulWidget {
  final OrderStatus orderStatus;
   OrderSuccessPage({Key key,@required this.orderStatus}) : super(key: key);

  @override
  _OrderSuccessPageState createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushNamed(context, '/home');
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              title: Text('Order Summary',style: TextStyle(
                color: Colors.white
              ),),
              flexibleSpace: Container(
                decoration: kAppBarContainerDecoration,
              )),

        ),
        body: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 100,
                  ),
                  SizedBox(height:10),
                  Text("Thank You!",style: Theme.of(context).textTheme.headline4,),
                  SizedBox(
                    height: 15.0,
                  ),

                  Text("Your Order Id is " + widget.orderStatus.data.toString() ,
                      style: TextStyle(fontSize: 23),),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text("Your Order is placed succesfully. We will contact you soon with Delivery Details." ,
                    style: TextStyle(fontSize: 23,),textAlign: TextAlign.center,),
                  SizedBox(
                    height: 15.0,
                  ),
                  Material(

                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: AppColors.LOGO_ORANGE,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width*.75,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      },
                      child: Text(" Go Home ".toUpperCase(),
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),


                ],
              ),
            )),
      ),
    );
  }
}
