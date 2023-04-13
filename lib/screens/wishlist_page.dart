import 'dart:async';

import 'package:flutter/material.dart';


import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

          title: Text(
            'Wishlist',
            style: TextStyle(color: Colors.white),
          ),

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
  String? email;
  String? currency;
  List<CustomerWishlist> wishlist = [];
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    currency = prefs.getString('currency');
    return email;
  }
  @override
  void initState() {
    super.initState();
    getEmail().then((value) {
      if(value!=null){
        print("Current User Email" + email!);


        BlocProvider.of<WishlistBloc>(context).add(FetchWishlistEvent(value,this.currency),);
        print("email in wishlist page" +value);
      }else{
showDialogCart(context);
      }

    });


  }
  void removeItem(int index) {
    setState(() {
      wishlist = List.from(wishlist)..removeAt(index);
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
                    style: Theme.of(context).textTheme.titleLarge,
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
            padding: EdgeInsets.all(5),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .55,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return WishlistCard(
                      wishlist: wishlist == null ? '' as CustomerWishlist : wishlist[index],
                      onDelete: () => removeItem(index));
                },
                childCount: wishlist == null ? '' as int? : wishlist.length,
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
  showDialogCart(BuildContext context) async {
    showDialog(context: context, builder: (_) =>
    new Dialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 18.0,
              ),
              margin: EdgeInsets.only(top: 13.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Icon(
                    Icons.account_circle_outlined,
                    color: Colors.red,
                    size: 60,
                  ),
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Text(
                          "Please Login to view your favorites",
                          style:
                          TextStyle(fontSize: 18.0, color: Colors.black),
                          textAlign: TextAlign.center,),
                      ) //
                  ),
                  SizedBox(height: 24.0),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0)),
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  )
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }}
