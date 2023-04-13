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
import 'package:itcity_online_store/screens/featured_products_full.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';

import 'package:shared_preferences/shared_preferences.dart';


class FeaturedProduct extends StatefulWidget {
  const FeaturedProduct({Key? key}) : super(key: key);

  @override
  _FeaturedProductState createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {
  Random rnd = new Random();
  List<Product> featuredProducts = [];
  getFeaturedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<HomeBloc>(context).add(FetchFeaturedProduct(prefs.getString('currency')));

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
  void initState() {
    getCountry();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool _isFavorited = false;

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      featuredProducts = BlocProvider.of<HomeBloc>(context).featuredProduct;

      if(state is FeaturedProductLoadingState){

        return Center(
            child: SpinKitRipple(
              color: Theme.of(context).primaryColor,
              size: 50,
            ));
      }



      return Container(

        color: AppColors.WHITE,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * .50,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 10, 10),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListHeader(
                    headerName: 'Featured Products',
                    onTap: () {},
                  ),
                  OutlinedButton(onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeaturedProductsFull(currency: prefs.getString('currency'),)));
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
                  itemCount: featuredProducts == null ? 0 : featuredProducts.length,
                  itemBuilder: (BuildContext context,int index){
                    return ProductCard(product: featuredProducts[index],currency: this.currency,rrating: 3.9+ rnd.nextDouble(),);
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
