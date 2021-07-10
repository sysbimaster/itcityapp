import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/cart.dart';
import 'package:itcity_online_store/api/models/customer_wishlist.dart';
import 'package:itcity_online_store/api/models/wishlist.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/cart/cart.dart';
import 'package:itcity_online_store/blocs/user/user_bloc.dart';
import 'package:itcity_online_store/blocs/user/user_event.dart';
import 'package:itcity_online_store/blocs/user/user_state.dart';
import 'package:itcity_online_store/blocs/wishlist/wishlist_bloc.dart';
import 'package:itcity_online_store/blocs/wishlist/wishlist_event.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String image =
    'https://www.itcityonlinestore.com/uploads/product/single-product/';

class CartCard extends StatefulWidget {
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  CartBloc _cartBloc;
  UserBloc _userBloc;
  double total;
  String CustomerId;


  getCartDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CustomerId = await prefs.getString("customerId");
    if (CustomerId == null) {
      print("customer id null");
    } else {
      print("Login email " + CustomerId);
    }
    _cartBloc.add(FetchCartDetailsEvent(CustomerId));
  }
  @override
  void initState() {
    getCartDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CustomerWishlist> customerWishList = [];
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    // final storage = new FlutterSecureStorage();
    // storage.read(key: "customerId").then((value) {
    //   CustomerId = value;
    //   if (value == null) {
    //     print("customer id null");
    //   } else {
    //     print("Login email " + CustomerId);
    //   }
    //   _cartBloc.add(FetchCartDetailsEvent(value));
    // });
    // return BlocBuilder<WishlistBloc, WishlistState>(
    //   builder: (context, state) {
    //     if (state is WishlistLoadedState) {
    //       customerWishList = state.wishlist;
    //     }

    //   },
    // );

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, ustate) {
        return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if(ustate is CustomerLoginSuccessState || ustate is CustomerInformationLoadedState){
            print("if cart customerloginstate");
            if (state is CartDetailsLoadedState){
              if(state.cartItems.length == 0) {
                return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined,size: 100,color: Colors.deepOrangeAccent[100],),
                        SizedBox(height:10),
                        Text("Cart is Empty",style: Theme.of(context).textTheme.headline6,)
                      ],
                    ));
              }
              return ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    Wishlist wish = Wishlist();
                    wish.wishlist = state.cartItems[index].productId;

                    bool isFavourite = false;
                    customerWishList.forEach((element) {
                      if (element.productId == wish.wishlist) {
                        isFavourite = true;
                      }
                    });
                    print(state.cartItems[index].productPrice.toString() +
                        "dkkjdkjskdjksjdkjskdjskjdklj");
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.GREY,width: 1.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 8),
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: []),
                                        child: Image.network(
                                            image + state.cartItems[index].productImage,
                                            width: 100,
                                            height: 100),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 200,
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              state.cartItems[index].productName,
                                              overflow: TextOverflow.ellipsis,
                                              style: (TextStyle(
                                                // fontFamily: 'YanoneKaffeesatz',
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              )),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  "KWD " +
                                                      state
                                                          .cartItems[index].productPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            child: Counter(
                                              cart: state.cartItems[index],
                                            ))),
                                  ],
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                FlatButton(
                                height: 40,
                                color: Colors.white,
                                padding: EdgeInsets.all(8.0),
                                onPressed: () {
                                  // Remove From Cart
                                  BlocProvider.of<CartBloc>(context)
                                      .add(RemoveProductFromCartEvent(
                                    state.cartItems[index].cartData,
                                    state.cartItems[index].userId,
                                    state.cartItems[index].productId,
                                  ));
                                },
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),textAlign: TextAlign.right,
                                ),
                              ),
                              // FlatButton(
                              //   height: 40,
                              //   color: Colors.white,
                              //   padding: EdgeInsets.all(8.0),
                              //   onPressed: () {
                              //     final storage = new FlutterSecureStorage();
                              //     storage.read(key: "email").then((value) {
                              //       wish.username = value;
                              //       if (isFavourite) {
                              //         BlocProvider.of<WishlistBloc>(context)
                              //             .add(RemoveProductFromWishlistEvent(
                              //                 wish));
                              //       } else {
                              //         BlocProvider.of<WishlistBloc>(context)
                              //             .add(AddProductToWishlist(wish));
                              //       }
                              //     });
                              //   },
                              //   child: Text(
                              //     "Move to Wishlist",
                              //     style: TextStyle(
                              //         fontSize: 15.0, color: Colors.orange),
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }else {
              return SpinKitRing(color: Colors.black,size: 20,);
            }
          } else {
            //print("if cart customerloginstate"+  BlocProvider.of<UserBloc>(context).state.toString());
            BlocProvider.of<UserBloc>(context).state.toString();
            return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,size: 100,color: Colors.deepOrangeAccent[100],),
                    SizedBox(height:10),
                    Text("Cart is Empty",style: Theme.of(context).textTheme.headline6,),
                    SizedBox(
                      height: 15.0,
                    ),

                    Text("Please Log in / Sign up to add products to cart"),
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
                        onPressed: navigateLoginPage,
                        child: Text("Login / Sign Up".toUpperCase(),
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),


                  ],
                ));
          }
        });
      },
    );
  }

  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPage());
    Navigator.push(context, route).then(onGoBack);
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

}

class Counter extends StatefulWidget {
  @override
  Cart cart;

  _CounterState createState() => _CounterState();

  Counter({@required this.cart});
}

class _CounterState extends State<Counter> {
  int _itemCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._itemCount = widget.cart.productCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 35,
          height: 35,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: IconButton(
              icon: Icon(Icons.add),
              iconSize: 12,
              onPressed: () {
                widget.cart.productCount++;
                BlocProvider.of<CartBloc>(context)
                    .add(AddProductToCart(widget.cart));
              }),
        ),
        SizedBox(width: 3),
        Text(_itemCount.toString()),
        SizedBox(width: 3),
        _itemCount != 0
            ? Container(
          width: 35,
          height: 35,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: IconButton(
              icon: Icon(Icons.remove),
              iconSize: 12,
              onPressed: () {
                widget.cart.productCount--;
                if (widget.cart.productCount <= 0) {
                  // Remove From Cart
                  BlocProvider.of<CartBloc>(context)
                      .add(RemoveProductFromCartEvent(
                    widget.cart.cartData,
                    widget.cart.userId,
                    widget.cart.productId,
                  ));
                }
                setState(() => _itemCount--);
              }),
        )
            : Container(
          width: 35,
          height: 35,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: IconButton(
              icon: Icon(Icons.remove),
              iconSize: 12,
              onPressed: () {
                BlocProvider.of<CartBloc>(context)
                    .add(RemoveProductFromCartEvent(
                  widget.cart.cartData,
                  widget.cart.userId,
                  widget.cart.productId,
                ));
              }),
        ),
      ],
    );
  }
}
