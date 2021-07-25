import 'package:flutter/material.dart';
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

class MobileCollectionsCard extends StatefulWidget {
  Product product;
  String currency;
 MobileCollectionsCard({Key key,this.currency,this.product}) : super(key: key);

  @override
  _MobileCollectionsCardState createState() => _MobileCollectionsCardState();
}

class _MobileCollectionsCardState extends State<MobileCollectionsCard> {
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
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * .25,
                  width: MediaQuery.of(context).size.width * .33,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 100.0,
                          width: 110.0,
                          //margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(widget.product == null
                                  ? ''
                                  : productImage + widget.product.productImage,),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.product == null
                                  ? ''
                                  : widget.product.productName,
                              maxLines: 2,
                              // softWrap: false,
                              // overflow: TextOverflow.fade,

                              style: (TextStyle(
                                fontFamily: 'Myriad-semi',
                                // fontFamily: 'YanoneKaffeesatz',
                                color: AppColors.LOGO_ORANGE,

                                fontSize: 16,

                              )),textAlign: TextAlign.center,)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                           widget.currency != null ? Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Text(
                                    widget.currency +
                                        ' ' +
                                        widget.product.productPriceOffer.toStringAsFixed(2),
                                    style: (TextStyle(
                                      fontFamily: 'Arial',
                                      // fontFamily: 'RobotoSlab',
                                      fontSize: 14,

                                      color: AppColors.LOGO_BLACK,
                                      fontWeight: FontWeight.bold,
                                    )))): SpinKitCircle(
                              size: 10,color: AppColors.LOGO_ORANGE,
                            ),

                          ],
                        ),
                      ]
                  )),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: IconButton(
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
        );
      },
    );
  }
}
