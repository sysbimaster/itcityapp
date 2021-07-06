import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/edit_profile_page.dart';
import 'package:itcity_online_store/screens/order_history_page.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class ProfilePage extends StatelessWidget {
  final TabController controller;
  final int selected = 0;
  final bool showEdit;


  const ProfilePage({this.controller, this.showEdit = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.LOGO_ORANGE,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(

              icon:showEdit ? Icon(
                Icons.edit,
                size: 18,
              ):Container(),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfilePage();
                }));
              },
            ),
          ],
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange, Colors.deepOrangeAccent])),
          )),
      body: Container(
        margin: EdgeInsets.all(8),
        decoration: kContainerFullDecoration,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: CustomerInfo(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomerInfo extends StatefulWidget {
  @override
  _CustomerInfoState createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  CustomerRegistration customerInfo;
  String email;
  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email =  await prefs.getString('email');;
    return email;
  }

  @override
  void initState() {
    super.initState();
    getEmail().then((value) {
      print("Current User Email" + email);


      BlocProvider.of<UserBloc>(context)
          .add(FetchCustomerInformationEvent(value));
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      print('State of user=>' + state.toString());

      if (state is CustomerInformationLoadingState) {
        return Container(
            color: Colors.white,
            child: Center(
                child: SpinKitRing(
              color: Colors.black,
              size: 20,
            )));
      } else if (state is CustomerInformationLoadedState) {
        print(">>>>>>>>>>>>>>>>>>>>>>" + state.customerlist.toString());
        customerInfo = state.customerlist;
      }else if(email == null){
        return Container(
            alignment: Alignment.center,
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_box_outlined,size: 100,color: Colors.deepOrangeAccent[100],),
                SizedBox(height:10),
                Text("Please Login or Signup",style: Theme.of(context).textTheme.headline6,),
                SizedBox(
                  height: 15.0,
                ),



                Material(

                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: AppColors.LOGO_ORANGE,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width*.75,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: navigateLoginPage,

                    child: Text("Login / Sign Up".toUpperCase(),
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),


              ],
            ));
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
                Container(
                  child: Text(
                    state is CustomerInformationLoadedState
                        ? state.customerlist.customerName != null
                            ? state.customerlist.customerName
                            : 'customer'
                        : 'customer',
                    style: (TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: Colors.orangeAccent[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  title: Text(
                      customerInfo == null ? '' : customerInfo.customerMobile,
                      style: TextStyle(
                         color: Colors.white,
                        fontFamily: 'RobotoSlab',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    Icons.mail,
                color: Colors.white,
                  ),
                  title: Text(
                    
                      customerInfo.customerEmail == null
                          ? email
                          : customerInfo.customerEmail,
                      style: TextStyle(
                         color: Colors.white,
                        fontFamily: 'RobotoSlab',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Monospace',
                              color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: state
                                            is CustomerInformationLoadedState
                                        ? state.customerlist.customerAddress !=
                                                null
                                            ? state.customerlist
                                                    .customerAddress +
                                                ","
                                            : ""
                                        : '',
                                  ),
                                  TextSpan(
                                    text: state
                                            is CustomerInformationLoadedState
                                        ? state.customerlist.customerDistrict !=
                                                null
                                            ? state.customerlist
                                                    .customerDistrict +
                                                ","
                                            : ""
                                        : '',
                                  ),
                                  TextSpan(
                                    text: state
                                            is CustomerInformationLoadedState
                                        ? state.customerlist.customerState !=
                                                null
                                            ? state.customerlist.customerState +
                                                ","
                                            : ""
                                        : '',
                                  ),
                                  TextSpan(
                                    text: state
                                            is CustomerInformationLoadedState
                                        ? state.customerlist.customerPincode !=
                                                null
                                            ? state.customerlist.customerPincode
                                            : ""
                                        : '',
                                  )
                                ])),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WishlistPage();
                    }));
                  },
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.favorite,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('My Wishlist',
                      style: TextStyle(fontSize: 20, shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.4, .4),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ])),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OrderHistoryPage();
                    }));
                  },
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.history,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('My Orders',
                      style: TextStyle(fontSize: 20, shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(253, 0, 0, 0),
                        ),
                      ])),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) => LoginPage());
    Navigator.push(context, route).then(onGoBack);
  }
  FutureOr onGoBack(dynamic value) {

    setState(() {});
  }
}
