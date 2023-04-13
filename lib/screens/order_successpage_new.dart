import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/order_details.dart';
import 'package:itcity_online_store/api/models/order_status_new.dart';
import 'package:itcity_online_store/api/models/product_order_details.dart';
import 'package:itcity_online_store/api/services/order_api.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:in_app_review/in_app_review.dart';
enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

extension on Availability {
  String stringify() => this.toString().split('.').last;
}


class OrderSucessNew extends StatefulWidget {
  final OrderStatusNew? orderStatusNew;
  String? currency;
  OrderSucessNew({Key? key, this.orderStatusNew, this.currency})
      : super(key: key);

  @override
  _OrderSucessNewState createState() => _OrderSucessNewState();
}

class _OrderSucessNewState extends State<OrderSucessNew> {
  OrderApi? orderApi;
  final InAppReview _inAppReview = InAppReview.instance;
  String _appStoreId = '';
  String _microsoftStoreId = '';
  Availability _availability = Availability.LOADING;
  bool goHomePressed =false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.AVAILABLE
              : Availability.UNAVAILABLE;
        });
      } catch (e) {
        setState(() => _availability = Availability.UNAVAILABLE);
      }
    });
    // TODO: implement initState
    super.initState();
  }
  void _setAppStoreId(String id) => _appStoreId = id;

  void _setMicrosoftStoreId(String id) => _microsoftStoreId = id;

   _requestReview() {
    _inAppReview.requestReview();
    setState(() {
      goHomePressed = true;
    });

  }

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
    appStoreId: _appStoreId,
    microsoftStoreId: _microsoftStoreId,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, '/home');
      } as Future<bool> Function()?,
      child: Scaffold(
        backgroundColor: AppColors.WHITE,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.WHITE,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          title: Image.asset(
            'assets/images/logo_home.png',
            width: 130,
            height: 55,
            fit: BoxFit.contain,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
           // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                    color: AppColors.GREY,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.orderStatusNew!.customerName == null
                                ? "THANK YOU FOR YOUR ORDER!"
                                : "THANK YOU FOR YOUR ORDER , " +
                                    widget.orderStatusNew!.customerName!
                                        .toUpperCase(),
                            style: TextStyle(
                                fontSize: 22,
                                color: AppColors.LOGO_BLACK,
                                fontFamily: 'Myriad-semi',
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
                Container(
                    color: AppColors.WHITE,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Text(
                            'Order Confirmed',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.green,
                                fontFamily: 'Myriad-semi',
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Text(
                            'Your order id is #' +
                                widget.orderStatusNew!.orderId.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.GREY_TEXT,
                              fontFamily: 'Myriad-semi',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
                OrderDetailsSection(
                  orderId: widget.orderStatusNew!.orderId,
                ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(

                    color: Colors.white,
                    border: Border.all(

                        color: AppColors.LOGO_ORANGE,
                        width: 1,

                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping Address',style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 22,)),


                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(widget.orderStatusNew!.paymentAddress!,style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 22),)),
            // Text(widget.orderStatusNe,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
            // Text(customer.customerState,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
            // Text(customer.customerPincode,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
            // Text("mob: "+customer.customerMobile,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),


            ],
            ),
                  ),
                ),
          ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Your Order is placed succesfully. We will contact you soon with Delivery Details." ,
                    style: TextStyle(fontSize:18,),textAlign: TextAlign.center,),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Material(

                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.LOGO_ORANGE,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        // if(goHomePressed){
                        //
                        // }else {
                        //   _requestReview;
                        // }


                      },
                      child: Text(" GO HOME ".toUpperCase(),
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(color: Colors.white,fontSize: 20)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderDetailsSection extends StatefulWidget {
  final int? orderId;

  const OrderDetailsSection({Key? key, this.orderId}) : super(key: key);

  @override
  _OrderDetailsSectionState createState() => _OrderDetailsSectionState();
}

class _OrderDetailsSectionState extends State<OrderDetailsSection> {
  OrderDetails? orderDetails;
  ProductOrderDetails? productOrderDetails;


  @override
  void initState() {

    BlocProvider.of<OrderBloc>(context)
        .add(GetOrderDetailsEvent(widget.orderId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is GetOrderDetailsLoadingState) {
          return Container(
            color: AppColors.GREY,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .45,
            child: Center(
                child: SpinKitRing(
              color: Theme.of(context).primaryColor,
              size: 50,
            )),
          );
        }
        if (state is GetOrderDetailsLoadedState) {
          orderDetails = BlocProvider.of<OrderBloc>(context).orderDetails;
          productOrderDetails = BlocProvider.of<OrderBloc>(context).productOrderDetails;
          return Container(
            color: AppColors.GREY,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          'Order id  #' + widget.orderId.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.GREY_TEXT,
                            fontFamily: 'Myriad-semi',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.GREY_TEXT,
                            fontFamily: 'Myriad-semi',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Qty/Price',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.GREY_TEXT,
                            fontFamily: 'Myriad-semi',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
               ListView.builder(
                 shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: productOrderDetails!.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               width: MediaQuery.of(context).size.width * .55,
                                 child: Text(productOrderDetails!.data![index].name!,style: TextStyle(
                                   fontSize: 15,
                                   color: AppColors.GREY_TEXT,
                                   fontFamily: 'Myriad-semi',
                                   fontWeight: FontWeight.w700,
                                 ),
                                   textAlign: TextAlign.left,)),
                             Text(productOrderDetails!.data![index].qty.toString() + " X "+orderDetails!.data![0].country!+ " " + productOrderDetails!.data![index].price.toString(),style: TextStyle(
                               fontSize: 17,
                               color: AppColors.GREY_TEXT,
                               fontFamily: 'Myriad-semi',
                               fontWeight: FontWeight.w700,
                             ),
                               textAlign: TextAlign.left,)
                           ],
                         ),
                      );
                    },
                  ),

                Container(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Sub Total ',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.GREY_TEXT,
                          fontFamily: 'Myriad-semi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        orderDetails!.data![0].country! + ' '+
                      orderDetails!.data![0].productSubTotal! ,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.GREY_TEXT,
                          fontFamily: 'Myriad-semi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping Charge ',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.GREY_TEXT,
                          fontFamily: 'Myriad-semi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(orderDetails!.data![0].country! + ' '+
                      orderDetails!.data![0].shippingCharge!,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.GREY_TEXT,
                          fontFamily: 'Myriad-semi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Total',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.GREY_TEXT,
                            fontFamily: 'Myriad-semi',
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        orderDetails!.data![0].country! + ' '+
                            (double.parse(orderDetails!.data![0].productSubTotal!) +
                                double.parse(
                                    orderDetails!.data![0].shippingCharge!))
                                .toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.GREY_TEXT,
                          fontFamily: 'Myriad-semi',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          );
        }
        return Container(
          color: Colors.white,
          child: Center(
              child: SpinKitRing(
            color: Theme.of(context).primaryColor,
            size: 50,
          )),
        );
      },
    );
  }
}
