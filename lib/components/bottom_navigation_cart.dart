import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/purchase.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/screens/screens.dart';

class BottomNavigationCart extends StatelessWidget {
  double total=0;
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CartBloc , CartState>(
      builder: (context,state){
        if(state is CartDetailsLoadedState){
          
       
          total = 0;
          state.cartItems.forEach((element) {
            total =total + (element.productPrice * element.productCount);
          });
          return Container(
            color: Colors.deepOrangeAccent,
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          " KWD " + total.toStringAsFixed(2) ,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: kAppBarContainerDecoration,
                  child: MaterialButton(
                    
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                    // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.red)),

                    onPressed:state.cartItems.length == 0?null: () {
                      String userId =state.cartItems[0].userId;
                      BlocProvider.of<OrderBloc>(context).add(CreatePurchaseForOrderEvent(userId,total));
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CheckoutPage();
                      }));
                    },
                    // color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    child: Text("Place Order",
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(height: 10,);
      },
    );

  }
}
