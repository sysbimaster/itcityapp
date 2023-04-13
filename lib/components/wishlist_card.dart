import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/product_details_new.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WishlistCard extends StatefulWidget {
  final CustomerWishlist wishlist;
  final VoidCallback? onDelete;
  WishlistCard({Key? key, required this.wishlist, this.onDelete})
      : super(key: key);
  @override
  WishlistCardState createState() => WishlistCardState();
}

class WishlistCardState extends State<WishlistCard> {
  String? contact;
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
  String? country;
  String? currency;
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
    return BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      return GestureDetector(
        onTap: navigateDetailsPage,

        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .49,
              constraints: BoxConstraints(
                  minHeight: 230),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.GREY,width: 1.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Container(

                    height: 190.0,
                    width: 170.0,
                    //margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(widget.wishlist == null
                            ? ''
                            : productImage + widget.wishlist.productImage!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5, right: 5,top:10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                minHeight: 37,
                              ),
                              alignment: Alignment.topLeft,
                              child: Text(
                                  widget.wishlist == null
                                      ? ''
                                      : widget.wishlist.productName!,

                                  maxLines: 2,
                                  // softWrap: false,
                                  // overflow: TextOverflow.fade,

                                  style: (TextStyle(
                                    fontFamily: 'Myriad-semi',
                                    // fontFamily: 'YanoneKaffeesatz',

                                    fontSize: 15,

                                  )))),
                          Divider(
                            thickness: 2.0,
                            color: AppColors.GREY,

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  currency != null ? Container(

                                      child:Text(
                                          currency! +
                                              ' ' +
                                              widget.wishlist.productPrice.toStringAsFixed(2),
                                          style: (TextStyle(
                                            fontFamily: 'Arial',
                                            // fontFamily: 'RobotoSlab',
                                            fontSize: 12,
                                            decoration:
                                            TextDecoration.lineThrough,
                                            color: Colors.deepOrangeAccent,
                                            // fontWeight: FontWeight.w800,
                                          )))): SpinKitCircle(
                                    size: 10,color: AppColors.LOGO_ORANGE,
                                  ),
                                  SizedBox(
                                    height: 2,
                                    width: 2,
                                  ),
                                  currency != null ?Container(

                                      child:Text(
                                          currency! +
                                              ' ' +
                                              widget.wishlist.productPriceOffer.toStringAsFixed(2),
                                          style: (TextStyle(
                                            fontFamily: 'Arial',
                                            // fontFamily: 'RobotoSlab',
                                            fontSize: 14,
                                            //decoration:
                                            //TextDecoration.lineThrough,
                                            color: AppColors.LOGO_BLACK,
                                            fontWeight: FontWeight.bold,
                                          )))):SpinKitCircle(
                                    size: 10,color: AppColors.LOGO_ORANGE,
                                  ),
                                ],
                              ),


                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: AppColors.LOGO_ORANGE,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: IconButton(

                                        icon: Icon(
                                          Icons.shopping_cart_outlined,
                                          color: AppColors.WHITE,
                                        ),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          if (prefs.containsKey("customerId")) {
                                            Cart cart = Cart();
                                            cart.cartData = widget.wishlist == null
                                                ? ''
                                                :  widget.wishlist.productId.toString();
                                            cart.userId = prefs.getString('customerId');
                                            cart.productCount = 1;
                                            cart.productPrice =
                                            widget.wishlist.productPrice != null
                                                ?  widget.wishlist.productPrice
                                                : 0.0;
                                            BlocProvider.of<CartBloc>(context)
                                                .add(AddProductToCart(cart,"wishlist card"));

                                          } else {

                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 35,
                                                      ),
                                                      Text(
                                                        "Please Login to add products to the Cart",
                                                        style: TextStyle(fontSize: 18),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        width : MediaQuery.of(context).size.width * .75,
                                                        child: TextButton(

                                                            style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty
                                                                  .all<Color>(
                                                                  AppColors.LOGO_ORANGE),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                  borderRadius:BorderRadius.circular(10.0),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .red))),
                                                              foregroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                  AppColors
                                                                      .WHITE),
                                                            ),
                                                            onPressed: navigateLoginPage,
                                                            child: Text(
                                                              "SIGN IN",
                                                              style:
                                                              TextStyle(fontSize: 18),
                                                              textAlign: TextAlign.center,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: 35,
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }
                                        }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: IconButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if (_isFavorited == true) {
                      Wishlist wish = Wishlist();
                      wish.wishlist = widget.wishlist.productId;
                      if(prefs.containsKey('email')) {
                        wish.username = prefs.getString('email');
                        BlocProvider.of<WishlistBloc>(context)
                            .add(RemoveProductFromWishlistEvent(wish,this.currency));

                        _toggleFavorite();
                        if (state is RemoveProductFromWishlistLoadingState)
                       Center(child: CircularProgressIndicator(),);
                      }
                    } else if (_isFavorited == false) {

                      //  final storage = new FlutterSecureStorage();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if(prefs.containsKey('email')){
                        setState(() {
                          Wishlist wish = Wishlist();
                          wish.wishlist = widget.wishlist.productId;

                          wish.username = prefs.getString('email');

                          BlocProvider.of<WishlistBloc>(context)
                              .add(AddProductToWishlist(wish));
                          _toggleFavorite();

                          if (state
                          is AddProductToWishlistLoadingState) {
                           Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Please Login to add products to Favourites"),
                            ));
                      }

                    }
                  },

                  icon: (_isFavorited
                      ? Icon(Icons.favorite,color: AppColors.LOGO_ORANGE,)
                      : Icon(Icons.favorite_border,color: AppColors.GREY,)),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
    Navigator.push(context, route).then(onGoBack);


  }
  FutureOr onGoBack(dynamic value) {
    Navigator.pop(context);
  }
  void navigateDetailsPage() {
    Route route = MaterialPageRoute(builder: (context) => ProductDetailsNew(
      productId: widget.wishlist.productId,
    ));
    Navigator.push(context, route).then(onGoBacktwo);


  }
  FutureOr onGoBacktwo(dynamic value) {
    BlocProvider.of<ProductBloc>(context).add(FetchFeaturedProductFull(currency));


  }
}
