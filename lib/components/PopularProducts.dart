import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/screens.dart';

import '../constants.dart';
import 'components.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key key}) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  List<Product> popularProducts = [];
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchPopularProduct());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      popularProducts = BlocProvider.of<HomeBloc>(context).popularProduct;
      // print('state of deal>>>>>' + state.toString());
      if(state is PopularProductLoadingState){
        print('popular loading');
        return Center(
            child: SpinKitRipple(
              color: Theme.of(context).primaryColor,
              size: 50,
            ));
      }

      // print('deals length=>>>>>>>>' + deals.length.toString());

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
                  OutlinedButton(onPressed: (){}, child: Text('View All',style: TextStyle(fontSize: 16),),style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                  ))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .38,

              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularProducts == null ? 0 : popularProducts.length,
                  itemBuilder: (BuildContext context,int index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ProductDetailPage(
                            productId: popularProducts[index].productId,
                          );
                        }));
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .49,
                            constraints: BoxConstraints(
                                minHeight: 230),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.GREY,width: 1.0),
                            ),
                            child: Column(
                              children: [

                                Container(
                                  height: 160.0,
                                  width: 110.0,
                                  //margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(popularProducts[index] == null
                                          ? ''
                                          : productImage + popularProducts[index].productImage),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 5, right: 5,top:10),
                                    child: Column(
                                     // mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            minHeight: 37,
                                          ),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                popularProducts[index] == null
                                                    ? ''
                                                    : popularProducts[index].productName,

                                                maxLines: 2,
                                                // softWrap: false,
                                                // overflow: TextOverflow.fade,

                                                style: (TextStyle(
                                                  // fontFamily: 'YanoneKaffeesatz',

                                                  fontSize: 15,

                                                )))),
                                        Divider(
                                          thickness: 2.0,
                                          color: AppColors.GREY,

                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                   alignment: Alignment.topLeft,
                                                    child: Text(
                                                        'KWD ' +
                                                            popularProducts[index].productPrice
                                                                .toString(),
                                                        style: (TextStyle(
                                                          // fontFamily: 'RobotoSlab',
                                                          fontSize: 12,
                                                          decoration: TextDecoration.lineThrough,
                                                          color: Colors.deepOrangeAccent,
                                                          // fontWeight: FontWeight.w800,
                                                        )),textAlign: TextAlign.left)),
                                                SizedBox(
                                                  height: 2,
                                                  width: 2,
                                                ),
                                                Container(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                        'KWD ' +
                                                            popularProducts[index].productPriceOffer.toString(),
                                                        style: (TextStyle(
                                                          //  fontFamily: 'RobotoSlab',
                                                          fontSize: 14,

                                                          color: AppColors.LOGO_BLACK,
                                                          fontWeight: FontWeight.w600,
                                                        )),textAlign: TextAlign.left,)),


                                              ],
                                            ),


                                            IconButton(

                                                icon: Icon(
                                                  Icons.shopping_cart_outlined,

                                                ),
                                                onPressed: null)
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.favorite_border_outlined,color: AppColors.GREY,),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),


          ],
        ),
      ) ;
    });
  }
}
