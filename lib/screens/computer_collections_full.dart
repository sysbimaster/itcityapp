import 'dart:async';
import 'dart:math';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/product_card.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';

import 'package:itcity_online_store/screens/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ComputerCollectionsFull extends StatefulWidget {
  String? currency;
 ComputerCollectionsFull({Key? key,this.currency}) : super(key: key);

  @override
  _ComputerCollectionsFullState createState() => _ComputerCollectionsFullState();
}

class _ComputerCollectionsFullState extends State<ComputerCollectionsFull> {
  List<Product>? computerCollectionsList;
  TextEditingController tcontroller = TextEditingController();

  bool _isFavorited = false;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }
  Random rnd = new Random();
  
  int? cartcount = 0;
  checkCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('cartcount')){
      cartcount = prefs.getInt('cartcount');
      setState(()  {

        this.cartcount = cartcount;
      });
    }
  }
  @override
  void initState() {
    checkCartCount();
    BlocProvider.of<ProductBloc>(context).add(FetchComputerCollectionsFull(widget.currency));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
  listener: (context, state) {

    if(state is CartDetailsLoadedState|| state is CartAddRefreshLoadedState){
      setState(() {
        cartcount = BlocProvider.of<CartBloc>(context).currentCartList.length;
      });
    }
    // TODO: implement listener
  },
  child: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        computerCollectionsList= BlocProvider.of<ProductBloc>(context).computerCollectionsFull;
        if(state is ComputerCollectionsFullLoadingState){
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
        if(state is ComputerCollectionsFullLoadedState|| state is ProductByProductIdLoadedState||state is RelatedProductByProductBrandLoadedState){
          computerCollectionsList= BlocProvider.of<ProductBloc>(context).computerCollectionsFull;

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
                  icon: cartcount == 0 ?Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.WHITE,
                  ):badge.Badge(
                    badgeStyle: badge.BadgeStyle(
                      badgeColor: AppColors.WHITE
                    ),
                    child: Icon(Icons.shopping_cart_outlined),badgeContent: Text(cartcount.toString(),),),
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
            body : Container(
              color: AppColors.WHITE,
              child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: GridView.builder(

                    shrinkWrap: true,
                    itemCount: computerCollectionsList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: computerCollectionsList![index],currency: widget.currency,rrating: 3.9+ rnd.nextDouble());
                    }),
              ),
            ),
          );
        }
        return Container();
      },
    ),
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
