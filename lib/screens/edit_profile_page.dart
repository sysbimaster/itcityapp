import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/customer_registration.dart';
import 'package:itcity_online_store/blocs/user/user.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:itcity_online_store/screens/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  Function? function;
  bool isAddressUpdate;
  EditProfilePage({Key? key, this.function, this.isAddressUpdate = false})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? email = "";
  String? customerIdtest;
  late UserBloc userBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController distController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? customerId;
  StreamSubscription? subscription;

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString("email");
    customerIdtest = prefs.getString('customerId');

    this.email = email;
    emailController.text = this.email!;
    userBloc = BlocProvider.of<UserBloc>(context);
    return email;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getEmail().then((value) {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is CustomerInformationUpdatedState) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('isRegistered');
          if (widget.function != null) {
            BlocProvider.of<UserBloc>(context).add(FetchCustomerInformationEvent(email));
            widget.function!();

          } else {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
                  return MainPage(0);
                }), (route) => false);
          }
        }
      },
      child: Scaffold(
        bottomNavigationBar: Material(
            elevation: 5.0,
            color: AppColors.LOGO_ORANGE,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is CustomerInformationLoadedState) {
                  return MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      if (this._formKey.currentState!.validate()) {
                        // Delete this after the information has been saved
                        CustomerRegistration customerRegistration =
                            CustomerRegistration();
                        customerRegistration.customerMobile =
                            this.mobileNumberController.text;
                        customerRegistration.customerEmail =
                            this.emailController.text;
                        customerRegistration.customerName =
                            this.nameController.text;
                        customerRegistration.customerDistrict =
                            this.distController.text;
                        customerRegistration.customerAddress =
                            this.addressController.text;
                        customerRegistration.customerState =
                            this.stateController.text;
                        customerRegistration.customerPincode =
                            this.pincodeController.text;
                        customerRegistration.customerId = this.customerId;
                        userBloc.add(UpdateCustomerEvent(customerRegistration));
                      }
                    },
                    child: Text("Save".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  );
                }
                return SizedBox.shrink();
              },
            )),
        appBar: AppBar(
          title:widget.isAddressUpdate?Text("Edit Address Details") :Text("Edit Profile Details"),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is CustomerInformationLoadedState) {
                if (this.customerId == null) {
                  customerId = state.customerlist.customerId;
                  mobileNumberController.text =
                      state.customerlist.customerMobile!;
                  nameController.text = state.customerlist.customerName!;
                  distController.text =
                      state.customerlist.customerDistrict ?? "";
                  stateController.text = state.customerlist.customerState ?? "";
                  addressController.text =
                      state.customerlist.customerAddress ?? "";
                  pincodeController.text =
                      state.customerlist.customerPincode ?? "";
                }


                return Container(
                  height: MediaQuery.of(context).size.height - 120,
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         TextFormField(
                          controller: nameController,
                         // enabled: widget.isAddressUpdate ? false : true,
                          decoration: InputDecoration(
                              hintText: "Name",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is Requred";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "Email",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is Requred";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: mobileNumberController,
                          decoration: InputDecoration(
                              hintText: "Mobile Number",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mobile Number is Requred";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                              hintText: "Address",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address is Requred";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: distController,
                          decoration: InputDecoration(
                              hintText: "Place / Area ",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Place / Area is Required";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: stateController,
                          decoration: InputDecoration(
                              hintText: "Country",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Country is Requred";
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: pincodeController,
                          decoration: InputDecoration(
                              hintText: "Pincode",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Pincode is Requred";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                height: MediaQuery.of(context).size.height - 200,
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: SpinKitRing(
                    color: Colors.orangeAccent,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
