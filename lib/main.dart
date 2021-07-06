import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/select_country_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:flutter/services.dart';

import 'blocs/bloc/search_bloc.dart';

final ProductApi productApi = ProductApi();
final CartApi cartApi = CartApi();
final HomeApi homeApi = HomeApi();
final WishlistApi wishlistApi = WishlistApi();
final OrderApi orderApi = OrderApi();
final UserApi userApi = UserApi();



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
        ],
        child: MaterialApp(

          // home: IntroPage(),
          initialRoute: '/',
          routes: {
            '/': (context) => IntroPage(),
          
            '/login': (context) => LoginPage(),
            '/home': (context) => MainPage(),
        '/profile' :(context) => ProfilePage(),
        '/cart' :(context) => CartPage(),
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
