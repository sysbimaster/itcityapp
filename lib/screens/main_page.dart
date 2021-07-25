import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/category_page.dart';
import 'package:itcity_online_store/screens/home_page_new.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/screens/search_page.dart';

import 'profile_page_new.dart';

class MainPage extends StatelessWidget {
  int selectedPage;

  MainPage(this.selectedPage);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColors.LOGO_DARK_ORANGE);
    return Scaffold(
      body: DefaultTabController(
        initialIndex: selectedPage,
        length: 5,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePageNew(),
              SearchPage(),
              CategoryPage(),
              CartPage(),
              ProfilePageNew(),
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
