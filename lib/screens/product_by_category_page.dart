import 'package:flutter/material.dart';
import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:share/share.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductByCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  ProductByCategoryPage(
      {Key key, @required this.categoryId, @required this.categoryName})
      : super(key: key);
  @override
  _ProductByCategoryPageState createState() => _ProductByCategoryPageState();
}

class _ProductByCategoryPageState extends State<ProductByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.categoryName,
              style: TextStyle(color: Colors.white),
            ),
            actions: [],
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
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.orange, Colors.deepOrangeAccent])),
            )),
        body: ProductListByCategory(widget.categoryId));
  }
}

class ProductListByCategory extends StatefulWidget {
  final int categoryId;
  ProductListByCategory(this.categoryId);
  @override
  _ProductListByCategoryState createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProductByCategoryId(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (context, productstate) {
      return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        print('State of product list by category =>' + productstate.toString());

        products = BlocProvider.of<ProductBloc>(context).productListByCategory;

        // List<Brands> brand = BlocProvider.of<HomeBloc>(context).brands;
        if (productstate is ProductByCategoryIdLoadingState) {
          print('circular');
          return Center(
              child: SpinKitRing(
            color:Colors.white,
            size: 50,
          ));
        }
        if (state is BrandDetailsLoadingState) {
          print('brand list is loading');
          return Center(
              child: SpinKitRing(
            color: Theme.of(context).primaryColor,
            size: 50,
          ));
        }

        if (products.length == 0) {
          // return Center(
          //   child: CircularProgressIndicator(),
          // );
          return Container(
              color: Colors.white,
              child: Center(
                child: Text("No Products Found"),
              ));
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: kContainerDecoration,
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Card(
            //           color: Colors.orange[100],
            //           child: ListTile(
            //             onTap: () {
            //               showModalBottomSheet(
            //                   context: context,
            //                   builder: (builder) {
            //                     return new Container(
            //                         height: 350.0,
            //                         color: Colors
            //                             .transparent, //could change this to Color(0xFF737373),
            //                         //so you don't have to change MaterialApp canvasColor
            //                         child: new Container(
            //                             decoration: new BoxDecoration(
            //                                 color: Colors.white,
            //                                 borderRadius: new BorderRadius.only(
            //                                     topLeft:
            //                                         const Radius.circular(10.0),
            //                                     topRight: const Radius.circular(
            //                                         10.0))),
            //                             child: Center(
            //                                 child: Text('Filter Items'))));
            //                   });
            //             },
            //             leading: Text("Filter"),
            //             trailing: Icon(Icons.filter),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Card(
            //           color: Colors.red[100],
            //           child: ListTile(
            //             onTap: () {
            //               showModalBottomSheet(
            //                   context: context,
            //                   builder: (builder) {
            //                     return new Container(
            //                         height: 350.0,
            //                         color: Colors
            //                             .transparent, //could change this to Color(0xFF737373),
            //                         //so you don't have to change MaterialApp canvasColor
            //                         child: new Container(
            //                             decoration: new BoxDecoration(
            //                                 color: Colors.white,
            //                                 borderRadius: new BorderRadius.only(
            //                                     topLeft:
            //                                         const Radius.circular(10.0),
            //                                     topRight: const Radius.circular(
            //                                         10.0))),
            //                             child:
            //                                 Center(child: Text('Sort Items'))));
            //                   });
            //             },
            //             leading: Text("Sort"),
            //             trailing: Icon(Icons.sort),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 60.0,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: brand.length,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: EdgeInsets.all(8),
            //           padding: EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //               color: Colors.white,
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey,
            //                   blurRadius: 5.0,
            //                 ),
            //               ],
            //               borderRadius: BorderRadius.only(
            //                   bottomLeft: Radius.circular(30),
            //                   bottomRight: Radius.circular(30),
            //                   topLeft: Radius.circular(30),
            //                   topRight: Radius.circular(30))),
            //           height: 60.0,
            //           child: Center(child: Text(brand[index].brandsName)),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            SliverPadding(
              padding: EdgeInsets.all(0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width.toInt() <
                          550
                      ? 2
                      : MediaQuery.of(context).size.width.toInt() > 550 &&
                              MediaQuery.of(context).size.width.toInt() < 800
                          ? 4
                          : 6,
                  childAspectRatio: 0.49,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductList(
                      product: products[index],
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ),
          ]),
        );
      });
    });
  }
}
