import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/Currency.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/currency_api.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/review/random_review_bloc.dart';

import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/product_details_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class DealsCardNew extends StatefulWidget {
  DealOfTheDay deal;
  double? rrating;
  DealsCardNew({Key? key, required this.deal,this.rrating}) : super(key: key);
  @override
  _DealsCardNewState createState() => _DealsCardNewState();
}

class _DealsCardNewState extends State<DealsCardNew> {
  final CurrencyApi currencyApi = CurrencyApi();
  String? country;
  String? currency;
  Currency currencyList = Currency();
  String changedProductPrice = '';
  double? rating;
  bool _isFavorited = false;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
  }

  changeCurrency() async {
    Currency changeCurrency = await currencyApi.getChangedCurrency(
        'KWD', this.currency, widget.deal.productPriceOffer);

    setState(() {
      this.currencyList = changeCurrency;
    });
  }

  @override
  void initState() {
    getCountry();
    if (currency != 'KWD') {
      //changeCurrency();
    }
    BlocProvider.of<RandomReviewBloc>(context).add(FetchReview());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double returnAmount;
    String strAmount = widget.deal.productPrice.toString();

    if (strAmount.contains('.')) {
      returnAmount = double.parse(strAmount);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailsNew(
            productId: widget.deal.productId,
          );
        }));
      },
      child: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .48,
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * .40),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.GREY, width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*.22,
                      width: MediaQuery.of(context).size.width * .48,
                      //margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(widget.deal == null
                              ? ''
                              : productImage + widget.deal.productImage!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                constraints: BoxConstraints(
                                  minHeight: 37,
                                ),
                                alignment: Alignment.topLeft,
                                child: Text(
                                    widget.deal == null
                                        ? ''
                                        : widget.deal.productName!,
                                    maxLines: 2,
                                    // softWrap: false,
                                    // overflow: TextOverflow.fade,

                                    style: (TextStyle(
                                       fontFamily: 'Myriad-semi',

                                      fontSize: 16,
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
                                                widget.deal.productPrice.toStringAsFixed(2),
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

                                        child:  Text(
                                            currency! +
                                                ' ' +
                                                widget.deal.productPriceOffer.toStringAsFixed(2),
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
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.shopping_cart_outlined,
                                          color: AppColors.WHITE,
                                        ),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          if (prefs.containsKey("customerId")) {
                                            Cart cart = Cart();
                                            cart.cartData = widget.deal == null
                                                ? ''
                                                : widget.deal.productId
                                                    .toString();
                                            cart.userId =
                                                prefs.getString('customerId');
                                            cart.productCount = 1;
                                            cart.productPrice = widget
                                                        .deal.productPrice !=
                                                    null
                                                ?
                                                    widget.deal.productPrice.toDouble()
                                                : 0.0;
                                            cart.currency = this.currency;
                                            BlocProvider.of<CartBloc>(context)
                                                .add(AddProductToCart(cart,"deals card"));

                                          } else {

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
                                                     
                                                    ],
                                                  );
                                                });
                                          }
                                        }),
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
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (_isFavorited == true) {
                        Wishlist wish = Wishlist();

                        wish.wishlist = widget.deal.productId;
                        if (prefs.containsKey('email')) {
                          wish.username = prefs.getString('email');
                          BlocProvider.of<WishlistBloc>(context)
                              .add(RemoveProductFromWishlistEvent(wish,this.currency));

                          _toggleFavorite();
                          if (state is RemoveProductFromWishlistLoadingState)
                            Center(
                              child: CircularProgressIndicator(),
                            );
                        }
                      } else if (_isFavorited == false) {


                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (prefs.containsKey('email')) {
                          setState(() {
                            Wishlist wish = Wishlist();
                            wish.wishlist = widget.deal.productId;

                            wish.username = prefs.getString('email');

                            BlocProvider.of<WishlistBloc>(context)
                                .add(AddProductToWishlist(wish));
                            _toggleFavorite();

                            if (state is AddProductToWishlistLoadingState) {
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
          );
        },
      ),
    );
  }

  void navigateLoginPage() {
    Navigator.canPop(context);
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
    Navigator.push(context, route).then(onGoBack);
  }

  FutureOr onGoBack(dynamic value) {}
}
