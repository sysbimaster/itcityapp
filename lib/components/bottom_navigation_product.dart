
import 'package:flutter/material.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';

import 'package:shared_preferences/shared_preferences.dart';

//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class BottomNavigationProduct extends StatefulWidget {
  final Product? product;
  int? quantity;
  BottomNavigationProduct({this.product, this.quantity});
  @override
  _BottomNavigationProductState createState() =>
      _BottomNavigationProductState();
}

class _BottomNavigationProductState extends State<BottomNavigationProduct> {
  String? userId = '';
  String? token = '';
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("customerId");
    token = prefs.getString("token");

  }


  @override
  void initState() {
    super.initState();
    getEmail();


  }

  @override
  Widget build(BuildContext context) {
    int? productQuantity =
        widget.product == null ? 0 : widget.product!.productQty;
    return BlocBuilder<OrderBloc, OrderState>(
        builder: (context, orderState) {
      return BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
            return Container(
              color: Colors.white,
              height: 55,
              child: widget.quantity != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MaterialButton(
                            color: Colors.deepOrangeAccent,
                            textColor: Colors.white,
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width / 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onPressed: () {
                              if (state is CustomerLoginSuccessState|| state is CustomerInformationLoadedState) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CartPage();
                                }));
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPageNew();
                                }));
                              }
                            },
                            child: Text("GO TO CART")),
                        MaterialButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width / 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onPressed: () {
                              widget.quantity = 0;
                              Cart cart = Cart();
                              cart.cartData = widget.product == null
                                  ? ''
                                  : widget.product!.id.toString();
                              cart.userId = userId;
                              cart.productCount = 1;
                              cart.productPrice =
                                  widget.product!.productPrice != null
                                      ? widget.product!.productPrice
                                      : 0.0;
                              // BlocProvider.of<CartBloc>(context).add(
                              //     RemoveProductFromCartEvent(cart.cartData,
                              //         cart.userId, widget.product.productId));
                            },
                            child: Text("REMOVE FROM CART"))
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Builder(
                          builder: (context) => MaterialButton(
                            height: 40,
                            minWidth: MediaQuery.of(context).size.width / 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            onPressed: () {
                              
                              if (widget.product!.productQty == 0 ||
                                  widget.quantity ==
                                      widget.product!.productQty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  content: Text('Product is Out of Stock'),
                                  duration: Duration(seconds: 3),
                                ));
                              } else {
                                if (state is CustomerLoginSuccessState || state is CustomerInformationLoadedState) {

                                  widget.quantity = widget.quantity! + 1;
                                Cart cart = Cart();
                                cart.cartData = widget.product == null
                                    ? ''
                                    : widget.product!.id.toString();
                                cart.userId = userId;
                                cart.productCount = 1;
                                cart.productPrice =
                                    widget.product!.productPrice != null
                                        ? widget.product!.productPrice
                                        : 0.0;
                                BlocProvider.of<CartBloc>(context)
                                    .add(AddProductToCart(cart,"bottom nav product"));
                                if (cartState is AddProductToCartLoadingState) {
                                   Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                bool? statusCart =
                                    BlocProvider.of<CartBloc>(context).status;
                                bool value =
                                    statusCart == null ? false : statusCart;
                                if (value) {

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Product Added to Cart'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CartPage();
                                  }));
                                } else {
                                  navigateLoginPage();
                                }
                              }
                            },
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                            child: Text("Buy Now".toUpperCase(),
                                style: TextStyle(fontSize: 17)),
                          ),
                        ),
                        Builder(
                          builder: (context) => TextButton(
                            // height: 40,
                            // minWidth: MediaQuery.of(context).size.width / 2,
                            // color: Colors.black,
                            // textColor: Colors.red,
                            // padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              if (widget.product!.productQty == 0 ||
                                  widget.quantity ==
                                      widget.product!.productQty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  content: Text('Product is Out of Stock'),
                                  duration: Duration(seconds: 3),
                                ));
                              } else {
                                widget.quantity = widget.quantity! + 1;
                                // this.widget.onQuantityChange(widget.quantity);
                                Cart cart = Cart();
                                cart.cartData = widget.product == null
                                    ? ''
                                    : widget.product!.id.toString();
                                cart.userId = userId;
                                cart.productCount = 1;
                                cart.productPrice =
                                    widget.product!.productPrice != null
                                        ? widget.product!.productPrice
                                        : 0.0;
                                BlocProvider.of<CartBloc>(context)
                                    .add(AddProductToCart(cart,"bottom nav product"));
                                if (cartState is AddProductToCartLoadingState) {
                                  Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                bool? statusCart =
                                    BlocProvider.of<CartBloc>(context).status;
                                bool value =
                                    statusCart == null ? false : statusCart;
                                if (value) {

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Product Added to Cart'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              }
                            },
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          });
        },
      );
    });
  }
  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
   // Navigator.push(context, route).then(onGoBack);

  }

}
