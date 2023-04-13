import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/review/random_review_bloc.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/product_details_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ProductCard extends StatefulWidget {
  Product? product;
  String? currency;
  double? rrating;
   ProductCard({Key? key,this.product,this.currency,this.rrating}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorited = false;
  double? rating;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  void initState() {
    BlocProvider.of<RandomReviewBloc>(context).add(FetchReview());
    //getCountry();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
  builder: (context, state) {
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

            height: MediaQuery.of(context).size.height*.25,
        width: MediaQuery.of(context).size.width * .48,
                  //margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(widget.product == null
                          ? ''
                          : productImage + widget.product!.productImage!),
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
                                widget.product == null
                                    ? ''
                                    : widget.product!.productName!,

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
                                widget.currency != null ? Container(

                                    child:Text(
                                        widget.currency! +
                                            ' ' +
                                            widget.product!.productPrice.toStringAsFixed(2),
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
                                widget.currency != null ?Container(

                                    child:Text(
                                        widget.currency! +
                                            ' ' +
                                            widget.product!.productPriceOffer.toStringAsFixed(2),
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
                                          cart.cartData = widget.product == null
                                              ? ''
                                              :  widget.product!.productId.toString();
                                          cart.userId = prefs.getString('customerId');
                                          cart.productCount = 1;
                                          cart.productPrice =
                                          widget.product!.productPrice != null
                                              ? double.parse(widget.product!.productPrice.toString())
                                              : 0.0;
                                          cart.currency = widget.currency;
                                          BlocProvider.of<CartBloc>(context)
                                              .add(AddProductToCart(cart,'product_card'));

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
                    wish.wishlist = widget.product!.productId;
                    if(prefs.containsKey('email')) {
                      wish.username = prefs.getString('email');
                      BlocProvider.of<WishlistBloc>(context)
                          .add(RemoveProductFromWishlistEvent(wish,widget.currency));

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
                        wish.wishlist = widget.product!.productId;

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
          ),
         Positioned(
            left:8,
            top: 8,

            child: BlocBuilder<RandomReviewBloc, RandomReviewState>(
              builder: (context,state){

                if(state is RandomReviewLoaded){
                  this.rating = BlocProvider.of<RandomReviewBloc>(context).ratingReview;

                  return Container(
                      decoration: BoxDecoration(

                          color: AppColors.WHITE,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.star,color: AppColors.LOGO_ORANGE,size: 20,),
                          Text(widget.rrating!= null?  widget.rrating!.toStringAsFixed(1):rating!.toStringAsFixed(1),style: TextStyle(
                            fontFamily: 'Arial',
                            // fontFamily: 'RobotoSlab',
                            fontSize: 14,
                            //decoration:
                            //TextDecoration.lineThrough,
                            color: AppColors.LOGO_BLACK,
                           // fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                  );

                }
                return Container();

              },
            ),
          )
        ],
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
    Navigator.pop(context);
  }
  void navigateDetailsPage() {
    Route route = MaterialPageRoute(builder: (context) => ProductDetailsNew(
      productId: widget.product!.productId,
    ));
    Navigator.push(context, route).then(onGoBacktwo);


  }
  FutureOr onGoBacktwo(dynamic value) {
    BlocProvider.of<ProductBloc>(context).add(FetchFeaturedProductFull(widget.currency));


  }
}
