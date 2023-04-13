import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/blocs/blocs.dart';

import 'package:itcity_online_store/components/currency_bar.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:itcity_online_store/screens/privacy_policy_page.dart';

import 'package:itcity_online_store/screens/profile_page_new.dart';
import 'package:itcity_online_store/screens/return_policy_page.dart';
import 'package:itcity_online_store/screens/search_page.dart';
import 'package:itcity_online_store/screens/terms&condition_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'HomePageContentNew.dart';
import 'about_us_page.dart';
import 'delivery_information_page.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({Key? key}) : super(key: key);

  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  String? country;
  String? currency;
  int? cartcount = 0 ;
  TextEditingController controller = TextEditingController();
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.currency = prefs.getString('currency');
    this.country = prefs.getString('country');
    if (prefs.containsKey("email")) {

      BlocProvider.of<UserBloc>(context)
          .add(FetchCustomerInformationEvent(prefs.getString('email')));
    }
    if(prefs.containsKey('cartcount')){
      setState(() {
        cartcount = prefs.getInt('cartcount');
      });
    }
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    check().then((intenet) {
      if (intenet) {

        getCountry();
      } else {

        showDialog<void>(
          context: context,
          builder: (BuildContext context) => NoInternetDialog(),
        );
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Loader.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
  listener: (context, state) {

    // TODO: implement listener}
  },
  child: Scaffold(
      backgroundColor: AppColors.GREY,
      drawer: DrawerData(),
      appBar: AppBar(
        backgroundColor: AppColors.LOGO_ORANGE,
        title: Image.asset(
          'assets/images/logo_home.png',
          width: 130,
          height: 55,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        actions: [

//
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(78),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: Container(
                height: 34,
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: TextField(
                  enabled: false,
                  controller: controller,
                  decoration: InputDecoration(
                      // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(25, 2, 25, 2),
                      filled: true,
                      hoverColor: Colors.grey,
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Search Product, brands and more",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        padding: EdgeInsets.only(right: 20), onPressed: null,
                      ),
                      hintStyle:
                          Theme.of(context).inputDecorationTheme.hintStyle),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/selectCountry');
                },
                child: CurrencyBar())
          ]),
        ),
      ),
      body: HomePageContentNew(),
    ),
);
  }
}

class DrawerData extends StatefulWidget {
  const DrawerData();

  @override
  State<DrawerData> createState() => _DrawerDataState();
}

class _DrawerDataState extends State<DrawerData> {
  String? token ='';

  @override
  void initState() {
   loadprefs();
    // TODO: implement initState
    super.initState();
  }
  loadprefs()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token =  prefs.getString('token');
  }
  @override
  Widget build(BuildContext context) {

    void _handleLogout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('email');
      prefs.remove('isRegistered');
      prefs.remove('customerId');

      BlocProvider.of<UserBloc>(context).add(UserLogoutEvent());

    }

    final List<DrawerItem> drawer = [
      DrawerItem('Profile', Icons.account_circle, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProfilePageNew();
        }));
      }),

      DrawerItem('About Us', Icons.card_membership, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AboutUsPage();
        }));
      }),
      DrawerItem('Privacy Policy', Icons.chrome_reader_mode, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PrivacyPolicyPage();
        }));
      }),
      DrawerItem('Terms & Condition', Icons.calendar_today, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TermsPage();
        }));
      }),
      DrawerItem('Return Policy', Icons.class_rounded, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReturnPolicyPage();
        }));
      }),
      DrawerItem('Delivery Information', Icons.shopping_bag, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DeliveryInfoPage();
        }));
      }),
       //DrawerItem('Sign Out', Icons.exit_to_app, _handleLogout),
    ];

    if(token!.isNotEmpty){
      drawer.add(DrawerItem('Sign Out', Icons.exit_to_app, _handleLogout));
    }
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UserInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', ModalRoute.withName('/login'));
          }
        },
        child: Drawer(
          child: Padding(
            // padding: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.white54,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: drawer.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12, left: 12),
                          child: InkWell(
                            onTap: drawer[index].onTap as void Function()?,
                            child: Container(
                              height: 48,
                              //width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      drawer[index].icon,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(drawer[index].name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),

                // const Divider(
                //   color: Colors.white54,
                // ),
              ],
            ),
          ),
        ));
  }
}

class DrawerItem {
  final String name;
  final IconData icon;
  final Function onTap;

  const DrawerItem(this.name, this.icon, this.onTap);
}

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                      Icons.signal_wifi_connected_no_internet_4_outlined,
                      color: Colors.red,
                      size: 100,
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text("Uh Oh! Netowrk Problem",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                    ) //
                        ),
                    SizedBox(height: 24.0),
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
        ));
  }
}
