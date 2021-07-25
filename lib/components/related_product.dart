import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/product_details_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
class RelatedProduct extends StatefulWidget {
  final String productBrand;
  final String currency;
  RelatedProduct({this.productBrand,this.currency});
  @override
  _RelatedProductState createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context)
        .add(FetchRelatedProductByProductBrand(widget.productBrand,widget.currency));
  }
  void dispose() {
    super.dispose();
  }
  bool _isFavorited = false;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      List<Product> products =
          BlocProvider.of<ProductBloc>(context).relatedProduct;

      print('State of related product list =>' + state.toString());

      if (state is RelatedProductByProductBrandLoadingState) {
        print('circular');
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is RelatedProductByProductBrandErrorState) {
        // return Center(
        //   child: CircularProgressIndicator(),
        // );
      }
      if (products.length == 0) {
        return (Container(
          height: 200,
          child: Center(child: Text('No Related Products Found')),
        ));
      }
      return Container(

        color: Colors.white12,
        child:  GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .60,
              mainAxisSpacing: 5,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailsNew(
                      productId: products[index].productId,
                    );
                  }));
                },
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
                                image: NetworkImage(products[index] == null
                                    ? ''
                                    : productImage + products[index].productImage),
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
                                          products[index] == null
                                              ? ''
                                              : products[index].productName,

                                          maxLines: 2,
                                          // softWrap: false,
                                          // overflow: TextOverflow.fade,

                                          style: (TextStyle(
                                            fontFamily: 'Myriad-semi',
                                            // fontFamily: 'YanoneKaffeesatz',

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
                                          widget.currency != null ? Container(

                                              child:Text(
                                                  widget.currency +
                                                      ' ' +
                                                      products[index].productPrice.toStringAsFixed(2),
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

                                              child: Text(
                                                  widget.currency +
                                                      ' ' +
                                                      products[index].productPriceOffer.toStringAsFixed(2),
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
                                                    cart.cartData = products[index] == null
                                                        ? ''
                                                        : products[index].productId.toString();
                                                    cart.userId = prefs.getString('customerId');
                                                    cart.productCount = 1;
                                                    cart.productPrice =
                                                    products[index].productPrice != null
                                                        ? double.parse( products[index].productPrice)
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
                              wish.wishlist = products[index].productId;
                              if(prefs.containsKey('email')) {
                                wish.username = prefs.getString('email');
                                BlocProvider.of<WishlistBloc>(context)
                                    .add(RemoveProductFromWishlistEvent(wish,widget.currency));
                                print('product is removing from wishlist>>>>>>>>>>>>>');
                                _toggleFavorite();
                                if (state is RemoveProductFromWishlistLoadingState)
                                  return (Center(child: CircularProgressIndicator(),));
                              }
                            } else if (_isFavorited == false) {

                              //  final storage = new FlutterSecureStorage();
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if(prefs.containsKey('email')){
                                setState(() {
                                  Wishlist wish = Wishlist();
                                  wish.wishlist = products[index].productId;

                                  wish.username = prefs.getString('email');

                                  BlocProvider.of<WishlistBloc>(context)
                                      .add(AddProductToWishlist(wish));
                                  _toggleFavorite();
                                  print(_isFavorited.toString());
                                  if (state
                                  is AddProductToWishlistLoadingState) {
                                    return (Center(
                                      child: CircularProgressIndicator(),
                                    ));
                                  }
                                });
                              } else {

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
            }),
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
}
