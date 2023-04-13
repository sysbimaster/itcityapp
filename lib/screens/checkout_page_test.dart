import 'package:flutter/material.dart';


import 'package:itcity_online_store/components/address_checkout.dart';
import 'package:itcity_online_store/components/order_summary.dart';
import 'package:itcity_online_store/resources/values.dart';

import 'package:itcity_online_store/screens/edit_profile_page.dart';
import 'package:itcity_online_store/screens/order_successpage_new.dart';

import 'package:itcity_online_store/components/components.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PaymentMethod { ktet, card, cod }

class CheckOutNew extends StatefulWidget {
  const CheckOutNew({Key? key}) : super(key: key);

  @override
  _CheckOutNewState createState() => _CheckOutNewState();
}

class _CheckOutNewState extends State<CheckOutNew> {
  PaymentMethod _paymentMethod = PaymentMethod.cod;
  TextEditingController _textEditingController = TextEditingController();
  String? country;
  String? currency = ' ';
  getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.currency = prefs.getString('currency');
      this.country = prefs.getString('country');
    });
  }
  @override
  void initState() {
    getCountry();
    // TODO: implement initState
    super.initState();
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Placing your Order..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<OrderBloc, OrderState>(
  listener: (context, state) {
    print('ordr success state'+ state.toString());
    if(state is CreateOrderLoadingState){
      print('Loading state worked');

      showLoaderDialog(context);
    }
    if (state is CreateOrderSuccessState) {
      Navigator.canPop(context);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return OrderSucessNew(
            orderStatusNew: BlocProvider.of<OrderBloc>(context).orderStatusNew,currency: this.currency,);
      }), (Route<dynamic> route) => false);
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) => CheckoutDialog());


    }
    else if (state is CreateOrderErrorState){
      Navigator.canPop(context);
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.clear_outlined,
                    color: AppColors.WHITE,
                    size: 75,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Something Went Wrong",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Please Try Again Later",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            );
          });
    } else {

    }
    // TODO: implement listener}
  },
  child: Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: AppBar(
        backgroundColor: AppColors.LOGO_ORANGE,
        title: Text(
          'Check Out',
          style: TextStyle(color: AppColors.WHITE, fontSize: 25),
        ),
        elevation: 1.0,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstrains) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstrains.maxHeight),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .98,
                    height: MediaQuery.of(context).size.height * .08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.GREY,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Row(
                        children: [
                          Radio(
                            value: PaymentMethod.ktet,
                            groupValue: _paymentMethod,
                            onChanged: (PaymentMethod? value) {},
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text("Knet",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.GREY_TEXT))),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .98,
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.GREY,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Row(
                          children: [
                            Radio(
                              value: PaymentMethod.card,
                              groupValue: _paymentMethod,
                              onChanged: (PaymentMethod? value) {},
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text("Credit / Debit Card",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.GREY_TEXT))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .98,
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.GREY,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Row(
                          children: [
                            Radio(
                              value: PaymentMethod.cod,
                              groupValue: _paymentMethod,
                              autofocus: true,
                              activeColor: Colors.green,
                              onChanged: (PaymentMethod? value) {},
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Cash on Delivery",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.LOGO_BLACK),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AddressCheckout(),
                  SizedBox(
                    height: 5,
                  ),
                  OrderSummary(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: "Please write remarks if any",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 7,
                    ),
                  ),
                  SizedBox(height: 5),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      if (state is CreatePurchaseSuccessState) {
                        return BlocBuilder<UserBloc, UserState>(
                          builder: (context, userState) {
                            if (userState is CustomerInformationLoadedState) {
                              bool Address = userState.customerlist
                                  .customerAddress != null;
                              print("Addressbool" + Address.toString());

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width * .95,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          .07),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            AppColors.LOGO_ORANGE),
                                      ),
                                      onPressed: Address ? () {

                                        Order order = Order();
                                        order.purchaseId =
                                            state.purchase.purchaseId;
                                        order.customerId =
                                            userState.customerlist.customerId;
                                        order.currency = currency;
                                        order.remarks = this._textEditingController.value.text;
                                        order.totalAmount = state.purchase.productSubTotal!.toStringAsFixed(2);
                                        BlocProvider.of<OrderBloc>(context)
                                            .add(CreateOrderEvent(order));
                                      } : () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Please Update the address"),
                                            ));
                                      },
                                      child: Text(
                                        'CONFIRM ORDER',
                                        style: TextStyle(fontSize: 25),
                                      )),
                                ),
                              );
                            }
                            return Container();
                            },
                        );
                      }
                      return Container(

                          color: AppColors.WHITE,
                          child: Center(
                              child: SpinKitRipple(
                                color: Theme.of(context).primaryColor,
                                size: 50,
                              )));
                    },
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      }),
    ),
));
  }
}

class CheckoutPageTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.deepOrangeAccent,
          bottomNavigationBar: BottomNavigation(),
          appBar: AppBar(
            backgroundColor: AppColors.LOGO_ORANGE,
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
            //centerTitle: true,
            elevation: 1.0,
            // flexibleSpace: Container(
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //           begin: Alignment.topCenter,
            //           end: Alignment.bottomCenter,
            //           colors: [Colors.orange, Colors.deepOrangeAccent])),
            // )
          ),
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
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
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
                                                            .customerAddress! +
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
                                                            .customerDistrict! +
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
                                                            .customerState! +
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
                          child: TextButton(
                            onPressed: () {
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
                            child: Text(
                              "Change / Update Address",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
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
