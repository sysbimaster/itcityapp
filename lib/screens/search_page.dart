import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/blocs/bloc/search_bloc.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/product_card.dart';

import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? country;
  String? currency;
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.currency = prefs.getString('currency');
    this.country = prefs.getString('country');

  }

  @override
  void initState() {
    getCountry();// TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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

    if(BlocProvider.of<CartBloc>(context).page!.compareTo('cartpage') ==1 ){
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

    // if (state is AddProductToCartLoadingState) {
    //   Loader.show(context,
    //       isAppbarOverlay: true,
    //       isBottomBarOverlay: false,
    //       progressIndicator: CircularProgressIndicator(),
    //       themeData:
    //       Theme.of(context).copyWith(accentColor: Colors.black38),
    //       overlayColor: Colors.black26);
    // } else if (state is AddProductToCartSuccessState) {
    //   Loader.hide();
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         // print("model run 1");
    //         return Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               Text(
    //                 "Product added to Cart",
    //                 style: TextStyle(fontSize: 27),
    //                 textAlign: TextAlign.center,
    //               ),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Container(
    //                     constraints: BoxConstraints(
    //                       minHeight:
    //                       MediaQuery.of(context).size.height * .07,
    //                     ),
    //                     width: MediaQuery.of(context).size.width * .35,
    //                     child: TextButton(
    //                         style: ButtonStyle(
    //                           backgroundColor:
    //                           MaterialStateProperty.all<Color>(
    //                               AppColors.WHITE),
    //                           shape: MaterialStateProperty.all<
    //                               RoundedRectangleBorder>(
    //                               RoundedRectangleBorder(
    //                                   borderRadius:
    //                                   BorderRadius.circular(10.0),
    //                                   side: BorderSide(
    //                                       color: AppColors.LOGO_ORANGE))),
    //                           foregroundColor:
    //                           MaterialStateProperty.all<Color>(
    //                               AppColors.LOGO_ORANGE),
    //                         ),
    //                         onPressed: () {
    //                           print("pop clicked");
    //                           Navigator.of(context).pop();
    //                         },
    //                         child: Text(
    //                           "CONTINUE SHOPPING",
    //                           style: TextStyle(fontSize: 16),
    //                           textAlign: TextAlign.center,
    //                         )),
    //                   ),
    //                   Container(
    //                     constraints: BoxConstraints(
    //                       minHeight:
    //                       MediaQuery.of(context).size.height * .07,
    //                     ),
    //                     width: MediaQuery.of(context).size.width * .35,
    //                     child: TextButton(
    //                         style: ButtonStyle(
    //                           backgroundColor:
    //                           MaterialStateProperty.all<Color>(
    //                               AppColors.LOGO_ORANGE),
    //                           shape: MaterialStateProperty.all<
    //                               RoundedRectangleBorder>(
    //                               RoundedRectangleBorder(
    //                                   borderRadius:
    //                                   BorderRadius.circular(10.0),
    //                                   side: BorderSide(
    //                                       color: AppColors.LOGO_ORANGE))),
    //                           foregroundColor:
    //                           MaterialStateProperty.all<Color>(
    //                               AppColors.WHITE),
    //                         ),
    //                         onPressed: () {
    //                           Navigator.pushNamedAndRemoveUntil(
    //                               context, "/cart", (route) => false);
    //                         },
    //                         child: Text(
    //                           "GO TO CART",
    //                           style: TextStyle(fontSize: 16),
    //                           textAlign: TextAlign.center,
    //                         )),
    //                   )
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 35,
    //               ),
    //             ],
    //           ),
    //         );
    //       });
    // } else if (state is AddProductToCartErrorState) {
    //   Loader.hide();
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             SizedBox(
    //               height: 35,
    //             ),
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.red,
    //                 shape: BoxShape.circle,
    //               ),
    //               child: Icon(
    //                 Icons.clear_outlined,
    //                 color: AppColors.WHITE,
    //                 size: 75,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 25,
    //             ),
    //             Text(
    //               "Something Went Wrong",
    //               style: TextStyle(fontSize: 18),
    //               textAlign: TextAlign.center,
    //             ),
    //             SizedBox(
    //               height: 15,
    //             ),
    //             Text(
    //               "Please Try Again Later",
    //               style: TextStyle(fontSize: 18),
    //               textAlign: TextAlign.center,
    //             ),
    //             SizedBox(
    //               height: 35,
    //             ),
    //           ],
    //         );
    //       });
    // } else {
    //   Loader.hide();
    // }

    // TODO: implement listener
  },
  child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.LOGO_ORANGE,
        title: Image.asset(
          'assets/images/logo_home.png',
          width: 130,
          height: 55,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        leading: SizedBox.shrink(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: TextField(
                autofocus: true,
                controller: controller,
                onChanged: (value){
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchTermEvent(value,this.currency));
                },
                onSubmitted: (value) {

                },
                decoration: InputDecoration(
                    // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    filled: true,
                    hoverColor: Colors.grey,
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(50.0),
                        ),
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "Search Product, brands and more",
                    suffixIcon: IconButton(
                      onPressed: () {
                        // controller.
                        BlocProvider.of<SearchBloc>(context)
                            .add(SearchTermEvent(controller.value.text,this.currency));
                      },
                      icon: Icon(Icons.search),
                    ),
                    hintStyle:
                        Theme.of(context).inputDecorationTheme.hintStyle),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchSuccessState) {
            if(state.product.isNotEmpty){
              return GridView.builder(
                  itemCount: state.product.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .53,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(product:state.product[index],currency: this.currency,);
                  });
            } else {
              return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.signal_cellular_connected_no_internet_4_bar,size: 150,color: AppColors.GREY,),
                      SizedBox(height:10),
                      Text("SORRY!",style: TextStyle(
                          color: AppColors.GREY_TEXT,fontSize: 50
                      ),),
                      Text("We could not find any products . Please try again later",style: TextStyle(
                          color: AppColors.GREY_TEXT,fontSize: 20
                      ),textAlign: TextAlign.center,)
                    ],
                  ));
            }

          } else if (state is SearchLoadingState) {
            return SpinKitRing(
              color: AppColors.LOGO_ORANGE,

            );
          }
          return Container();
        },
      ),
    ),
);
  }
}
