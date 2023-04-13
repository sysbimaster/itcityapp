import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/customer_registration.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressCheckout extends StatefulWidget {
  const AddressCheckout({Key? key}) : super(key: key);

  @override
  _AddressCheckoutState createState() => _AddressCheckoutState();
}

class _AddressCheckoutState extends State<AddressCheckout> {
  String? CustomerId;
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CustomerId = prefs.getString("email");
    BlocProvider.of<UserBloc>(context).add(FetchCustomerInformationEvent(CustomerId));
  }
  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {

    if(state is CustomerInformationLoadedState){
      CustomerRegistration customer = BlocProvider.of<UserBloc>(context).customer!;
     return customer.customerAddress == null?  Container(
        color: AppColors.WHITE,
        height: MediaQuery.of(context).size.height * .25,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/icons/icon_address.png',),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Shipping Address',style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 25),),
                    SizedBox(height: 10,),
                    Text('Sorry,There is no Shipping Address',style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 17),),
                    SizedBox(height: 15,),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColors.LOGO_ORANGE,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width*.50,
                        height:  MediaQuery.of(context).size.height * .05,
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                        onPressed: (){
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
                        child: Text("Add New Address".toUpperCase(),
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ):Container(
       width: MediaQuery.of(context).size.width,
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Shipping Address',style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 25,)),
                 OutlinedButton(onPressed: () async {

                   Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(
                     isAddressUpdate: true,
                     function: () {
                       Navigator.pop(context);
                     },
                   )));
                 }, child: Text('CHANGE',style: TextStyle(fontSize: 16,color: AppColors.LOGO_ORANGE),),style: OutlinedButton.styleFrom(
                     side: BorderSide(width: 2,color: AppColors.LOGO_ORANGE)
                 ))

               ],
             ),
             SizedBox(height: 5,),
             Text(customer.customerAddress!,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20),),
             Text(customer.customerDistrict!,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
             Text(customer.customerState!,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
             Text(customer.customerPincode!,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),
             Text("mob: "+customer.customerMobile!,style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20)),


           ],
         ),
       ),
     );
    }
    return Container(

      color: AppColors.WHITE,
      child: Center(
          child: SpinKitRipple(
            color: Theme.of(context).primaryColor,
            size: 50,
          )),
    );


      },
    );
  }
  void navigateLoginPage() {
    Route route = MaterialPageRoute(builder: (context) =>  EditProfilePage(
      isAddressUpdate: true,
      function: () {
        Navigator.pop(context);
      },
    ));
    Navigator.push(context, route).then(onGoBack);


  }
  FutureOr onGoBack(dynamic value) {

    setState(() {
      BlocProvider.of<UserBloc>(context).add(FetchCustomerInformationEvent(CustomerId));
    });

  }
}
