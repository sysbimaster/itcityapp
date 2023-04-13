import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';

import 'package:itcity_online_store/components/product_card.dart';

import 'package:itcity_online_store/screens/login_page_new.dart';


class RelatedProduct extends StatefulWidget {
  final String? productBrand;
  final String? currency;
  RelatedProduct({this.productBrand,this.currency});
  @override
  _RelatedProductState createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  Random rnd = new Random();
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



      if (state is RelatedProductByProductBrandLoadingState) {

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
              return ProductCard(product: products[index],currency: widget.currency ,rrating: 3.9+ rnd.nextDouble(),);
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
