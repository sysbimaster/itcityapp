import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/cart.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/checkout_page_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigationCartNew extends StatefulWidget {
  BottomNavigationCartNew({Key? key,this.cartItems}) : super(key: key);


  List<Cart>? cartItems;
  @override
  _BottomNavigationCartNewState createState() => _BottomNavigationCartNewState();
}

class _BottomNavigationCartNewState extends State<BottomNavigationCartNew> {
  double total=0;
  String? country;
  String? currency;

  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
  }
  List<Cart> cartItemsOld = [];
  @override
  void initState() {
    getCountry();
    // TODO: implement initState
    super.initState();
  }

  Future updateCart() async{
    for(int i = 0;i<cartItemsOld.length;i++){

      widget.cartItems![i].currency = this.currency;
       BlocProvider.of<CartBloc>(context)
          .add(AddProductToCart( widget.cartItems![i],"cartpage"));

    }
    return Future<bool>.value(true);

  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
  listener: (context, state) {
    if(state is CartDetailsLoadedState ){
      cartItemsOld = state.cartItems;

      total = 0;
      state.cartItems.forEach((element) {

        total =total + (element.productPrice! * element.productCount!);
      });
    }
    if(state is CartAddRefreshLoadedState){
      cartItemsOld = state.cartItems;

      total = 0;
      state.cartItems.forEach((element) {

        total =total + (element.productPrice! * element.productCount!);
      });
    }
    // TODO: implement listener
  },
  child: BlocBuilder<CartBloc , CartState>(
      builder: (context,state){


        return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * .25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.GREY,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Products",
                              style: TextStyle(color: Colors.black,fontSize: 15,),
                            ),
                            cartItemsOld != null ?  Text(
                              cartItemsOld.length.toString() + ' items'  ,
                              style: TextStyle(fontSize: 15, ),
                            ):CircularProgressIndicator()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(color: Colors.black,fontSize: 18,),
                            ),
                           total != null ? Text( currency != null?
                            currency! + " " + total.toStringAsFixed(2): 'KWD' + total.toStringAsFixed(2) ,
                              style: TextStyle(fontSize: 20, color: AppColors.LOGO_ORANGE),
                            ):CircularProgressIndicator()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * .07,
                    ),
                    width: MediaQuery.of(context).size.width ,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.WHITE),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: AppColors.LOGO_ORANGE))),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.LOGO_ORANGE),
                        ),
                        onPressed: cartItemsOld.length == 0?null: () async {

                              String? userId =cartItemsOld[0].userId;
                              BlocProvider.of<OrderBloc>(context).add(CreatePurchaseForOrderEvent(userId,total,currency));
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CheckOutNew();
                              }));




                        },
                        child: Text(
                          "PLACE ORDER",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ],
            ),
          );

      },
    ),
);
  }
}


//