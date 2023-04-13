import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/services/currency_api.dart';
import 'package:itcity_online_store/blocs/OrderHistory/order_history_bloc.dart';
import 'package:itcity_online_store/blocs/currency/currency_bloc.dart';
import 'package:itcity_online_store/blocs/review/random_review_bloc.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/OrderHistoryPage.dart';
import 'package:itcity_online_store/screens/login_page_new.dart';
import 'package:itcity_online_store/screens/select_country_page.dart';

import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:flutter/services.dart';


import 'blocs/bloc/search_bloc.dart';
import 'blocs/review/get_review_bloc.dart';

final ProductApi productApi = ProductApi();
final CartApi cartApi = CartApi();
final HomeApi homeApi = HomeApi();
final WishlistApi wishlistApi = WishlistApi();
final OrderApi orderApi = OrderApi();
final UserApi userApi = UserApi();
final CurrencyApi currencyApi = CurrencyApi();
final OrderHistoryPage orderHistoryPage = OrderHistoryPage();



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
     MyApp()  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
  ));
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(productApi: productApi),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(productApi: productApi),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(homeApi),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(cartApi),
          ),
          BlocProvider<WishlistBloc>(
            create: (context) => WishlistBloc(wishlistApi),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(userApi),
          ),
          BlocProvider<OrderBloc>(
            create: (context) => OrderBloc(orderApi),
          ),
           BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(productApi),
          ),
          BlocProvider<CurrencyBloc>(create: (context) => CurrencyBloc(currencyApi: currencyApi),
          ),
          BlocProvider<RandomReviewBloc>(create: (context) => RandomReviewBloc(productApi: productApi),
          ),
          BlocProvider<GetReviewBloc>(create: (context) => GetReviewBloc( productApi),
          ),
          BlocProvider<OrderHistoryBloc>(create: (context) => OrderHistoryBloc(orderApi),
          ),
        ],
        child: MaterialApp(

          // home: IntroPage(),
          initialRoute: '/',
          routes: {
            '/': (context) => IntroPage(),
          
            '/login': (context) => LoginPageNew(),
            '/home': (context) => MainPage(0),
        '/profile' :(context) => MainPage(4),
        '/cart' :(context) => MainPage(3),
          '/selectCountry': (context) => SelectCountryPage(),
        '/wishlist' :(context) => WishlistPage(),
          },
          title: 'itcity',
          theme: ThemeData(
            fontFamily: 'Myriad',
            primarySwatch: Colors.deepOrange,
            primaryColor:AppColors.LOGO_ORANGE,
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}
