import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatefulWidget {
  final Product product;
  final bool wish;
  ProductList({Key key, @required this.product, this.wish}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  double _userRating = 3.5;
  IconData _selectedIcon;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      if (state is WishlistLoadedState) {
        // _userRating = widget.product.
        print("From Product List Page"+state.toString());
        state.wishlist.forEach((element) {

          if (element.productId == widget.product.productId) {
            print(widget.product.productId +"="+ element.productId);
            this._isFavorited = true;
          }
        });
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProductDetailPage(
                  productId: widget.product.productId,
                  isFavorited: this._isFavorited,
                  onFavourite:(fav){
                    this._isFavorited = fav;
                  }
              );
            }));
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 400,
            ),
            child: Card(
              shadowColor: Colors.lightBlue[100],
              elevation: 2,
              child: Wrap(
                children: [
                  Stack(children: [
                    Container(
                      height: 230.0,
                      width: 190.0,
                      child: Container(
                        height: 200.0,
                        width: 80.0,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(widget.product == null
                                ? ''
                                : image + widget.product.productImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      widthFactor: 5,
                      child: IconButton(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          icon: (_isFavorited
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border)),
                          color: Colors.orange,
                          onPressed: () async {
                            if (_isFavorited == true) {
                              Wishlist wish = Wishlist();
                              wish.wishlist = widget.product.productId;
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              //final storage = new FlutterSecureStorage();
                              if(prefs.containsKey('email')) {
                                wish.username = prefs.getString('email');
                                // BlocProvider.of<WishlistBloc>(context)
                                //     .add(RemoveProductFromWishlistEvent(wish,));
                                print(
                                    'product is removing from wishlist>>>>>>>>>>>>>');
                                _toggleFavorite();
                                if (state
                                is RemoveProductFromWishlistLoadingState) {
                                  return (Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              }

                              // storage.read(key: "email").then((value) {
                              //   wish.username = value;
                              //   BlocProvider.of<WishlistBloc>(context)
                              //       .add(RemoveProductFromWishlistEvent(wish));
                              //   print(
                              //       'product is removing from wishlist>>>>>>>>>>>>>');
                              //   _toggleFavorite();
                              //   if (state
                              //   is RemoveProductFromWishlistLoadingState) {
                              //     return (Center(
                              //       child: CircularProgressIndicator(),
                              //     ));
                              //   }
                              // });
                            }
                            if (_isFavorited == false) {

                            //  final storage = new FlutterSecureStorage();
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if(prefs.containsKey('email')){
                                setState(() {
                                  Wishlist wish = Wishlist();
                                  wish.wishlist = widget.product.productId;
                                  wish.username = prefs.getString('email');

                                  BlocProvider.of<WishlistBloc>(context)
                                      .add(AddProductToWishlist(wish));
                                  _toggleFavorite();
                                  if (state
                                  is AddProductToWishlistLoadingState) {
                                    return (Center(
                                      child: CircularProgressIndicator(),
                                    ));
                                  }
                                });
                              }
                              // storage.read(key: "email").then((value) {
                              //   setState(() {
                              //     Wishlist wish = Wishlist();
                              //     wish.wishlist = widget.product.productId;
                              //     wish.username = value;
                              //
                              //     BlocProvider.of<WishlistBloc>(context)
                              //         .add(AddProductToWishlist(wish));
                              //     _toggleFavorite();
                              //     if (state
                              //     is AddProductToWishlistLoadingState) {
                              //       return (Center(
                              //         child: CircularProgressIndicator(),
                              //       ));
                              //     }
                              //   });
                              // });
                            }
                          }),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            itemPadding:
                            EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            rating: _userRating,
                            itemBuilder: (context, index) => Icon(
                              _selectedIcon ?? Icons.star,
                              color: Colors.orange,
                            ),
                            itemCount: 1,
                            itemSize: 20.0,
                            unratedColor: Colors.amber.withAlpha(50),
                          ),
                          Text(_userRating.toString()),
                        ],
                      ),
                    )
                  ]),
                  Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            // padding: EdgeInsets.only(left: 6),
                              alignment: Alignment.topLeft,
                              child: Text(
                                  widget.product == null
                                      ? ''
                                      : widget.product.productName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: (TextStyle(
                                    // fontFamily: 'YanoneKaffeesatz',
                                    //fontFamily: 'RobotoSlab',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  )))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text('KWD ',
                                          style: (TextStyle(
                                          //      fontFamily: 'RobotoSlab',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.deepOrangeAccent))),
                                      Text(
                                          widget.product.productPrice == null
                                              ? ''
                                              : widget.product.productPrice
                                              .toString(),
                                          style: (TextStyle(
                                          //  fontFamily: 'RobotoSlab',
                                            fontSize: 18,
                                            color: Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.w800,
                                          ))),
                                    ],
                                  )),
                              IconButton(
                                  icon: Icon(Icons.shopping_cart_outlined),
                                  onPressed: null)
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        );
      }
      return Container(
         alignment: Alignment.center,
         child: SpinKitCircle(color: Colors.orangeAccent));
    });
  }
}
