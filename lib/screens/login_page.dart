import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _passValue = '';
  String _emailValue = '';

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.orange[600]);

    final emailField = TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      onSaved: (String value) {
        _emailValue = value;
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Email",
          prefixIcon: Icon(Icons.person, color: Colors.black),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
    final passwordField = TextFormField(
      obscureText: _obscureText,
      controller: _password,
      onSaved: (String value) {
        _passValue = value;
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: FlatButton(
              onPressed: _toggle,
              child: new Text(
                _obscureText ? "Show" : "Hide",
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
              )),
          prefixIcon: Icon(Icons.lock, color: Colors.black),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );

    final sellButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepOrangeAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SellOnItcityPage(),
              ));
        },
        child: Text("Sell On It City".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final signUpButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepOrangeAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),(Route<dynamic> route) => false);
        },
        child: Text("Create an Account".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
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
              decoration: kAppBarContainerDecoration,
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
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 33,
                                  ),
                                )),
                            SizedBox(
                              height: 55,
                            ),
                            emailField,
                            SizedBox(height: 25.0),
                            passwordField,
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              alignment: Alignment(1.0, 0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPasswordPage(),
                                        ));
                                  },
                                  child: Text(
                                    'Forgot Your Password ?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.white
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            LoginButton(
                              formKey: _formKey,
                              email: _email,
                              password: _password,
                              mail: _emailValue,
                              pass: _passValue,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            sellButon,
                            SizedBox(
                              height: 25.0,
                            ),

                            SizedBox(
                              height: 25.0,
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Divider(
                                      height: 20,
                                      thickness: 1.5,
                                      // color: Colors.white,
                                    )),
                              ),
                              Text(
                                "OR",
                                style: TextStyle(
                                  fontSize: 20,
                                    // color: Colors.white
                                    ),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black12,
                                      height: 20,
                                      thickness: 1.5,
                                    )),
                              ),
                            ]),
                            SizedBox(
                              height: 25.0,
                            ),
                            signUpButon
                          ],
                        ),
                      ),
                    )),
              ),
            );
          }),
        ));
  }

  _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched = await launch(
        url,
        forceSafariVC: false,
      );
      if (!launched) {
        await launch(
          fallbackUrl,
          forceSafariVC: false,
        );
      }
    } catch (e) {
      await launch(
        fallbackUrl,
        forceSafariVC: false,
      );
    }
  }
}

class LoginButton extends StatefulWidget {
  LoginButton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController email,
    @required TextEditingController password,
    @required this.pass,
    @required this.mail,
  })  : _formKey = formKey,
        _email = email,
        _password = password,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _email;
  final TextEditingController _password;
  final String pass;
  final String mail;
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  // ApiResponse _apiResponse = new ApiResponse();
  // AuthApi api;
  // void _loginSUbmit(CustomerRegistration customer) async {
  //   _apiResponse = await api.authenticateUser(customer);
  // }

  // void _handleSubmitted() async {
  //   final FormState form = widget._formKey.currentState;
  //   CustomerRegistration customer = CustomerRegistration();
  //   customer.customerEmail = widget.mail;
  //   customer.password = widget.pass;
  //   if (!form.validate()) {
  //     print('Please fix the errors in red before submitting.');
  //   } else {
  //     form.save();
  //     _apiResponse = await api.authenticateUser(customer);
  //     setState(() {
  //       if ((_apiResponse.ApiError as ApiError) == null) {
  //         _saveAndRedirectToHome();
  //       } else {
  //         print((_apiResponse.ApiError as ApiError).error == null
  //             ? '*****************'
  //             : (_apiResponse.ApiError as ApiError).error);
  //       }
  //     });
  //   }
  // }

  void _saveAndRedirectToHome(String token) async {
    print("Saving token and redirecting" + token);
    String email = widget._email.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('email', email);
    // await _flutterSecureStorage.write(key: "token", value: token);
    // await _flutterSecureStorage.write(key: "email", value: email);
    BlocProvider.of<CartBloc>(context).add(FetchCartDetailsEvent('8955'));
    BlocProvider.of<UserBloc>(context)
        .add(FetchCustomerInformationEvent(email));
    print("Login email " + email + "tokem >> " + token);
    // await _flutterSecureStorage.write(key: "customerId", value: customerId);
    // print("Customer ID " +customerId);

    Navigator.of(widget._formKey.currentContext).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(listener: (context, state) {
      if (state is CustomerLoginSuccessState) {
        print(
            'email>>>>>>${widget._email.text} & password >>>>>>>>${widget._password.text}');
        String token = BlocProvider.of<UserBloc>(context).token;

        // String customerId = BlocProvider.of<UserBloc>(context).customer.customerId.toString();

        // String error = (jsonDecode(response.body)['error']);

        if (token != null) {
          print('token>>>>>>>>>>>');
          print(token);
          _saveAndRedirectToHome(token);
        } else {
          return AlertDialog(
            title: const Text('Login failed'),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("try again"),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Theme.of(context).primaryColor,
                child: const Text('Close'),
              ),
            ],
          );
        }
      } else if (state is CustomerLoginFailedState) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Invalid/Username Password"),
        ));
      }
    }, child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is CustomerLoginLoadingState ||
          state is CheckEmailStatusLoadingState ||
          state is CheckMobileNumberStatusLoadingState) {
        return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.deepOrangeAccent,
          child: MaterialButton(
            onPressed: () {},
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: SpinKitChasingDots(
              size: 19,
              color: Colors.white,
            ),
          ),
        );
      }
      return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.deepOrangeAccent,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            //  setState(() {
            print('user state>>>>>>>>>>>' + state.toString());
            if (widget._formKey.currentState.validate()) {
              CustomerRegistration customer = CustomerRegistration();
              customer.customerEmail = widget._email.text;
              customer.password = widget._password.text;
              if (state is UserInitial || state is CustomerLoginFailedState) {
                BlocProvider.of<UserBloc>(context)
                    .add(CustomerLoginEvent(customer));
              }
            }
          },
          child: Text("Login".toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    }));
  }
}
