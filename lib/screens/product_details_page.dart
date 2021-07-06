import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class CountCubit extends Cubit<int> {
//   CountCubit() : super(0);

//   void setValue(val) => emit(val);
// }

String image =
    'https://www.itcityonlinestore.com/uploads/product/single-product/';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  bool isFavorited = true;
  Function onFavourite;
  ProductDetailPage(
      {Key key,
      @required this.productId,
      this.isFavorited = false,
      this.onFavourite})
      : super(key: key) {
    print("This is Favourired" + this.isFavorited.toString());
  }
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class _ProductDetailPageState extends State<ProductDetailPage> {
  TabController controller;
  Product product;
  int productQuantity = 0;
  int selected = 0;
  String userId = '';
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = await prefs.getString('customerId');
  }

  @override
  void initState() {
    super.initState();
    this.getEmail();

    BlocProvider.of<ProductBloc>(context)
        .add(FetchProductByProductId(widget.productId));
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int value = 0;
    // CountCubit countCubit = CountCubit();
    return BlocBuilder<ProductBloc, ProductState>(buildWhen: (pstate, state) {
      if (state is ProductByProductIdLoadedState) {
        if (product == null) {
          product =
              product ?? BlocProvider.of<ProductBloc>(context).currentProduct;
          value = BlocProvider.of<CartBloc>(context)
              .productCount[product.productId];
          print("This is the value" + value.toString());
          print("This is the value" +
              BlocProvider.of<CartBloc>(context).productCount.toString());
          // countCubit.setValue(value??0);
        }
        return true;
      }
      if (state is ProductByProductIdLoadingState) return true;
      return false;
    }, builder: (context, state) {
      print('State of product=>' + state.toString());

      if (state is ProductByProductIdLoadingState) {
        return Container(
          color: Colors.white,
          child: Center(
              child: SpinKitRing(
            color: Theme.of(context).primaryColor,
            size: 50,
          )),
        );
      }

      if (product == null) {
        print('Product is not loaded yet');
        return Center(
            child: SpinKitRing(
          color: Theme.of(context).primaryColor,
          size: 50,
        ));
      }
      return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        bottomNavigationBar: BottomNavigationProduct(
          quantity: BlocProvider.of<CartBloc>(context)
                  .productCount[widget.productId] ??
              0,
          product: product,
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            title: Text('IT CITY ONLINE' ,style: TextStyle(color: Colors.white),),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 18,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0.0,
              flexibleSpace: Container(
               decoration: kAppBarContainerDecoration,
              )),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
         decoration: kContainerDecoration,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // int productQuantity = int.parse(
              //   product == null ? '' : product.productQty,
              // );
              return SingleChildScrollView(
                  child: ProductInfo(
                      product: product,
                      isFavorited: widget.isFavorited,
                      onFavourite: widget.onFavourite,
                      onQuantityChange: (value) {
                        if (value == 0) {
                          // Remove product
                        } else {
                          // this.productQuantity=value;
                          print("kkkkk" + value.toString());
                          Cart cart = Cart();
                          cart.cartData =
                              product == null ? '' : product.id.toString();
                          cart.userId = userId;
                          cart.productCount = value;
                          cart.productPrice = product.productPrice != null
                              ? double.parse(product.productPrice)
                              : 0.0;
                          BlocProvider.of<CartBloc>(context)
                              .add(AddProductToCart(cart));
                        }
                      }));
            },
          ),
        ),
      );
    });
  }
}

class ProductInfo extends StatefulWidget {
  final Product product;
  bool isFavorited;
  Function onFavourite;
  Function onQuantityChange;
  int quantity;
  ProductInfo(
      {this.product,
      this.isFavorited = false,
      this.onFavourite,
      this.quantity,
      this.onQuantityChange});
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  void _toggleFavorite() {
    setState(() {
      if (widget.isFavorited) {
        print("Removing from favourites");
        widget.isFavorited = false;
        widget.onFavourite(widget.isFavorited);
      } else {
        widget.isFavorited = true;
        widget.onFavourite(widget.isFavorited);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      // if (state is WishlistLoadedState) {
      //   state.wishlist.forEach((element) {
      //     print(element.productId.toString() +
      //         ">>>>>>>>>>>" +
      //         widget.product.productId);
      //     if (element.productId == widget.product.productId) {
      //       this._isFavorited = true;
      //     } else {
      //       this._isFavorited = false;
      //     }
      //   });
      //   setState(() {});
      // }
      return Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.network(
                      widget.product == null
                          ? ''
                          : image + widget.product.productImage,
                      height: 200,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  spreadRadius: 5,
                                  blurRadius: 7),
                            ]),
                        child: IconButton(
                            icon: (widget.isFavorited
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border)),
                            color: Colors.deepOrangeAccent,
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if(prefs.containsKey('email')){
                                Wishlist wish = Wishlist();
                                wish.wishlist = widget.product.productId;
                                wish.username = prefs.getString('email');
                                if (widget.isFavorited) {
                                  BlocProvider.of<WishlistBloc>(context).add(
                                      RemoveProductFromWishlistEvent(wish));
                                  print(
                                      'product is removing from wishlist>>>>>>>>>>>>>');
                                  _toggleFavorite();
                                } else {
                                  BlocProvider.of<WishlistBloc>(context)
                                      .add(AddProductToWishlist(wish));
                                  _toggleFavorite();
                                }
                                if (state is AddProductToWishlistLoadingState) {
                                  return (Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              }
                              //final storage = new FlutterSecureStorage();
                              // storage.read(key: "email").then((value) {
                              //   Wishlist wish = Wishlist();
                              //   wish.wishlist = widget.product.productId;
                              //   wish.username = value;
                              //   if (widget.isFavorited) {
                              //     BlocProvider.of<WishlistBloc>(context).add(
                              //         RemoveProductFromWishlistEvent(wish));
                              //     print(
                              //         'product is removing from wishlist>>>>>>>>>>>>>');
                              //     _toggleFavorite();
                              //   } else {
                              //     BlocProvider.of<WishlistBloc>(context)
                              //         .add(AddProductToWishlist(wish));
                              //     _toggleFavorite();
                              //   }
                              //   if (state is AddProductToWishlistLoadingState) {
                              //     return (Center(
                              //       child: CircularProgressIndicator(),
                              //     ));
                              //   }
                              // });
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  spreadRadius: 5,
                                  blurRadius: 7),
                            ]),
                        child: IconButton(
                          icon: (Icon(Icons.share)),
                          color: Colors.deepOrangeAccent,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                        widget.product == null
                            ? ''
                            : widget.product.productName,
                        style: (TextStyle(
                          // fontFamily: 'YanoneKaffeesatz',
                          fontSize: 22,
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                        ))))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: widget.product.productQty == 0
                        ? Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Text('Out of Stock',
                                style: TextStyle(color: Colors.white)),
                          )
                        : Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Text('In Stock',
                                style: TextStyle(color: Colors.white)),
                          )),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: RatingBarIndicator(
                    itemPadding: EdgeInsets.only(left: 4, top: 4, bottom: 4),
                    rating: 4,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    itemCount: 5,
                    itemSize: 15.0,
                    unratedColor: Colors.grey,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    widget.product.productPriceOffer ==
                            widget.product.productPrice
                        ? TextSpan(children: [
                            TextSpan(
                              text: 'KWD ',
                              style: new TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            TextSpan(
                              text: widget.product == null
                                  ? ''
                                  : widget.product.productPrice.toString() +
                                      ' ',
                              style: new TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ])
                        : TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'KWD ',
                                style: new TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              TextSpan(
                                text: widget.product == null
                                    ? ''
                                    : widget.product.productPriceOffer
                                            .toString() +
                                        ' ',
                                style: new TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              TextSpan(
                                text: 'KWD',
                                style: new TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                text: widget.product == null
                                    ? ''
                                    : widget.product.productPrice.toString(),
                                style: new TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                // Quantity(
                //     stock: widget.product.productQty,
                //     quantity: widget.quantity ?? 0,
                //     onQuantityChange: (value) {
                //       print("kkkkk" + value.toString());
                //       widget.quantity = value;
                //       widget.onQuantityChange(value);
                //     }),
              ],
            ),
            AboutProduct(widget.product),
            ProductRatingReview(
              productId: widget.product.productId,
            ),
            ListHeader(
              headerName: 'Related Product',
              onTap: () {},
            ),
            RelatedProduct(
              productBrand: widget.product.productBrand,
            ),
          ],
        ),
      );
    });
  }
}
