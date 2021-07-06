import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/components/currency_bar.dart';

import '../constants.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<Product> featuredproducts = [];
  List<Product> popularproducts = [];
  List<CustomerWishlist> wishlist = [];
  SharedPreferences prefs;

  bool isCommon = false;
  void initPref() async {
prefs = await SharedPreferences.getInstance();
if(prefs.containsKey("email")){
  BlocProvider.of<WishlistBloc>(context).add(FetchWishlistEvent(prefs.getString("email")));
} else {
  BlocProvider.of<WishlistBloc>(context).add(FetchWishlistEvent(" "));
}

}
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    //   bool commonProduct(Product product, List<CustomerWishlist> productList) {
    //   for (int i = 0; i < productList.length; i++) {
    //     if ((product.productId) == (productList[i].productId)) {
    //       print(product.productId);
    //       setState(() {
    //         isCommon = true;
    //       });

    //       print('=================== fav ============');
    //     } else {
    //       setState(() {
    //         isCommon = false;
    //       });
    //     }
    //   }
    //   print('common      ' + isCommon.toString());
    //   return isCommon;
    // }
    if (BlocProvider.of<HomeBloc>(context).state is HomeInitial) {
      BlocProvider.of<HomeBloc>(context).add(FetchFeaturedProduct());
      BlocProvider.of<HomeBloc>(context).add(FetchPopularProduct());
      initPref();


      // final storage = new SecureStorage();
      // storage.read(key: "email").then((value) {
      //   BlocProvider.of<WishlistBloc>(context).add(FetchWishlistEvent(value));
      // });
    }
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
      print(featuredproducts.length.toString());
      featuredproducts = BlocProvider.of<HomeBloc>(context).featuredProduct;
      popularproducts = BlocProvider.of<HomeBloc>(context).popularProduct;
      wishlist = BlocProvider.of<WishlistBloc>(context).customerWishlist;
      print('State of home =>' + homeState.toString());

      if (homeState is PopularProductLoadingState ||
          homeState is FeaturedProductLoadingState) {
        print('circular');
        return Center(
            child: SpinKitPouringHourglass(
          color: Theme.of(context).primaryColor,
          size: 50,
        ));
      }

      return Container(
        decoration: kContainerDecoration,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(children: [
               CurrencyBar(),
                CategoryCard(),
                BannerList(),

                ListHeader(
                  headerName: 'Deal of the Day ',
                  leftWidget: TimerApp(),
                  onTap: () {},
                ),
                DailyDeals(),
                ListHeader(
                  headerName: 'Featured Product',
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: Container(

                    color: Colors.white38,
                    child: GridView.builder(

                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: featuredproducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisCount: 2,
                          childAspectRatio: .52,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return ProductList(
                              product: featuredproducts == null
                                  ? ''
                                  : featuredproducts[index],
                              wish: false);
                        }),
                  ),
                ),
                ListHeader(
                  headerName: 'Popular Products',
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  child: Container(

                    color: Colors.white38,
                    child:  GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: popularproducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .52,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return ProductList(
                              product: popularproducts == null
                                  ? ''
                                  : popularproducts[index],
                              wish: false);
                        }),
                  ),
                ),
              ]),
            ),
          );
        }),
      );
    });
  }
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

var date = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(date);
var dateParse = DateTime.parse(formattedDate);
var formatted = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
final eventTime = DateTime.parse('${formattedDate.toString()} 24:00:00');

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);
  int timeDiff = eventTime.difference(DateTime.now()).inSeconds;
  bool isActive = false;
  Timer timer;
  @override
  void initState() {
    super.initState();
    // setState(() {
    isActive = !isActive;
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleTick() {
    if (timeDiff > 0) {
      if (isActive) {
        if (mounted) {
          setState(() {
            if (eventTime != DateTime.now()) {
              timeDiff = timeDiff - 1;
            } else {
              print('Times up!');
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int hours = timeDiff ~/ (60 * 60) % 24;
    int minutes = (timeDiff ~/ 60) % 60;
    int seconds = timeDiff % 60;

    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // color: Colors.orange[500],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
         
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LabelText(
                    label: 'HRS', value: hours.toString().padLeft(2, '0')),
                LabelText(
                    label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                LabelText(
                    label: 'SEC', value: seconds.toString().padLeft(2, '0')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value $label ',
      style: TextStyle(
          color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
    );
  }
}
