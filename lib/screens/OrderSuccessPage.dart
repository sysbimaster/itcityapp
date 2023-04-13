import 'package:flutter/material.dart';
import 'package:itcity_online_store/api/models/order_status_new.dart';
import 'package:itcity_online_store/resources/values.dart';

import '../constants.dart';

class OrderSuccessPage extends StatefulWidget {
  final OrderStatusNew orderStatusNew;
  String? currency;
   OrderSuccessPage({Key? key,required this.orderStatusNew,this.currency}) : super(key: key);

  @override
  _OrderSuccessPageState createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushNamed(context, '/home');
      } as Future<bool> Function()?,
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
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15,),
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 75,
                    ),
                    SizedBox(height:10),
                    Text(widget.orderStatusNew.customerName== null?"Thank you for your order!":"Thank you, "+widget.orderStatusNew.customerName! + " for your order." ,style:TextStyle(
                      fontSize: 35,color: AppColors.GREY_TEXT,fontFamily: 'Myriad-semi'
                    ),textAlign: TextAlign.center,),
                    SizedBox(
                      height: 15.0,
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Text("Order Details" ,
                    //     style: TextStyle(fontSize: 25),textAlign: TextAlign.left,),
                    // ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: AppColors.GREY,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
                            child: Text("Order Details" ,
                              style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Your Order Id is : "  ,
                                    style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
                                Text( widget.orderStatusNew.orderId.toString() ,
                                  style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Payment Method : "  ,
                                  style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
                                Text( widget.orderStatusNew.paymentMethod! ,
                                  style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount : "  ,
                                  style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
                                Text( widget.currency!+ " " + widget.orderStatusNew.totalAmnt! ,
                                  style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping Address',style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 25,)),


                          ],
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width * .60,
                            child: Text(widget.orderStatusNew.paymentAddress!,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 23),)),
                        // Text(widget.orderStatusNe,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
                        // Text(customer.customerState,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
                        // Text(customer.customerPincode,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
                        // Text("mob: "+customer.customerMobile,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),


                      ],
                    ),
                  ),
                ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("Your Order is placed succesfully. We will contact you soon with Delivery Details." ,
                      style: TextStyle(fontSize:18,),textAlign: TextAlign.center,),
                    SizedBox(
                      height: 15.0,
                    ),
                    Material(

                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: AppColors.LOGO_ORANGE,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: (){
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        },
                        child: Text(" GO HOME ".toUpperCase(),
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white,fontSize: 20)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),


                  ],
                ),
              )),
        ),
      ),
    );
  }
}
