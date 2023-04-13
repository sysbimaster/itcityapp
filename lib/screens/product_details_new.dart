import 'package:badges/badges.dart' as badge;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/MultipleImageModel.dart';
import 'package:itcity_online_store/api/models/models.dart';

import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/review/random_review_bloc.dart';
import 'package:itcity_online_store/components/CartCardNew.dart';
import 'package:itcity_online_store/components/bottom_nav_product_new.dart';

import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/components/product_review_new.dart';
import 'package:itcity_online_store/components/show_reviews.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductDetailsNew extends StatefulWidget {
  final String? productId;
  bool isFavorited = true;
  Function? onFavourite;


  ProductDetailsNew(
      {Key? key,
        required this.productId,
        this.isFavorited = false,
        this.onFavourite})
      : super(key: key) {
    print("This is Favourired" + this.isFavorited.toString());
  }



  @override
  _ProductDetailsNewState createState() => _ProductDetailsNewState();
}

class _ProductDetailsNewState extends State<ProductDetailsNew> {
  TextEditingController tcontroller = TextEditingController();
  TabController? controller;
  Product? product;
  int productQuantity = 0;
  int selected = 0;
  String? userId = '';
  MultipleImageModel? multipleImageModel;

  int? cartcount = 0;
  checkCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('cartcount')){
      cartcount = prefs.getInt('cartcount');
      setState(()  {
        print('cart count in mainpage');
        this.cartcount = cartcount;
      });
    }
  }
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('customerId');
  }
  bool morevisible = false;
  @override
  void dispose() {
    Loader.hide();
    // TODO: implement dispose
    super.dispose();
  }
  String? country;
  String? currency;
  double? rating;
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProductByProductId(widget.productId,currency));
    BlocProvider.of<ProductBloc>(context)
        .add(FetchMultiImageByProductId(widget.productId));
  }
  @override
  void initState() {
    BlocProvider.of<RandomReviewBloc>(context).add(FetchReview());
    checkCartCount();
    getCountry();
    this.getEmail();


    super.initState();
  }
  togglevisibility ( ){
    setState(() {
      morevisible = !morevisible;
      print(morevisible.toString());
    });

  }
  int _current = 0;
  @override
  Widget build(BuildContext context) {

    int? value = 0;
  //  FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return BlocListener<CartBloc, CartState>(
  listener: (context, state) {
    if (state is AddProductToCartLoadingState) {

      Loader.show(context,
          isAppbarOverlay: true,
          isBottomBarOverlay: false,
          progressIndicator: CircularProgressIndicator(),
          themeData:
          Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
          overlayColor: Colors.black26);
    } else if (state is AddProductToCartSuccessState) {
      Loader.hide();

      if(BlocProvider.of<CartBloc>(context).page != 'cartpage' ){
        showModalBottomSheet(
            context: context,
            builder: (context) {
              // print("model run 1");
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Product added to Cart",
                      style: TextStyle(fontSize: 27),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            minHeight:
                            MediaQuery.of(context).size.height * .07,
                          ),
                          width: MediaQuery.of(context).size.width * .35,
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.WHITE),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: AppColors.LOGO_ORANGE))),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.LOGO_ORANGE),
                              ),
                              onPressed: () {
                                print("pop clicked");
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "CONTINUE SHOPPING",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              )),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight:
                            MediaQuery.of(context).size.height * .07,
                          ),
                          width: MediaQuery.of(context).size.width * .35,
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.LOGO_ORANGE),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: AppColors.LOGO_ORANGE))),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.WHITE),
                              ),
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/cart", (route) => false);
                              },
                              child: Text(
                                "GO TO CART",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              );
            });
      }

    } else if (state is AddProductToCartErrorState) {
      Loader.hide();
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.clear_outlined,
                    color: AppColors.WHITE,
                    size: 75,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Something Went Wrong",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Please Try Again Later",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            );
          });
    } else {
      Loader.hide();
    }

    if(state is CartDetailsLoadedState|| state is CartAddRefreshLoadedState){
      setState(() {
        this.cartcount = BlocProvider.of<CartBloc>(context).currentCartList.length;

      });
    }

    // TODO: implement listener
  },
  child: BlocBuilder<ProductBloc, ProductState>(buildWhen: (pstate, state) {

    if(state is MultiImageByProductIdLoadedState){
      multipleImageModel = BlocProvider.of<ProductBloc>(context).multipleImageModel;
      if (product == null) {
        product =
            product ?? BlocProvider.of<ProductBloc>(context).currentProduct;
        if(product!= null){
          value = BlocProvider.of<CartBloc>(context)
              .productCount[product!.productId!];

        }
        print("This is the value" + value.toString());
        print("This is the value" +
            BlocProvider.of<CartBloc>(context).productCount.toString());
        // countCubit.setValue(value??0);
      }
      return true;
    }

        // if (state is ProductByProductIdLoadedState) {
        //   if (product == null) {
        //     product =
        //         product ?? BlocProvider.of<ProductBloc>(context).currentProduct;
        //     value = BlocProvider.of<CartBloc>(context)
        //         .productCount[product.productId];
        //     print("This is the value" + value.toString());
        //     print("This is the value" +
        //         BlocProvider.of<CartBloc>(context).productCount.toString());
        //     // countCubit.setValue(value??0);
        //   }
        //   return true;
        // }
        if (state is ProductByProductIdLoadingState) return true;
        return false;
      },builder: (context, state) {
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
        backgroundColor: AppColors.GREY,
        appBar:AppBar(
          backgroundColor: AppColors.LOGO_ORANGE,
          title: Image.asset(
            'assets/images/logo_home.png',
            width: 130,
            height: 55,
            fit: BoxFit.contain,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/cart', (route) => false);
              },
              icon: cartcount == 0 ?Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.WHITE,
              ):badge.Badge(child: Icon(Icons.shopping_cart_outlined),badgeContent: Text(cartcount.toString(),),badgeStyle: badge.BadgeStyle(badgeColor: AppColors.WHITE),),
    ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: AppColors.WHITE,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // IconButton(onPressed: (){
                      //   Navigator.of(context).pop();
                      // }, icon: Icon(Icons.arrow_back_ios,color: AppColors.LOGO_ORANGE,)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SearchPage()));
                        },
                        child: Container(
                          height: 34,
                          width: MediaQuery.of(context).size.width * .90,
                          alignment: Alignment.bottomCenter,
                          //margin: EdgeInsets.fromLTRB(5, 10, 15, 10),
                          child: TextField(
                            enabled: false,
                            controller: tcontroller,
                            decoration: InputDecoration(
                              // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                fillColor: AppColors.GREY,
                                contentPadding: EdgeInsets.fromLTRB(25, 2, 25, 2),
                                filled: true,
                                hoverColor: Colors.grey,
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(50.0),
                                    ),
                                    borderSide: BorderSide(color: Colors.white)),
                                hintText: "Search Product, brands and more",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  padding: EdgeInsets.only(right: 20), onPressed: null,
                                ),
                                hintStyle:
                                Theme.of(context).inputDecorationTheme.hintStyle),
                          ),
                        ),
                      ),
                      // IconButton(onPressed: (){
                      //   Navigator.popAndPushNamed(context, '/cart');
                      // }, icon: Icon(Icons.shopping_cart_outlined,color: AppColors.LOGO_ORANGE,)),
                    ]),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationProductNew(product: product,quantity: BlocProvider.of<CartBloc>(context)
            .productCount[widget.productId!] ??
            0,),
        body: LayoutBuilder(builder: (context, constraints){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        color: AppColors.WHITE,
                        child: Center(
                          child:  multipleImageModel!.data!.length <= 1 ? Image.network(
                            product == null
                                ? ''
                                : image + product!.productImage!,
                            fit: BoxFit.none,
                          ) : Container(

                            height: MediaQuery.of(context).size.height * .39,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Container(

                                  child: CarouselSlider(
                                    items: multipleImageModel!.data!
                                        .map((item) =>

                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Image.network(
                                          item == null ? '' : image + item.images!,fit: BoxFit.none,),
                                      ),
                                    ))
                                        .toList(),
                                    options: CarouselOptions(
                                        autoPlay: false,

                                        autoPlayAnimationDuration: Duration(milliseconds: 250),
                                        autoPlayCurve: Curves.ease,
                                        // enlargeCenterPage: true,
                                        viewportFraction: 1,
                                        aspectRatio: 1.2,
                                        onPageChanged: (index, reason) {

                                          setState(() {

                                            _current = index;

                                          });
                                        }),
                                  ),
                                ),
                                Align(
                                  // heightFactor:,`
                                  widthFactor: 1,
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: multipleImageModel!.data!.map((item) {
                                        print(_current);
                                        int index = multipleImageModel!.data!.indexOf(item);
                                        return Container(
                                          width: 25.0,
                                          height:3.0,
                                          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            shape: BoxShape.rectangle,
                                            color: _current == index
                                                ? AppColors.LOGO_ORANGE
                                                : Colors.black26,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child:Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<RandomReviewBloc, RandomReviewState>(
                                  builder: (context,state){

                                    if(state is RandomReviewLoaded){
                                      this.rating = BlocProvider.of<RandomReviewBloc>(context).ratingReview;
                                      print('rating'+this.rating!.toStringAsFixed(1));
                                      return Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star,color: AppColors.LOGO_ORANGE,size: 20,),
                                            Text(rating!.toStringAsFixed(1),style: TextStyle(
                                              fontFamily: 'Arial',
                                              // fontFamily: 'RobotoSlab',
                                              fontSize: 16,
                                              //decoration:
                                              //TextDecoration.lineThrough,
                                              color: AppColors.LOGO_BLACK,
                                              // fontWeight: FontWeight.bold,
                                            ),),
                                          ],
                                        ),
                                      );

                                    }
                                    return Container();

                                  },
                                ),
                                // Text(product.productBrand,style: TextStyle(color: AppColors.LOGO_ORANGE),),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: product!.productQty == 0
                                        ? Container(
                                      //margin: EdgeInsets.all(8),
                                      // padding: EdgeInsets.fromLTRB(10, 5, 20, 5),

                                        child: Text('OUT OF STOCK',
                                          style: TextStyle(color: Colors.red,fontSize: 16),
                                        )):Container(
                                      // margin: EdgeInsets.all(8),
                                      // padding: EdgeInsets.fromLTRB(10, 5, 20, 5),

                                      child: Text('IN STOCK',
                                          style: TextStyle(color: Colors.green,fontSize: 16)),
                                    )),

                              ],
                            ),
                          ),
                        ),)
                    ],

                  ),


                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.WHITE,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 30, 5),
                      child: Text(
                        product == null
                            ? ''
                            : product!.productName!,
                        style: (TextStyle(
                          // fontFamily: 'YanoneKaffeesatz',
                          fontSize: 24,
                          color:AppColors.LOGO_BLACK,
                          fontWeight: FontWeight.w500,
                        )),maxLines: 3,overflow: TextOverflow.ellipsis,),
                    ),
                  ),
                  Container(
                    color: AppColors.WHITE,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(product.productBrand,style: TextStyle(color: AppColors.LOGO_ORANGE),),

                        Container(
                          //margin: EdgeInsets.all(8),
                            padding: EdgeInsets.fromLTRB(15, 5, 20, 5),

                            child: Text(product!.productId! + '/' + product!.productBrand!,
                              style: TextStyle(color: AppColors.LOGO_ORANGE,fontSize: 16),
                            )),
                        Container(
                          // margin: EdgeInsets.all(8),
                            padding: EdgeInsets.fromLTRB(10, 5, 15, 5),

                            child:                             product!.productPriceOffer ==
                                product!.productPrice
                                ?  currency != null ?Container(

                                child: Text(
                                    currency! +
                                        ' ' +
                                        product!.productPrice.toStringAsFixed(2),
                                    style: (TextStyle(
                                      // fontFamily: 'RobotoSlab',
                                      fontSize: 22,
                                      //decoration:
                                      //TextDecoration.lineThrough,
                                      color: AppColors.LOGO_BLACK,
                                      // fontWeight: FontWeight.w800,
                                    )))):SpinKitCircle(
                              size: 10,color: AppColors.LOGO_ORANGE,
                            )
                                : Row(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                currency != null ? Container(

                                    child:Text(
                                        currency! +
                                            ' ' +
                                            product!.productPrice.toStringAsFixed(2),
                                        style: (TextStyle(
                                          // fontFamily: 'RobotoSlab',
                                          fontSize: 16,
                                          decoration:
                                          TextDecoration.lineThrough,
                                          color: AppColors.LOGO_ORANGE,
                                          // fontWeight: FontWeight.w800,
                                        )))): SpinKitCircle(
                                  size: 10,color: AppColors.LOGO_ORANGE,
                                ),
                                SizedBox(
                                  height: 2,
                                  width: 5,
                                ),
                                currency != null ?Container(

                                    child: Text(
                                        currency! +
                                            ' ' +
                                            product!.productPriceOffer.toStringAsFixed(2),
                                        style: (TextStyle(
                                          // fontFamily: 'RobotoSlab',
                                          fontSize: 22,
                                          //decoration:
                                          //TextDecoration.lineThrough,
                                          color: AppColors.LOGO_BLACK,
                                          // fontWeight: FontWeight.w800,
                                        )))):SpinKitCircle(
                                  size: 10,color: AppColors.LOGO_ORANGE,
                                ),
                              ],
                            )
                        ),




                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                  AnimatedContainer(
                    color: AppColors.WHITE,
                    duration: Duration(seconds:1),
                    curve: Curves.fastOutSlowIn,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment :MainAxisAlignment.spaceBetween ,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 30, 5),
                              child: Text('More About Product',
                                style: (TextStyle(
                                  // fontFamily: 'YanoneKaffeesatz',
                                  fontSize: 20,
                                  color:AppColors.LOGO_BLACK,
                                  fontWeight: FontWeight.w500,
                                )),maxLines: 3,overflow: TextOverflow.ellipsis,),
                            ),
                            morevisible ? IconButton(
                                onPressed: togglevisibility,
                                icon: Icon(Icons.keyboard_arrow_up)): IconButton(
                                onPressed: togglevisibility,
                                icon: Icon(Icons.keyboard_arrow_down))
                          ],
                        ),
                        morevisible ? Container(
                            padding: EdgeInsets.only(top:10,bottom: 20,left: 15,right: 15),
                            alignment: Alignment.centerLeft,
                            child: Html(
                              style: {
                                "li":Style(
                                  // fontWeight: FontWeight.bold,
                                    fontSize: FontSize(18)
                                ),
                              },
                              data:product == null
                                  ? 'Loading'
                                  : product!.productDesc!.toLowerCase(),
                            )):Container(),
                        SizedBox(
                          height: 10,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                  ProductRatingNew(productId: product!.productId,),

                  ShowReviews(productId: product!.productId,),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: AppColors.WHITE,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 30, 5),
                      child: Text('Related Products',
                        style: (TextStyle(
                          // fontFamily: 'YanoneKaffeesatz',
                          fontSize: 20,
                          color:AppColors.LOGO_BLACK,
                          fontWeight: FontWeight.w500,
                        )),maxLines: 3,overflow: TextOverflow.ellipsis,textAlign: TextAlign.left,),
                    ),
                  ),
                  Container(
                      color: AppColors.WHITE,
                      width: MediaQuery.of(context).size.width,
                      child: RelatedProduct(productBrand: product!.productBrand,currency: this.currency,))
                ],
              ),
            ),
          );
        }

        ),
      );
    },
),
);
  }
}
