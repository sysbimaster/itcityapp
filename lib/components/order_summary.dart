import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  dynamic total = 0;

  dynamic delivery = 1;
  String? country;
  String? currency = ' ';
  getCountry() async {
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
    return BlocBuilder<OrderBloc, OrderState>(
  builder: (context, state) {
    if(state is CreatePurchaseSuccessState){

      total =
          state.purchase.productSubTotal;
      delivery = state.purchase.ShippingCharge;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Summary',style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 25,)),
              SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: AppColors.GREY,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal',style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 18,)),
                            total != null? Text(currency!+ ' ' + total.toStringAsFixed(2),style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 18,)): Text(' ')

                          ],
                        )),
                    Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping Charge',style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 18,)),
                            total != null? Text(currency!+ ' '+delivery.toStringAsFixed(2),style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 18,)): Text(' ')

                          ],
                        )),
                    Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',style: TextStyle(color: AppColors.LOGO_ORANGE,fontSize: 22,)),
                            total != null? Text(currency!+ ' '+(total+delivery).toStringAsFixed(2),style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 20,)): Text(' ')

                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      );
    }
    return Container(

        color: AppColors.WHITE,
        child: Center(
        child: SpinKitRipple(
        color: Theme.of(context).primaryColor,
    size: 50,
    )));
  },
);
  }
}
