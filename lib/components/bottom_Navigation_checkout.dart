import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';


class BottomNavigation extends StatelessWidget {
  dynamic total = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
  listener: (context, state) {

  },
  child: BlocBuilder<OrderBloc, OrderState>(builder: (context, orderState) {
      if (orderState is CreatePurchaseSuccessState) {
        return Container(
          color: Colors.deepOrangeAccent,
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  if (cartState is CartDetailsLoadedState) {
                    total =
                        orderState.purchase.productSubTotal!.toStringAsFixed(2);

                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "KWD $total",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  if (userState is CustomerInformationLoadedState) {
                    bool Address = userState.customerlist.customerAddress != null;

                    return Container(
                      decoration: kAppBarContainerDecoration,
                      child: MaterialButton(

                        height: 40,
                        minWidth: MediaQuery.of(context).size.width,
                        // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.red)),

                        onPressed: Address ? () {
                          Order order = Order();
                          order.purchaseId = orderState.purchase.purchaseId;
                          order.customerId = userState.customerlist.customerId;
                          order.totalAmount = total.toString();
                          BlocProvider.of<OrderBloc>(context)
                              .add(CreateOrderEvent(order));
                        }: (){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Update the address"),
                          ));
                        },
                        // color: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                        child: Text("Checkout".toUpperCase(),
                            style: TextStyle(fontSize: 20)),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        );
      } else {
        return Text("loading");
      }
    }),
);
  }
}

class CheckoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(left: 0.0, right: 0.0),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 18.0,
                ),
                margin: EdgeInsets.only(top: 13.0, right: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 100,
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                          "Order placed Successfull,\n Thank you for your order \n We will contact you soon'",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                    ) //
                        ),
                    SizedBox(height: 24.0),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)),
                        ),
                        child: Text(
                          "Order Details",
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {

                      },
                    )
                  ],
                ),
              ),
              Positioned(
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
