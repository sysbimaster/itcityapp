import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:itcity_online_store/resources/values.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

//FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class LoginPageNew extends StatefulWidget {


  @override
  _LoginPageNewState createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPageNew> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _passValue = '';
  String? _emailValue = '';

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    final emailField = TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
     cursorColor: Colors.white,
     style: TextStyle(color: Colors.white),
      onSaved: (String? value) {
        _emailValue = value;
      },
      decoration: InputDecoration(
        // focusColor: AppColors.WHITE,
        //   fillColor: Colors.white,
        labelStyle: TextStyle(color: AppColors.WHITE),
          //filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Email",
         prefixIcon: Icon(Icons.person, color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white,
        )),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

        // border:
          // OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
        ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
    final passwordField = TextFormField(
      obscureText: _obscureText,
      controller: _password,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      onSaved: (String? value) {
        _passValue = value;
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white,
            )),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
          // fillColor: Colors.white,
          // filled: true,
        labelStyle: TextStyle(color: AppColors.WHITE),
          suffixIcon: TextButton(
              onPressed: _toggle,
              child: new Text(
                _obscureText ? "Show" : "Hide",
                style: TextStyle(
                  color: Colors.white,
                ),

              )),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          // border:
          // OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
          ),
      validator: (value) {
        if (value!.isEmpty) {
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
        backgroundColor: AppColors.LOGO_ORANGE,
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
            // flexibleSpace: Container(
            //   decoration: kAppBarContainerDecoration,
            // )
        ),
        body: BlocListener<UserBloc, UserState>(
  listener: (context, state) {
    if(state is CustomerLoginLoadingState){
      Loader.show(context,
          isAppbarOverlay: true,
          isBottomBarOverlay: false,
          progressIndicator: CircularProgressIndicator(),
          themeData:
          Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
          overlayColor: Colors.black26);
    }else if(state is CustomerLoginErrorState){
      Loader.hide();
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

    }
    else {
      Loader.hide();
    }
    // TODO: implement listener
  },
  child: Container(
          color: AppColors.LOGO_ORANGE,
         // decoration: kContainerDecoration,
          child: new LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstrains) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: viewportConstrains.maxHeight),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              child:Image.asset(
                                'assets/images/logo_home.png',
                                width: 250,
                                height: 100,
                              )),
                          SizedBox(
                            height: 25,
                          ),
                          emailField,
                          SizedBox(height: 10.0),
                          passwordField,
                          SizedBox(
                            height: 20.0,
                          ),

                          LoginButton(
                            formKey: _formKey,
                            email: _email,
                            password: _password,
                            mail: _emailValue,
                            pass: _passValue,
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
                                  'Forgot Password ?',
                                  style: TextStyle(

                                     color: Colors.white
                                  ),
                                )),
                          ),

                          // SizedBox(
                          //   height: 15.0,
                          // ),
                         // // sellButon,
                         //  SizedBox(
                         //    height: 25.0,
                         //  ),

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
                                     color: Colors.white,
                                  )),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                fontSize: 20,
                                 color: Colors.white
                              ),
                            ),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.white,
                                    height: 20,
                                    thickness: 1.5,
                                  )),
                            ),
                          ]),
                          SizedBox(
                            height: 35.0,
                          ),

                          GestureDetector(
                            onTap: (){
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),(Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Don't have account? Sign Up",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                         // signUpButon
                        ],
                      ),
                    )),
              ),
            );
          }),
        ),
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
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController email,
    required TextEditingController password,
    required this.pass,
    required this.mail,
  })  : _formKey = formKey,
        _email = email,
        _password = password,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _email;
  final TextEditingController _password;
  final String? pass;
  final String? mail;
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {


  void _saveAndRedirectToHome(String token) async {
    print("Saving token and redirecting" + token);
    String email = widget._email.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('email', email);
    // await _flutterSecureStorage.write(key: "token", value: token);
    // await _flutterSecureStorage.write(key: "email", value: email);
    //BlocProvider.of<CartBloc>(context).add(FetchCartDetailsEvent('8955'));
    BlocProvider.of<UserBloc>(context)
        .add(FetchCustomerInformationEvent(email));
    print("Login email " + email + "tokem >> " + token);
    // await _flutterSecureStorage.write(key: "customerId", value: customerId);
    // print("Customer ID " +customerId);

    Navigator.of(widget._formKey.currentContext!).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(listener: (context, state) {
      if (state is CustomerLoginSuccessState) {
        print(
            'email>>>>>>${widget._email.text} & password >>>>>>>>${widget._password.text}');
        String? token = BlocProvider.of<UserBloc>(context).token;

        // String customerId = BlocProvider.of<UserBloc>(context).customer.customerId.toString();

        // String error = (jsonDecode(response.body)['error']);

        if (token != null) {
          print('token>>>>>>>>>>>');
          print(token);
          _saveAndRedirectToHome(token);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
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
                  new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );

        }
      } else if (state is CustomerLoginFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.WHITE,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          //padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          onPressed: () {

            //  setState(() {
            //print('user state>>>>>>>>>>>' + state.toString());
            if (widget._formKey.currentState!.validate()) {
              CustomerRegistration customer = CustomerRegistration();
              customer.customerEmail = widget._email.text;
              customer.password = widget._password.text;

                BlocProvider.of<UserBloc>(context)
                    .add(CustomerLoginEvent(customer));
                print("login clicked");

            }
          },
          child: Text("SIGN IN".toUpperCase(),
              textAlign: TextAlign.center,
              style:
              TextStyle(color: AppColors.LOGO_ORANGE, fontSize: 20)),
        ),
      );
    }));
  }
}
