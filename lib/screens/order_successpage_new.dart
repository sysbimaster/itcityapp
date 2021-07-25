import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/order_details.dart';
import 'package:itcity_online_store/api/models/order_status_new.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';

class OrderSucessNew extends StatefulWidget {
  final OrderStatusNew orderStatusNew;
  String currency;
 OrderSucessNew({Key key,this.orderStatusNew,this.currency}) : super(key: key);

  @override
  _OrderSucessNewState createState() => _OrderSucessNewState();
}

class _OrderSucessNewState extends State<OrderSucessNew> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        backgroundColor:AppColors.WHITE ,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: Icon(Icons.arrow_back_ios,color: AppColors.WHITE,),
          ),
            centerTitle: true,
            elevation: 0.0,
            title:  Image.asset(
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
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  color: AppColors.GREY,
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height * .10 ,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(widget.orderStatusNew.customerName== null?"THANK YOU FOR YOUR ORDER!":"THANK YOU FOR YOUR ORDER , "+widget.orderStatusNew.customerName.toUpperCase()  ,style:TextStyle(
                            fontSize: 22,color: AppColors.LOGO_BLACK,fontFamily: 'Myriad-semi',fontWeight: FontWeight.w700
                        ),textAlign: TextAlign.center,
                ),
                      ),

                    ],
                  )),
                Container(
                    color: AppColors.WHITE,
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height * .12 ,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Text('Order Confirmed',style:TextStyle(
                              fontSize: 23,color: Colors.green,fontFamily: 'Myriad-semi',fontWeight: FontWeight.w700
                          ),textAlign: TextAlign.center,
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Text('Your order id is #' + widget.orderStatusNew.orderId.toString(),style:TextStyle(
                              fontSize: 20,color: AppColors.GREY_TEXT,fontFamily: 'Myriad-semi',
                          ),textAlign: TextAlign.center,
                          ),

                        ),
                        OrderDetailsSection(orderId: widget.orderStatusNew.orderId,)

                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderDetailsSection extends StatefulWidget {
 final int orderId;
  const OrderDetailsSection({Key key,this.orderId}) : super(key: key);

  @override
  _OrderDetailsSectionState createState() => _OrderDetailsSectionState();
}

class _OrderDetailsSectionState extends State<OrderDetailsSection> {
  OrderDetails orderDetails;
  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(GetOrderDetailsEvent(widget.orderId));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
  builder: (context, state) {
    if(state is GetOrderDetailsLoadingState){
      return Container(
        color: Colors.white,
        child: Center(
            child: SpinKitRing(
              color: Theme.of(context).primaryColor,
              size: 50,
            )),
      );
    }
    if(state is GetOrderDetailsLoadedState){
      orderDetails = BlocProvider.of<OrderBloc>(context).orderDetails;
      return Container(
        color: AppColors.GREY,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .45,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:Row(
              children: [
                Icon(Icons.shopping_bag_outlined),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text('Your order id is #' + widget.orderId.toString(),style:TextStyle(
                    fontSize: 20,color: AppColors.GREY_TEXT,fontFamily: 'Myriad-semi',
                  ),textAlign: TextAlign.center,
                  ),
                ),

              ],
            ) ,
            )

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
