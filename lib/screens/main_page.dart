import 'package:flutter/material.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/screens.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              HomePage(),
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
      color: AppColors.LOGO_ORANGE,
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.white,
        tabs: [
          Tab(icon: Icon(Icons.home)),
          Tab(
            icon: Icon(Icons.favorite),
          ),
          Tab(icon: Icon(Icons.shopping_cart)),
          Tab(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
