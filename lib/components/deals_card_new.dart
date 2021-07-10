import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/product_rating_review.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class DealsCardNew extends StatefulWidget {
  DealOfTheDay deal;
  DealsCardNew({Key key, @required this.deal}) : super(key: key);
  @override
  _DealsCardNewState createState() => _DealsCardNewState();
}

class _DealsCardNewState extends State<DealsCardNew> {
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
          return ProductDetailPage(
            productId: widget.deal.productId,
          );
        }));
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .49,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * .37),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.GREY, width: 1.0),
            ),
            child: Column(
              children: [
                Container(
                  height: 160.0,
                  width: 110.0,
                  //margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(widget.deal == null
                          ? ''
                          : productImage + widget.deal.productImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 10),
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
                                    : widget.deal.productName,
                                maxLines: 2,
                                // softWrap: false,
                                // overflow: TextOverflow.fade,

                                style: (TextStyle(
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
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                    'KWD ' +
                                        widget.deal.productPriceOffer
                                            .toString(),
                                    style: (TextStyle(
                                      //  fontFamily: 'RobotoSlab',
                                      fontSize: 14,

                                      color: AppColors.LOGO_BLACK,
                                      fontWeight: FontWeight.w600,
                                    )))),
                            SizedBox(
                              height: 2,
                              width: 2,
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                    'KWD ' +
                                        widget.deal.productPrice.toString(),
                                    style: (TextStyle(
                                      // fontFamily: 'RobotoSlab',
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.deepOrangeAccent,
                                      // fontWeight: FontWeight.w800,
                                    )))),
                            IconButton(
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (prefs.containsKey("customerId")) {
                                    Cart cart = Cart();
                                    cart.cartData = widget.deal == null
                                        ? ''
                                        : widget.deal.productId.toString();
                                    cart.userId = prefs.getString('customerId');
                                    cart.productCount = 1;
                                    cart.productPrice =
                                        widget.deal.productPrice != null
                                            ? double.parse(widget.deal.productPrice)
                                            : 0.0;
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
                                })
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
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.favorite_border_outlined,
                color: AppColors.GREY,
              ),
            ),
          )
        ],
      ),
    );
  }
  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
    Navigator.push(context, route).then(onGoBack);

  }
  FutureOr onGoBack(dynamic value) {


  }
}
