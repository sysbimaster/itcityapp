import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/cart.dart';
import 'package:itcity_online_store/api/models/product.dart';
import 'package:itcity_online_store/api/models/wishlist.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/product_card.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/product_details_new.dart';
import 'package:itcity_online_store/screens/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class PopularProductsFull extends StatefulWidget {
  String currency;
  PopularProductsFull({Key key,this.currency}) : super(key: key);

  @override
  _PopularProductsFullState createState() => _PopularProductsFullState();
}

class _PopularProductsFullState extends State<PopularProductsFull> {
  List<Product> popularProductFullList;
  TextEditingController tcontroller = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(FetchPopularProductsFull(widget.currency));
    // TODO: implement initState
    super.initState();
  }
  Random rnd = new Random();
  bool _isFavorited = false;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        popularProductFullList = BlocProvider.of<ProductBloc>(context).popularProductsFull;
        if(state is PopularProductFullLoadingState){
          return Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height ,
            color: AppColors.WHITE,
            child: Center(
                child: SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                  size: 50,
                )),
          );
        }
        if(state is PopularProductFullLoadedState|| state is ProductByProductIdLoadedState||state is RelatedProductByProductBrandLoadedState){
          popularProductFullList = BlocProvider.of<ProductBloc>(context).popularProductsFull;
          print('deallist length'+popularProductFullList.length.toString());
          return Scaffold(
            backgroundColor: AppColors.WHITE,
            appBar: AppBar(
              backgroundColor: AppColors.LOGO_ORANGE,
              title: Image.asset(
                'assets/images/logo_home.png',
                width: 130,
                height: 55,
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
                preferredSize: Size.fromHeight(45),
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
            body : Container(
              color: AppColors.WHITE,
              child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: GridView.builder(

                    shrinkWrap: true,
                    itemCount: popularProductFullList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(currency: widget.currency,product: popularProductFullList[index],rrating: 3.9+ rnd.nextDouble());
                    }),
              ),
            ),
          );
        }
        return Container();
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
}
