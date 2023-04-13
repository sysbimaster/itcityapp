import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/list_header.dart';
import 'package:itcity_online_store/components/product_card.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/popular_product_full.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  Random rnd = new Random();
  List<Product> popularProducts = [];
  getPopularProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<HomeBloc>(context).add(FetchPopularProduct(prefs.getString('currency')));
    // if( !(BlocProvider.of<HomeBloc>(context).state is PopularProductLoadedState)){
    //
    // }else {
    //
    // }

  }
  String? country;
  String? currency;
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
  }
  @override
  void initState()  {
    getCountry();
   // SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO: implement initState
   // BlocProvider.of<HomeBloc>(context).add(FetchPopularProduct(prefs.getString('currency')));
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      bool _isFavorited = false;
      void _toggleFavorite() {
        setState(() {
          _isFavorited = !_isFavorited;
        });
      }
      popularProducts = BlocProvider.of<HomeBloc>(context).popularProduct;

      if(state is PopularProductLoadingState){

        return Center(
            child: SpinKitRipple(
              color: Theme.of(context).primaryColor,
              size: 50,
            ));
      }



      return Container(

        color: AppColors.WHITE,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * .47,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 10, 10),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListHeader(
                    headerName: 'Popular Products',
                    onTap: () {},
                  ),
                  OutlinedButton(onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PopularProductsFull(currency:prefs.getString('currency'),)));
                  }, child: Text('View All',style: TextStyle(fontSize: 16,color: AppColors.LOGO_ORANGE),),style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                  ))
                ],
              ),
            ),
            Container(
             height: MediaQuery.of(context).size.height * .50,


              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularProducts == null ? 0 : popularProducts.length,
                  itemBuilder: (BuildContext context,int index){
                    return ProductCard(currency: currency,product: popularProducts[index],rrating: 3.9+ rnd.nextDouble());
                  }),
            ),
            SizedBox(
              height: 15,
            )


          ],
        ),
      ) ;
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
