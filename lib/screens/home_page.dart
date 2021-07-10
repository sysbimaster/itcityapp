import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/blocs/user/user_bloc.dart';
import 'package:itcity_online_store/blocs/user/user_event.dart';
import 'package:itcity_online_store/blocs/user/user_state.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/edit_profile_page.dart';
import 'package:itcity_online_store/screens/screens.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:itcity_online_store/screens/search_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page_new.dart';

//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  UserBloc userBloc;

  var _controller = TextEditingController();
  AnimationController _animationController;

  void readData () async {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();

   if (prefs.containsKey('email')){
     userBloc.add(FetchCustomerInformationEvent(prefs.getString('email')));
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
    super.initState();

    check().then((intenet) {
      if (intenet != null && intenet) {
        print('internetConnection');
        readData ();
      }
      print(' No internetConnection');
      showDialog<void>(
        context: context,
        builder:(BuildContext context) => NoInternetDialog(),
      );
    });
    // final storage = new SecureStorage();
    // storage.read(key: "email").then((value) {
    //   print(value + "Current user email");
    //   userBloc.add(FetchCustomerInformationEvent(value));
    //   storage.read(key: "isRegistered").then((value) {
    //     print("Is Registered" + value.toString());
    //     if (value != null) {
    //       Navigator.pushAndRemoveUntil(context,
    //           MaterialPageRoute(builder: (context) {
    //             return EditProfilePage(isAddressUpdate: false,);
    //           }), (route) => false);
    //     }
    //   });
    // });
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  _toggleAnimation() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.orange[600]);
    final rightSlide = MediaQuery.of(context).size.width * 0.6;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double slide = rightSlide * _animationController.value;
        double scale = 1 - (_animationController.value * 0.3);
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: DrawerData(),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(slide)
                ..scale(scale),
              alignment: Alignment.center,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                    title : Image.asset(
                      'assets/images/Logo.png',
                      width: 170,
                      height: 170,
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                        },
                        icon: Icon(Icons.search,color:AppColors.LOGO_ORANGE,size: 30,),
                      ),


                      // IconButton(
                      //   icon: Icon(
                      //     Icons.track_changes,
                      //     color: Colors.white,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return LatestOrderPage();
                      //     }));
                      //   },
                      // ),
                    ],
                    leading: IconButton(
                      onPressed: () => _toggleAnimation(),
                      icon: AnimatedIcon(
                        color:AppColors.LOGO_ORANGE,
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController,
                        size: 30,
                      ),
                    ),
                    flexibleSpace: Container(
                     // decoration: kAppBarContainerDecoration,
                    )),
                body: HomePageContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DrawerData extends StatelessWidget {
  const DrawerData();
  @override
  Widget build(BuildContext context) {
    void _handleLogout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('email');
      prefs.remove('isRegistered');
      // await _flutterSecureStorage.delete(key: 'token');
      // await _flutterSecureStorage.delete(key: 'email');
      // await _flutterSecureStorage.delete(key: 'isRegistered');
      BlocProvider.of<UserBloc>(context).add(UserLogoutEvent());
      print('remove token............................');
    }

    final List<DrawerItem> drawer = [
      DrawerItem('Profile', Icons.account_circle, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProfilePage();
        }));
      }),
      DrawerItem('Language', Icons.language, () {}),
      DrawerItem('Currency', Icons.money, () {}),
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
      DrawerItem('Return Policy', Icons.class__rounded, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReturnPolicyPage();
        }));
      }),
      DrawerItem('Delivery Information', Icons.shopping_bag, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DeliveryInfoPage();
        }));
      }),
      DrawerItem('Sign Out', Icons.exit_to_app, _handleLogout),
    ];
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UserInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', ModalRoute.withName('/login'));
          }
        },
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
                          onTap: drawer[index].onTap,
                          child: Container(
                            height: 48,
                            width: double.infinity,
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
        ));
  }
}

class DrawerItem {
  final String name;
  final IconData icon;
  final Function onTap;

  const DrawerItem(this.name, this.icon, this.onTap);
}
