import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/bloc/search_bloc.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/bottom_nav_product_new.dart';
import 'package:itcity_online_store/components/cart_card.dart';
import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/components/product_review_new.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_page.dart';

class ProductDetailsNew extends StatefulWidget {
  final String productId;
  bool isFavorited = true;
  Function onFavourite;
  ProductDetailsNew(
      {Key key,
        @required this.productId,
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
  TabController controller;
  Product product;
  int productQuantity = 0;
  int selected = 0;
  String userId = '';
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = await prefs.getString('customerId');
  }
  bool morevisible = false;
  @override
  void dispose() {
    Loader.hide();
    // TODO: implement dispose
    super.dispose();
  }
  String country;
  String currency;
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProductByProductId(widget.productId,currency));
  }
  @override
  void initState() {
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
  @override
  Widget build(BuildContext context) {
    int value = 0;
  //  FlutterStatusbarcolor.setStatusBarColor(Colors.white);
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
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.WHITE,
              ),
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
                              padding: EdgeInsets.only(right: 20),
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
            .productCount[widget.productId] ??
            0,),
        body: LayoutBuilder(builder: (context, constraints){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  Container(
                    color: AppColors.WHITE,
                    child: Center(
                      child: Image.network(
                        product == null
                            ? ''
                            : image + product.productImage,
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.WHITE,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       // Text(product.productBrand,style: TextStyle(color: AppColors.LOGO_ORANGE),),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: product.productQty == 0
                                ? Container(
                              //margin: EdgeInsets.all(8),
                              padding: EdgeInsets.fromLTRB(10, 5, 20, 5),

                              child: Text('OUT OF STOCK',
                                  style: TextStyle(color: Colors.red,fontSize: 16),
                            )):Container(
                             // margin: EdgeInsets.all(8),
                              padding: EdgeInsets.fromLTRB(10, 5, 20, 5),

                              child: Text('IN STOCK',
                                  style: TextStyle(color: Colors.green,fontSize: 16)),
                            )),

                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.WHITE,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 30, 5),
                      child: Text(
                          product == null
                              ? ''
                              : product.productName,
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

                            child: Text(product.productId + '/' + product.productBrand,
                              style: TextStyle(color: AppColors.LOGO_ORANGE,fontSize: 16),
                            )),
                        Container(
                          // margin: EdgeInsets.all(8),
                          padding: EdgeInsets.fromLTRB(10, 5, 15, 5),

                          child:                             product.productPriceOffer ==
                              product.productPrice
                                ?  currency != null ?Container(

                                child: Text(
                                    currency +
                                        ' ' +
                                        product.productPrice.toStringAsFixed(2),
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
                                        currency +
                                            ' ' +
                                           product.productPrice.toStringAsFixed(2),
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
                                        currency +
                                            ' ' +
                                            product.productPriceOffer.toStringAsFixed(2),
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
                                  : product.productDesc.toLowerCase(),
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
                  ProductRatingNew(),
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
                      child: RelatedProduct(productBrand: product.productBrand,currency: this.currency,))
                ],
              ),
            ),
          );
        }

        ),
      );
    },
);
  }
}
