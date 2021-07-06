import 'package:flutter/material.dart';

import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistCard extends StatefulWidget {
  final CustomerWishlist wishlist;
  final VoidCallback onDelete;
  WishlistCard({Key key, @required this.wishlist, this.onDelete})
      : super(key: key);
  @override
  WishlistCardState createState() => WishlistCardState();
}

class WishlistCardState extends State<WishlistCard> {
  String contact;
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetailPage(
              productId: widget.wishlist.productId,
              isFavorited: this._isFavorited,
            );
          }));
        },
        child: Container(
          height: 420,
          child: Card(
            shadowColor: Colors.lightBlue[100],
            elevation: 2,
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    height: 160.0,
                    width: 190.0,
                    child: Container(
                      height: 100.0,
                      width: 80.0,
                      margin: EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 8),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(widget.wishlist == null
                              ? ''
                              : image + widget.wishlist.productImage),
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
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            Wishlist wish = Wishlist();
                            wish.wishlist = widget.wishlist.productId;
                           // final storage = new FlutterSecureStorage();
                            if(prefs.containsKey('email')) {

                              wish.username = prefs.getString('email');

                              BlocProvider.of<WishlistBloc>(context)
                                  .add(RemoveProductFromWishlistEvent(wish));
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
                            //   Wishlist wish = Wishlist();
                            //   wish.wishlist = widget.wishlist.productId;
                            //   wish.username = value;
                            //
                            //   BlocProvider.of<WishlistBloc>(context)
                            //       .add(RemoveProductFromWishlistEvent(wish));
                            //   print(
                            //       'product is removing from wishlist>>>>>>>>>>>>>');
                            //   _toggleFavorite();
                            //   if (state
                            //       is RemoveProductFromWishlistLoadingState) {
                            //     return (Center(
                            //       child: CircularProgressIndicator(),
                            //     ));
                            //   }
                            // });
                          }
                          if (_isFavorited == false) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            if(prefs.containsKey('email')) {

                              setState(() {
                                Wishlist wish = Wishlist();
                                wish.wishlist = widget.wishlist.productId;
                                wish.username = prefs.getString('email');

                                BlocProvider.of<WishlistBloc>(context)
                                    .add(AddProductToWishlist(wish));
                                _toggleFavorite();
                                if (state is AddProductToWishlistLoadingState) {
                                  return (Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              });
                            }
                           // final storage = new FlutterSecureStorage();
                           //  storage.read(key: "email").then((value) {
                           //    setState(() {
                           //      Wishlist wish = Wishlist();
                           //      wish.wishlist = widget.wishlist.productId;
                           //      wish.username = value;
                           //
                           //      BlocProvider.of<WishlistBloc>(context)
                           //          .add(AddProductToWishlist(wish));
                           //      _toggleFavorite();
                           //      if (state is AddProductToWishlistLoadingState) {
                           //        return (Center(
                           //          child: CircularProgressIndicator(),
                           //        ));
                           //      }
                           //    });
                           //  });
                            setState(() {
                              Wishlist wish = Wishlist();
                              wish.wishlist = widget.wishlist.productId;
                              wish.username = 'test.sysbreeze@gmail.com';

                              BlocProvider.of<WishlistBloc>(context)
                                  .add(AddProductToWishlist(wish));
                              _toggleFavorite();
                              if (state is AddProductToWishlistLoadingState) {
                                return (Center(
                                  child: CircularProgressIndicator(),
                                ));
                              }
                            });
                          }
                        }),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [],
                    ),
                  )
                ]),
                Padding(
                    padding: EdgeInsets.only(left: 10, top: 3, bottom: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            // padding: EdgeInsets.only(left: 6),
                            alignment: Alignment.topLeft,
                            child: Text(
                                widget.wishlist == null
                                    ? ''
                                    : widget.wishlist.productName,
                                overflow: TextOverflow.ellipsis,
                                style: (TextStyle(
                                  // fontFamily: 'YanoneKaffeesatz',
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
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
                                            fontFamily: 'RobotoSlab',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.deepOrangeAccent))),
                                    Text(
                                        widget.wishlist == null
                                            ? ''
                                            : widget.wishlist.productPrice
                                                .toString(),
                                        style: (TextStyle(
                                          fontFamily: 'RobotoSlab',
                                          fontSize: 14,
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
    });
  }
}
