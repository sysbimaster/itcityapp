import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:itcity_online_store/api/models/models.dart';

import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigationProductNew extends StatefulWidget {
  final Product? product;
  int? quantity;
  BottomNavigationProductNew({this.product, this.quantity});

  @override
  _BottomNavigationProductNewState createState() =>
      _BottomNavigationProductNewState();
}

class _BottomNavigationProductNewState
    extends State<BottomNavigationProductNew> {
  String? userId ;
  String? token = '';
  String? currency;
  bool buyNowPressed = false;
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("customerId");
    token = prefs.getString("token");
    currency = prefs.getString('currency');
    //   userId = await _flutterSecureStorage.read(key: "customerId");
    //  token = await _flutterSecureStorage.read(key: "token");
  }
  @override
  void initState() {
    getEmail();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
                  color: Colors.white,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MaterialButton(
                          color: AppColors.LOGO_ORANGE,
                          textColor: Colors.white,
                          height: 40,
                          minWidth: MediaQuery.of(context).size.width *.80,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          onPressed: () {
                            if (userId != null) {
                              if(widget.quantity != null || widget.quantity! > 0 ){
                                print("widget quantity" + widget.quantity.toString());
                                addProductToCart();
                                this.buyNowPressed = true;

                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: AppColors.LOGO_ORANGE,
                                  content: Text('Product is Out of Stock'),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                              //
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return LoginPageNew();
                                  }));
                            }
                          },
                          child: Text("BUY NOW",style: TextStyle(fontSize: 25),)),
                      MaterialButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          height: 45,
                          minWidth:MediaQuery.of(context).size.width *.10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          onPressed: () {
                            if (userId != null) {
                              if(widget.quantity != null || widget.quantity! > 0 ){

                                addProductToCart();

                                // setState(() {
                                //   buyNowPressed = true;
                                // });
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: AppColors.LOGO_ORANGE,
                                  content: Text('Product is Out of Stock'),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                              //
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return LoginPageNew();
                                  }));
                            }

                          },
                          child: Container(
                            color: Colors.black,
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart_outlined,color: AppColors.LOGO_ORANGE,size: 20,), onPressed: null,
                            ),
                          ))
                    ],
                  ),
                );

  }

  void addProductToCart() {
    Cart cart = Cart();
    cart.cartData = widget.product == null
        ? ''
        : widget.product!.productId.toString();
    cart.userId = userId;
    cart.productCount = 1;
    cart.productPrice =
    widget.product!.productPrice != null
        ? widget.product!.productPrice.toDouble()
        : 0.0;
    cart.currency = this.currency;
    BlocProvider.of<CartBloc>(context)
        .add(AddProductToCart(cart,"bottom nav"));
  }
  }


