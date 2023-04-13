import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/components/CartCardNew.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/category_page.dart';
import 'package:itcity_online_store/screens/home_page_new.dart';
import 'package:itcity_online_store/screens/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_page_new.dart';

class MainPage extends StatefulWidget {
  int selectedPage;

  MainPage(this.selectedPage);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? cartcount = 0;
  @override
  void initState() {
   // checkCartCount();
    // TODO: implement initState
    super.initState();
  }

  checkCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('cartcount')){
      cartcount = prefs.getInt('cartcount');
      setState(()  {

       this.cartcount = cartcount;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if(state is CartDetailsLoadedState || state is CartAddRefreshLoadedState){
          setState(() {
            this.cartcount = BlocProvider.of<CartBloc>(context).currentCartList.length;

          });
        }

        // TODO: implement listener
      },
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                TextEditingController walletcontroller =
                TextEditingController();
                return AlertDialog(
                    title: Text('Exit'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Are You Sure You want to Exit'),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          SystemNavigator.pop();
                        },
                        child: Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context,false);
                        },
                        child: Text('No'),
                      )
                    ]);
              });
          return shouldPop!;
        } ,
        child: Scaffold(
          body: DefaultTabController(
            initialIndex: widget.selectedPage,
            length: 5,
            child: Scaffold(
              bottomNavigationBar: menu(),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HomePageNew(),
                  SearchPage(),
                  CategoryPage(),
                  CartCardNew(),
                  ProfilePageNew(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: AppColors.WHITE,
      child: TabBar(
        labelColor: AppColors.LOGO_ORANGE,
        unselectedLabelColor: AppColors.LOGO_BLACK,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: AppColors.LOGO_ORANGE,
        labelStyle: TextStyle(fontSize: 9.5),

        tabs: [
          Tab(icon: Icon(Icons.home_outlined), text: 'Home',),
          Tab(icon: Icon(Icons.search_rounded), text: 'Search',),
          Tab(
              icon: Icon(Icons.apps_outlined), text: 'Categories'
          ),
          Tab(icon: cartcount ==0 ? Icon(Icons.shopping_cart_outlined):
          badge.Badge(
            badgeContent: Text(cartcount.toString(),),
            child: Icon(Icons.shopping_cart_outlined),badgeStyle: badge.BadgeStyle(badgeColor: AppColors.LOGO_ORANGE),), text: 'Cart'),
          Tab(icon: Icon(Icons.account_circle_outlined), text: 'Profile'),
        ],
      ),
    );
  }
}
