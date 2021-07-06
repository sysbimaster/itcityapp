import 'package:flutter/material.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/components/components.dart';
class RelatedProduct extends StatefulWidget {
  final String productBrand;
  RelatedProduct({this.productBrand});
  @override
  _RelatedProductState createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context)
        .add(FetchRelatedProductByProductBrand(widget.productBrand));
  }
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      List<Product> products =
          BlocProvider.of<ProductBloc>(context).relatedProduct;

      print('State of related product list =>' + state.toString());

      if (state is RelatedProductByProductBrandLoadingState) {
        print('circular');
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
              childAspectRatio: .52,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ProductList(
                product: products == null ? '' : products[index],
              );
            }),
      );
    });
  }
}
