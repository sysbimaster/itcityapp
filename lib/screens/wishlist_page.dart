import 'dart:async';

import 'package:flutter/material.dart';

import 'package:itcity_online_store/domain/mock/items.dart';
import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'login_page_new.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.WHITE,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Wishlist',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0.0,
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [Colors.orange, Colors.deepOrangeAccent])),
          // )
      ),
      body: Container(
          margin: EdgeInsets.all(8),
        //  decoration: kContainerFullDecoration,
          child: Stack(children: [WishlistSection()])),
    );
  }
}

//FlutterSecureStorage storage = new FlutterSecureStorage();

class WishlistSection extends StatefulWidget {
  @override
  _WishlistSectionState createState() => _WishlistSectionState();
}

class _WishlistSectionState extends State<WishlistSection> {
  String email;
  List<CustomerWishlist> wishlist = [];
  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = await  prefs.getString('email');;
    return email;
  }
  @override
  void initState() {
    super.initState();
    getEmail().then((value) {
      print("Current User Email" + email);


      BlocProvider.of<WishlistBloc>(context).add(FetchWishlistEvent(value));
      print("email in wishlist page" +value);
    });


  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      if (state is WishlistLoadedState) {
        wishlist = state.wishlist;
        if (wishlist.length == 0) {
          print("wishlist empty");
          return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    size: 100,
                    color: Colors.deepOrangeAccent[100],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "No Products In WishList",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  email == null
                      ? Column(
                          children: [
                            Text(
                                "Please Log in / Sign up to add products to wishlist"),
                            SizedBox(
                              height: 15.0,
                            ),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: AppColors.LOGO_ORANGE,
                              child: MaterialButton(
                                minWidth:
                                    MediaQuery.of(context).size.width * .75,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: navigateLoginPage,
                                child: Text("Login / Sign up".toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ));
        }
        return CustomScrollView(slivers: [
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return WishlistCard(
                      wishlist: wishlist == null ? '' : wishlist[index],
                      onDelete: () => removeItem(index));
                },
                childCount: wishlist == null ? '' : wishlist.length,
              ),
            ),
          )
        ]);
      }
      wishlist = BlocProvider.of<WishlistBloc>(context).customerWishlist;

      print('State of Wishlist product=>' + state.toString());

      if (state is WishlistLoadingState) {
        return Center(
            child: SpinKitRing(
          color: Colors.black,
          size: 20,
        ));
      }
      return Center(
          child: SpinKitRing(
        color: Colors.black,
        size: 20,
      ));
    });
  }

  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPageNew());
    Navigator.push(context, route).then(onGoBack);
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void removeItem(int index) {
    setState(() {
      wishlist = List.from(wishlist)..removeAt(index);
    });
  }
}
