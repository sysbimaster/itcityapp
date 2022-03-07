import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/cart.dart';
import 'package:itcity_online_store/api/models/customer_wishlist.dart';
import 'package:itcity_online_store/api/models/wishlist.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/cart_card.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

String image =
    'https://www.itcityonlinestore.com/uploads/product/single-product/';

class CartCardNew extends StatefulWidget {
  CartCardNew({Key key}) : super(key: key);

  @override
  _CartCardNewState createState() => _CartCardNewState();
}

class _CartCardNewState extends State<CartCardNew> {
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
  List<CustomerWishlist> customerWishList = [];
@override
  void initState() {
  getCartDetails();
    // TODO: implement initState
    super.initState();
  }
  List<Cart> cartItems =[];
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is AddProductToCartLoadingState ) {
          // print('this worked');
          // showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (BuildContext context) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     });
        } else if ( state is AddProductToCartSuccessState) {
          // print('thisworked');
          // Navigator.canPop(context);
          // Navigator.canPop(context);
        }
        // TODO: implement listener
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, ustate) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if(ustate is CustomerInformationLoadedState || ustate is CustomerLoginSuccessState){
                if(state is CartDetailsLoadedState || state is AddProductToCartLoadingState ||  state is CartRefreshLoadingState ){
                  cartItems = BlocProvider.of<CartBloc>(context).currentCartList;
                  print("refreshed");
                  if(cartItems.length == 0) {
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
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        Wishlist wish = Wishlist();
                        wish.wishlist =cartItems[index].productId;

                        bool isFavourite = false;
                        customerWishList.forEach((element) {
                          if (element.productId == wish.wishlist) {
                            isFavourite = true;
                          }
                        });
                        print(cartItems[index].productPrice.toString() +
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
                                                image + cartItems[index].productImage,fit: BoxFit.fitWidth,
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
                                                   cartItems[index].productName,
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
                                                          cartItems[index].productPrice
                                                              .toString(): cartItems[index].productPrice
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
                                          cartItems[index].cartData,
                                          cartItems[index].userId,
                                          cartItems[index].productId,
                                            0.toString()
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
                                          cart: cartItems[index],
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
                        );
                      });
                }

              }else {
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
              return Container(
                child: Center(
                  child: CircularProgressIndicator(

                  ),
                ),
              );
            },
          );
        },
      ),
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
