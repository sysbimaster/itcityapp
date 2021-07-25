import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/customer_registration.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_page.dart';

class ProfilePageNew extends StatefulWidget {
  const ProfilePageNew({Key key}) : super(key: key);

  @override
  _ProfilePageNewState createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends State<ProfilePageNew> {
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
      if(value!= null){
        print("Current User Email" + email);
        BlocProvider.of<UserBloc>(context)
            .add(FetchCustomerInformationEvent(value));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        customerInfo = BlocProvider.of<UserBloc>(context).customer;
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
         // customerInfo = state.customerlist;
        }
        return Scaffold(
          backgroundColor: AppColors.WHITE,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.LOGO_ORANGE,
            title: Text(
              'My Profile',
              style: TextStyle(color:AppColors.WHITE,fontSize: 25),
            ),


            elevation: 1.0,

          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .20,
                  color: AppColors.LOGO_ORANGE,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state is CustomerInformationLoadedState
                                  ? state.customerlist.customerName != null
                                  ? state.customerlist.customerName
                                  : 'Customer'
                                  : 'Customer',style: TextStyle(
                                fontSize: 35,
                                color: AppColors.WHITE
                              ),),
                              state is CustomerInformationLoadedState
                              ?Text(customerInfo.customerEmail == null
                                  ? email
                                  : customerInfo.customerEmail,style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.WHITE
                              )):TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Row(
                                children: [
                                  Icon(Icons.login,color: Colors.white,size: 25,),
                                  SizedBox(width: 3,),
                                  Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),)
                                ],
                              ),)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child:  CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.GREY_TEXT,
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: AppColors.GREY,
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .26,
                  decoration: BoxDecoration(
                    border:  Border(
                      top: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
                      bottom: BorderSide(width: 1.0, color: Color(0xFFEEEEEE)),
                    ) ,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                          child: Text('Activities',style: TextStyle(color: AppColors.GREY_TEXT,fontSize: 25),),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context) =>WishlistPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              children: [
                                Image.asset('assets/images/icons/favourite.png',width: 25,height: 25,),
                                SizedBox(width: 15,),
                                Text('Favourites',style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: Row(
                            children: [
                              Image.asset('assets/images/icons/order.png',width: 25,height: 25,),
                              SizedBox(width: 15,),
                              Text('Orders',style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return EditProfilePage(
                                    isAddressUpdate: true,
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              children: [
                                Image.asset('assets/images/icons/icon_address.png',width: 25,height: 25,),
                                SizedBox(width: 15,),
                                Text('Home Address',style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: Row(
                            children: [
                              Image.asset('assets/images/icons/help.png',width: 25,height: 25,),
                              SizedBox(width: 15,),
                              Text('Online Help',style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .07,
                  decoration: BoxDecoration(
                    border:  Border(
                      top: BorderSide(width: 0.5, color: Color(0xFFEEEEEE)),
                      bottom: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
                    ) ,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return AboutUsPage();
                            }));
                  },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              children: [
                                Image.asset('assets/images/icons/about.png',width: 25,height: 25,),
                                SizedBox(width: 15,),
                                Text('About',style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .14,
                  decoration: BoxDecoration(
                    border:  Border(
                      top: BorderSide(width: 0.5, color: Color(0xFFEEEEEE)),
                      bottom: BorderSide(width: 1.5, color: Color(0xFFEEEEEE)),
                    ) ,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(05, 10, 0, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return TermsPage();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              children: [
                               Text('Terms & Conditions',style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return PrivacyPolicyPage();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              children: [
                                Text('Privacy Policy',style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: Row(
                            children: [
                              Text('Log Out',style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
