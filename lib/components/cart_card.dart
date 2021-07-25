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
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/product_details_new.dart';
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
  String currency;


  getCartDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CustomerId = await prefs.getString("customerId");
    if (CustomerId == null) {
      print("customer id null");
    } else {
      print("Login email " + CustomerId);
    }
    currency = prefs.getString('currency');
    BlocProvider.of<CartBloc>(context).add(FetchCartDetailsEvent(CustomerId));
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


    return BlocBuilder<UserBloc, UserState>(
      builder: (context, ustate) {
        return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if(state is CartDetailsLoadingState||state is RemoveAllProductFromCartLoadingState||state is RemoveProductFromCartLoadingState || state is AddProductToCartLoadingState  ){
            return SpinKitRing(color:AppColors.LOGO_ORANGE,size: 40,);
          }
          if(ustate is CustomerInformationLoadedState || ustate is CustomerLoginSuccessState){
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
                        Icon(Icons.shopping_cart_outlined,size: 150,color: AppColors.GREY,),
                        SizedBox(height:10),
                        Text("Cart is Empty",style: TextStyle(
                          color: AppColors.GREY,fontSize: 50
                        ),)
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
                    return Dismissible(
                      key: Key(state.cartItems[index].productId),
                      onDismissed: (direction){
                        state.cartItems[index].productCount =0;
                        BlocProvider.of<CartBloc>(context)
                            .add(RemoveProductFromCartEvent(
                          state.cartItems[index].cartData,
                          state.cartItems[index].userId,
                          state.cartItems[index].productId,
                          state.cartItems[index].productCount.toString()
                        ));
                      },
                      background: Container(
                        color: Colors.red[200],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete_outline_sharp,color: Colors.white,size: 30,),
                              SizedBox(width: 3,),
                              Text('Product Removed',style: TextStyle(color:Colors.white,fontSize: 25),)
                            ],
                          ),
                        ),
                      ),
                      child: Container(
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
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: (){
                                            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                                            //   return ProductDetailsNew(
                                            //     productId: state.cartItems[index].productId,
                                            //   );
                                            // }),ModalRoute.withName('/home'));
                                          },
                                          child: Container(
                                            height: 140,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.GREY_TEXT,width: 1.5),
                                                boxShadow: []),
                                            child: Image.network(
                                                image + state.cartItems[index].productImage,fit: BoxFit.fitWidth,
                                              ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width :MediaQuery.of(context).size.width ,
                                              child: Text(
                                                  state.cartItems[index].productName,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: (TextStyle(
                                                    // fontFamily: 'YanoneKaffeesatz',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Text(currency!=null ?
                                                      currency + " "+
                                                          state
                                                              .cartItems[index].productPrice
                                                              .toString(): state
                                                        .cartItems[index].productPrice
                                                        .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    FlatButton(
                                    height: 30,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(4.0),
                                    onPressed: () {
                                      // Remove From Cart
                                      BlocProvider.of<CartBloc>(context)
                                          .add(RemoveProductFromCartEvent(
                                        state.cartItems[index].cartData,
                                        state.cartItems[index].userId,
                                        state.cartItems[index].productId,
                                        state.cartItems[index].productCount.toString()
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_outline_sharp,color: Colors.red,),
                                        Text(
                                          "Remove",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.red,
                                          ),textAlign: TextAlign.right,
                                        ),
                                      ],
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
                                  Container(
                                      child: CounterTest(
                                        cart: state.cartItems[index],
                                        currency: this.currency,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }else {
              return SpinKitRing(color: AppColors.LOGO_ORANGE,size: 50,);
            }
          } else {
            //print("if cart customerloginstate"+  BlocProvider.of<UserBloc>(context).state.toString());
            //BlocProvider.of<UserBloc>(context).state.toString();
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
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
    Navigator.push(context, route).then(onGoBack);
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      BlocProvider.of<CartBloc>(context).add(FetchCartDetailsEvent(CustomerId));
    });
  }

}

class Counter extends StatefulWidget {
  @override
  Cart cart;

  _CounterState createState() => _CounterState();

  Counter({@required this.cart});
}

class _CounterState extends State<CounterTest> {
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
                    widget.cart.productCount.toString()
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
                widget.cart.productCount =0;
                BlocProvider.of<CartBloc>(context)

                    .add(RemoveProductFromCartEvent(
                  widget.cart.cartData,
                  widget.cart.userId,
                  widget.cart.productId,
                widget.cart.productCount.toString()
                ));
              }),
        ),
      ],
    );
  }
}
class CounterTest extends StatefulWidget {
  @override
  Cart cart;
  String currency;

  _CounterTestState createState() => _CounterTestState();

  CounterTest({@required this.cart,@required this.currency});
}

class _CounterTestState extends State<CounterTest> {
  int _itemCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._itemCount = widget.cart.productCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height * .04 ,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * .30,
        //minHeight: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: AppColors.LOGO_ORANGE,width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _itemCount != 0
              ? IconButton(
              icon: Icon(Icons.remove),
              iconSize: 20,
              onPressed: () {
                print('remove 1');
               // widget.cart.productCount--;
                if (widget.cart.productCount <= 0) {
                  // Remove From Cart
                  print('remove 2');
                  BlocProvider.of<CartBloc>(context)
                      .add(RemoveProductFromCartEvent(
                    widget.cart.cartData,
                    widget.cart.userId,
                    widget.cart.productId,
                    widget.cart.productCount.toString()

                  ));
                } else{
                  print('remove 3');
                  widget.cart.productCount =1;
                  BlocProvider.of<CartBloc>(context)
                      .add(RemoveProductFromCartEvent(
                    widget.cart.cartData,
                    widget.cart.userId,
                    widget.cart.productId,
                    widget.cart.productCount.toString()

                  ));
                }
                setState(() => _itemCount--);
              })
              : IconButton(
              icon: Icon(Icons.remove),
              iconSize: 20,
              onPressed: () {
                print('remove 4');
                widget.cart.productCount = 0;
                BlocProvider.of<CartBloc>(context)
                    .add(RemoveProductFromCartEvent(
                  widget.cart.cartData,
                  widget.cart.userId,
                  widget.cart.productId,
                  widget.cart.productCount.toString(),
                ));
              }),

          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * .04,
            ),
              decoration: BoxDecoration(
                color: AppColors.WHITE,

                border: Border(left: BorderSide(
                    color: AppColors.LOGO_ORANGE,width: 1.0
                ),
                right:BorderSide(
                    color: AppColors.LOGO_ORANGE,width: 1.0
                ) ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,3, 10, 3),
                child: Text(_itemCount.toString(),style: TextStyle(fontSize: 20),),
              )),


          IconButton(
              icon: Icon(Icons.add),
              iconSize: 20,
              onPressed: () {

                widget.cart.productCount = 1;
               widget.cart.currency = widget.currency;
                BlocProvider.of<CartBloc>(context)
                    .add(AddProductToCart(widget.cart));
              }),
        ],
      ),
    );
  }
}
