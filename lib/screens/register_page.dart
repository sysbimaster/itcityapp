import 'package:flutter/material.dart';

import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      obscureText: false,
      controller: _email,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Email',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Email';
        }
        return null;
      },
    );
    final mobileField = TextFormField(
      controller: _mobile,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Mobile number',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your mobile number';
        }
        return null;
      },
    );
    final passwordField = TextFormField(
      controller: _pass,
      obscureText: _obscureText,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: TextButton(
              onPressed: _toggle,
              child: new Text(_obscureText ? "Show" : "Hide",
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                  ))),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Password',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
    final confirmPasswordField = TextFormField(
      controller: _confirmPass,
      obscureText: _obscureText,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: TextButton(
              onPressed: _toggle,
              child: new Text(
                _obscureText ? "Show" : "Hide",
                style: TextStyle(color: Colors.deepOrangeAccent),
              )),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Confirm Password',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        // if (value.isEmpty) return 'Please enter your password';
        if (value != _pass.text) return "Not match";
        return null;
      },
    );

    return WillPopScope(
      onWillPop: ()async {
        Navigator.pushNamed(context, '/home');
        return true;

      } ,
      child: Scaffold(
          bottomNavigationBar: RegisterButton(
              formKey: _formKey,
              email: _email,
              mobile: _mobile,
              confirmPass: _confirmPass),
          backgroundColor: Colors.deepOrangeAccent,
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 18,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              elevation: 0.0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.orange, Colors.deepOrangeAccent])),
              )),
          body: Container(
            decoration: kContainerDecoration,
            child: new LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstrains) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstrains.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 36.0, right: 36, top: 10, bottom: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 33,
                                ),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          emailField,
                          SizedBox(height: 25.0),
                          mobileField,
                          SizedBox(height: 25.0),
                          passwordField,
                          SizedBox(height: 25.0),
                          confirmPasswordField,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          )),
    );
  }
}

class RegisterButton extends StatefulWidget {
  const RegisterButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController email,
    required TextEditingController mobile,
    required TextEditingController confirmPass,
  })  : _formKey = formKey,
        _email = email,
        _mobile = mobile,
        _confirmPass = confirmPass,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _email;
  final TextEditingController _confirmPass;
  final TextEditingController _mobile;

  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  bool? status;
  //FlutterSecureStorage _flutterSecureStorage = new FlutterSecureStorage();

  String? email;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        // TODO: implement listener
        if (state is CustomerLoginSuccessState ) {

         BlocProvider.of<UserBloc>(context).add(FetchCustomerInformationEvent(widget._email.text));
         Navigator.pushNamed(context, '/home');
        }
        if (state is UserRegistrationSuccessState) {
          CustomerRegistration customerRegistration = CustomerRegistration();
          customerRegistration.customerEmail = widget._email.text;
          customerRegistration.password = widget._confirmPass.text;
         // customerRegistration.password = widget._confirmPass.text;
          BlocProvider.of<UserBloc>(context)
              .add(CustomerLoginEvent(customerRegistration));
        } else if (state is CheckEmailStatusLoadedState) {
          if (!state.emailUsed!) {
            CustomerRegistration customer = CustomerRegistration();
            customer.customerEmail = widget._email.text;
            customer.password = widget._confirmPass.text;
            customer.customerMobile = widget._mobile.text;
            BlocProvider.of<UserBloc>(context)
                .add(UserRegistrationEvent(customer));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Email is Already Registered"),
            ));
          }
          //  BlocProvider.of<UserBloc>(context)
          //             .add(CheckMobileNumberStatusEvent(widget._mobile.value.text));
        } else if (state is CheckMobileNumberStatusLoadedState) {
          // print("Regsitering Customer"+state.toString());
          //  CustomerRegistration customer = CustomerRegistration();
          //         customer.customerEmail = widget._email.text;
          //         customer.password = widget._confirmPass.text;
          //         customer.customerMobile = widget._mobile.text;
          //         BlocProvider.of<UserBloc>(context)
          //             .add(UserRegistrationEvent(customer));
          // check mobile number status not working
        }
      },
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is CustomerLoginLoadingState ||
            state is CheckEmailStatusLoadingState ||
            state is CheckMobileNumberStatusLoadingState) {
          return MaterialButton(
            onPressed: () {},
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: SpinKitChasingDots(
              color: Colors.white,
            ),
          );
        }
        return Material(
          elevation: 5.0,
          color: Colors.deepOrangeAccent,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              setState(() {
                if (widget._formKey.currentState!.validate()) {
                  print("Checking Email Status");
                  BlocProvider.of<UserBloc>(context)
                      .add(CheckEmailStatusEvent(widget._email.value.text));
                  //CheckIfEmailExists / Check if mobile number exits
                  // if both are false createCustomer then if success
                  // root to edit customer info page
                  //

                  // BlocProvider.of<UserBloc>(context)
                  //     .add(CheckEmailStatusEvent(widget._email.text));
                  // if (state is CheckEmailStatusLoadingState) {
                  //   return Center(
                  //       child: SpinKitCircle(
                  //     color: Theme.of(context).primaryColor,
                  //     size: 50,
                  //   ));
                  // }

                  //   status = BlocProvider.of<UserBloc>(context).emailStatus;
                  //   if (state is CheckEmailStatusLoadedState) {
                  //     if (status == false) {
                  //       print('nothing');

                  //       CustomerRegistration customer = CustomerRegistration();
                  //       customer.customerEmail = widget._email.text;
                  //       customer.password = widget._confirmPass.text;
                  //       customer.customerMobile = widget._mobile.text;

                  //       BlocProvider.of<UserBloc>(context)
                  //           .add(UserRegistrationEvent(customer));
                  //       if (state is UserRegistrationLoadingState) {
                  //         print('customer...>>>' + customer.customerEmail);
                  //         return (Center(
                  //           child: CircularProgressIndicator(),
                  //         ));
                  //       }
                  //       if (state is UserRegistrationSuccessState) {
                  //         print('registered');

                  //       }
                  //     }
                  //     if (status == true) {
                  //       print(
                  //           '<<<<<<<<<<<<<<<<<<<<<<exist>>>>>>>>>>>>>>>>>>>>>>>>');
                  //     }
                  //   }

                }
              });
            },
            child: Text("Sign Up".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      }),
    );
  }
}
class CustomerDialog extends StatelessWidget {
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
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 100,
                    ),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text(
                              "Order placed Successfull,\n Thank you for your order \n We will contact you soon'",
                              style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
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
                          "Order Details",
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {

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
        ));
  }
}