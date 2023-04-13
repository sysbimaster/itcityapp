import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/cart.dart';
import 'package:itcity_online_store/api/models/customer_wishlist.dart';
import 'package:itcity_online_store/api/models/wishlist.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/bottom_navigation_cart.dart';

import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:shared_preferences/shared_preferences.dart';
String image =
    'https://www.itcityonlinestore.com/uploads/product/single-product/';

class CartCardNew extends StatefulWidget {
  CartCardNew({Key? key}) : super(key: key);

  @override
  _CartCardNewState createState() => _CartCardNewState();
}

class _CartCardNewState extends State<CartCardNew> {
  double? total;
  String? CustomerId;
  String? currency;

  int cartcount= 0;

  getCartDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CustomerId = prefs.getString("customerId");
    if (CustomerId == null) {

    } else {

    }
    currency = prefs.getString('currency');

    BlocProvider.of<CartBloc>(context).add(FetchCartDetailsEvent(CustomerId));
  }
  List<CustomerWishlist> customerWishList = [];
  void setCartCount(int cartcount) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setInt('cartcount', cartcount);
  }
@override
  void initState() {
  getCartDetails();
    // TODO: implement initState
    super.initState();
  }
  List<Cart> cartItems =[];
  List<Cart> cartItemsOld =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      bottomNavigationBar: BottomNavigationCartNew(cartItems: cartItems,),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.LOGO_ORANGE,
        title: Text(
          'My Cart',
          style: TextStyle(color:AppColors.WHITE,fontSize: 25),
        ),


        elevation: 1.0,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: [Colors.orange, Colors.deepOrangeAccent])),
        // )
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartRefreshLoadingState||state is RemoveProductFromCartLoadingState) {

            Loader.show(context,
                isAppbarOverlay: true,
                isBottomBarOverlay: false,
                progressIndicator: CircularProgressIndicator(),
                themeData:
                Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
                overlayColor: Colors.black26);
          }else {
            Loader.hide();
          }
          // TODO: implement listener
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, ustate) {
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if(ustate is CustomerInformationLoadedState || ustate is CustomerLoginSuccessState){
                  if(state is CartDetailsLoadedState ||  state is CartRefreshLoadingState || state is AddProductToCartSuccessState
                  || state is AddProductToCartLoadingState||state is CartAddRefreshLoadingState||state is CartAddRefreshLoadedState||state is RemoveProductFromCartLoadingState){
                    cartItems = BlocProvider.of<CartBloc>(context).currentCartList;
                    cartItemsOld =BlocProvider.of<CartBloc>(context).currentCartList;
                    //setCartCount(cartItems.length);


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
                                                  image + cartItems[index].productImage!,fit: BoxFit.fitWidth,
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
                                                     cartItems[index].productName!,
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
                                                        currency! + " "+
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
                                      ElevatedButton(
                                        // height: 30,
                                        // color: Colors.white,
                                        // padding: EdgeInsets.all(4.0),
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
                                       child: CounterTest(cart: cartItemsOld[index],currency: this.currency,),
                                     )

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

                  return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,size: 100,color: Colors.deepOrangeAccent[100],),
                          SizedBox(height:10),
                          Text("Cart is Empty",style: Theme.of(context).textTheme.titleLarge,),
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

class CounterNew extends StatefulWidget {
  @override
  Cart cart;
  String currency;

  _CounterNewState createState() => _CounterNewState();

  CounterNew({required this.cart,required this.currency});
}

class _CounterNewState extends State<CounterNew> {
  int _itemCount = 0;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._itemCount = widget.cart.productCount!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {


        // TODO: implement listener
      },
      child: Container(
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
                icon:widget.cart.productCount! > 1 ? Icon(Icons.remove) :Icon(Icons.delete_outline),
                iconSize: 20,
                onPressed: () {

                  // widget.cart.productCount--;
                  if (widget.cart.productCount! <= 1) {
                    // Remove From Cart

                    BlocProvider.of<CartBloc>(context)
                        .add(RemoveProductFromCartEvent(
                        widget.cart.cartData,
                        widget.cart.userId,
                        widget.cart.productId,
                        0.toString()

                    ));
                  } else{

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
                  child: loading ? SpinKitCircle(
                    color: AppColors.LOGO_ORANGE,
                    size: 25,
                  ) : Text(_itemCount.toString(),style: TextStyle(fontSize: 20),),
                )),


            IconButton(
                icon: Icon(Icons.add),
                iconSize: 20,
                onPressed: () {

                  widget.cart.productCount = 1;
                  widget.cart.currency = widget.currency;
                  BlocProvider.of<CartBloc>(context)
                      .add(AddProductToCart(widget.cart,"cartpage"));
                }),
          ],
        ),
      ),
    );
  }
}
class CounterTest extends StatefulWidget {
  @override
  Cart cart;
  String? currency;

  _CounterTestState createState() => _CounterTestState();

  CounterTest({required this.cart,required this.currency});
}

class _CounterTestState extends State<CounterTest> {
  int _itemCount = 0;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._itemCount = widget.cart.productCount!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if(state is AddProductToCartSuccessState){

        }
        if( state is CartRefreshLoadingState){
          setState(() {
            loading = true;

          });
        }
        else {
          loading = false;
          //  Cart cart = BlocProvider.of<CartBloc>(context).currentCartList.firstWhere((element) => element.productId == widget.cart.productId);
          // setState(() {
          //   this._itemCount = cart.productCount;
          // });


        }

        // TODO: implement listener
      },
      child: Container(
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
                icon:_itemCount > 1 ? Icon(Icons.remove) :Icon(Icons.delete_outline),
                iconSize: 20,
                onPressed: () {

                  // widget.cart.productCount--;
                  if (_itemCount <= 1) {
                    // Remove From Cart

                    BlocProvider.of<CartBloc>(context)
                        .add(RemoveProductFromCartEvent(
                        widget.cart.cartData,
                        widget.cart.userId,
                        widget.cart.productId,
                        0.toString()

                    ));
                  } else{

                    setState(() {
                      _itemCount--;
                    });

                    widget.cart.productCount =1;
                    BlocProvider.of<CartBloc>(context)
                        .add(RemoveProductFromCartEvent(
                        widget.cart.cartData,
                        widget.cart.userId,
                        widget.cart.productId,
                        widget.cart.productCount.toString()

                    ));
                  }

                })
                : IconButton(
                icon: Icon(Icons.remove),
                iconSize: 20,
                onPressed: () {

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
                  child: loading ? SpinKitCircle(
                    color: AppColors.LOGO_ORANGE,
                    size: 25,
                  ) : Text(_itemCount.toString(),style: TextStyle(fontSize: 20),),
                )),


            IconButton(
                icon: Icon(Icons.add),
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    this._itemCount++;
                  });

                  widget.cart.productCount = 1;
                  widget.cart.currency = widget.currency;
                  BlocProvider.of<CartBloc>(context)
                      .add(AddProductToCart(widget.cart,"cartpage"));
                }),
          ],
        ),
      ),
    );
  }
}
