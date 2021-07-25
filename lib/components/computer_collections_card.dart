import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/product_details_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ComputerCollectionsCard extends StatefulWidget {
  Product product;
  String currency;
 ComputerCollectionsCard({Key key,this.product,this.currency}) : super(key: key);

  @override
  _ComputerCollectionsCardState createState() => _ComputerCollectionsCardState();
}

class _ComputerCollectionsCardState extends State<ComputerCollectionsCard> {
  bool _isFavorited = false;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
  builder: (context, state) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailsNew(
            productId: widget.product.productId,
          );
        }));
      },
      child: Card(
        elevation: 2,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 50,
                width: MediaQuery.of(context).size.width * .45,
                child: Column(

                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 160.0,
                        width: 140.0,
                        //margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(widget.product== null
                                ? ''
                                : productImage + widget.product.productImage,),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.product == null
                                ? 'Computer'
                                : 'Computer',
                            maxLines: 2,
                            // softWrap: false,
                            // overflow: TextOverflow.fade,

                            style: (TextStyle(
                              // fontFamily: 'YanoneKaffeesatz',
                              color: AppColors.LOGO_ORANGE,

                              fontSize: 15,

                            )),textAlign: TextAlign.left,)),
                      Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.product == null
                                ? ''
                                : widget.product.productName,
                            maxLines: 2,
                            // softWrap: false,
                            // overflow: TextOverflow.fade,

                            style: (TextStyle(
                              // fontFamily: 'YanoneKaffeesatz',
                              color: AppColors.LOGO_BLACK,

                              fontSize: 15,

                            )),textAlign: TextAlign.left,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          widget.currency != null ? Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child:Text(
                                  widget.currency +
                                      ' ' +
                                      widget.product.productPriceOffer.toStringAsFixed(2),
                                  style: (TextStyle(
                                    // fontFamily: 'RobotoSlab',
                                    fontSize: 14,

                                    color: AppColors.LOGO_BLACK,
                                    fontWeight: FontWeight.w600,
                                  )))): SpinKitCircle(
                            size: 10,color: AppColors.LOGO_ORANGE,
                          ),

                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            height: 32,
                            width: MediaQuery.of(context).size.width *.42,
                            child: TextButton(

                              child: Text('ADD TO CART', style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              style: ButtonStyle(
                                  foregroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.LOGO_ORANGE),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14.0),
                                          side: BorderSide(color:AppColors.LOGO_ORANGE)
                                      )
                                  )
                              ),
                              onPressed: () async {
                                SharedPreferences prefs =
                                await SharedPreferences
                                    .getInstance();
                                if (prefs.containsKey("customerId")) {
                                  Cart cart = Cart();
                                  cart.cartData = widget.product == null
                                      ? ''
                                      : widget.product.productId
                                      .toString();
                                  cart.userId =
                                      prefs.getString('customerId');
                                  cart.productCount = 1;
                                  cart.productPrice = widget.product.productPrice !=
                                      null
                                      ?
                                  widget.product.productPrice
                                      : 0.0;
                                  cart.currency = widget.currency;
                                  BlocProvider.of<CartBloc>(context)
                                      .add(AddProductToCart(cart));
                                  print('customer id');
                                } else {
                                  print('no customer id');
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Text(
                                              "Please Login to add products to the Cart",
                                              style: TextStyle(
                                                  fontSize: 18),
                                              textAlign:
                                              TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .width *
                                                  .75,
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                        AppColors
                                                            .LOGO_ORANGE),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10.0),
                                                        side: BorderSide(
                                                            color: Colors
                                                                .red))),
                                                    foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                        AppColors
                                                            .WHITE),
                                                  ),
                                                  onPressed:
                                                  navigateLoginPage,
                                                  child: Text(
                                                    "SIGN IN",
                                                    style: TextStyle(
                                                        fontSize: 18),
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },),
                          ))
                    ]
                )),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:IconButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    if (_isFavorited == true) {
                      Wishlist wish = Wishlist();
                      print("is favorited"+_isFavorited.toString());
                      wish.wishlist =  widget.product.productId;
                      if (prefs.containsKey('email')) {
                        wish.username = prefs.getString('email');
                        BlocProvider.of<WishlistBloc>(context)
                            .add(RemoveProductFromWishlistEvent(wish,widget.currency));
                        print(
                            'product is removing from wishlist>>>>>>>>>>>>>');
                        _toggleFavorite();
                        if (state is RemoveProductFromWishlistLoadingState)
                          return (Center(
                            child: CircularProgressIndicator(),
                          ));
                      }
                    } else if (_isFavorited == false) {
                      print("is favorited"+_isFavorited.toString());
                      //  final storage = new FlutterSecureStorage();
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      if (prefs.containsKey('email')) {
                        setState(() {
                          Wishlist wish = Wishlist();
                          wish.wishlist =  widget.product.productId;

                          wish.username = prefs.getString('email');

                          BlocProvider.of<WishlistBloc>(context)
                              .add(AddProductToWishlist(wish));
                          _toggleFavorite();
                          print(_isFavorited.toString());
                          if (state is AddProductToWishlistLoadingState) {
                            return (Center(
                              child: CircularProgressIndicator(),
                            ));
                          }
                        });
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Please Login to add products to Favourites"),
                            ));
                      }
                    }
                  },
                  icon: (_isFavorited
                      ? Icon(
                    Icons.favorite,
                    color: AppColors.LOGO_ORANGE,
                  )
                      : Icon(
                    Icons.favorite_border,
                    color: AppColors.GREY,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
    Navigator.push(context, route).then(onGoBack);
  }

  FutureOr onGoBack(dynamic value) {
    Navigator.of(context).pop();
  }
}
