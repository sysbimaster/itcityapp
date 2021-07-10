import 'package:flutter/material.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/home_page_new.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/screens/search_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              HomePageNew(),
              SearchPage(),
              WishlistPage(),
              CartPage(),
              ProfilePage(),
            ],
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
        tabs: [
          Tab(icon: Icon(Icons.home_outlined)),
          Tab(icon: Icon(Icons.search_rounded)),
          Tab(
            icon: Icon(Icons.apps_outlined),
          ),
          Tab(icon: Icon(Icons.shopping_cart_outlined)),
          Tab(icon: Icon(Icons.account_circle_outlined)),

        ],
      ),
    );
  }
}
