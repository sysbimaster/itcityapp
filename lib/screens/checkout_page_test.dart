import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:itcity_online_store/screens/edit_profile_page.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.deepOrangeAccent,
          bottomNavigationBar: BottomNavigation(),
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 18,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Checkout',
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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstrains) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: viewportConstrains.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: Text(
                            "Delivery Address",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, state){
                            return Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(20.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                width: MediaQuery.of(context).size.width - 30,
                                height: 200,
                                child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.0),
                                        children: [
                                          TextSpan(
                                            text: state
                                            is CustomerInformationLoadedState
                                                ? state.customerlist
                                                .customerAddress !=
                                                null
                                                ? state.customerlist
                                                .customerAddress +
                                                ","
                                                : "No Address Available"
                                                : '',
                                          ),
                                          TextSpan(
                                            text: state
                                            is CustomerInformationLoadedState
                                                ? state.customerlist
                                                .customerDistrict !=
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
                                                ? state.customerlist
                                                .customerState !=
                                                null
                                                ? state.customerlist
                                                .customerState +
                                                ","
                                                : ""
                                                : '',
                                          ),
                                          TextSpan(
                                            text: state
                                            is CustomerInformationLoadedState
                                                ? state.customerlist
                                                .customerPincode !=
                                                null
                                                ? state.customerlist
                                                .customerPincode
                                                : ""
                                                : '',
                                          )
                                        ])));
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: FlatButton(
                            color: Colors.deepOrangeAccent,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return EditProfilePage(
                                      isAddressUpdate:true,
                                      function: (){
                                        Navigator.pop(context);
                                      },
                                    );
                                  }));
                            },
                            child: Text(
                              "Change / Update Address",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          )),
    );
  }
}
