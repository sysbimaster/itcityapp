import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Username',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
    final emailField = TextFormField(
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Email',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
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
          labelText: 'Enter new Password',
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
        if (value!.isEmpty) return 'Please enter your password';
        if (value != _pass.text) return "Not match";
        return null;
      },
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
                Navigator.pop(context);
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
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Reset Password',
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
                          passwordField,
                          SizedBox(height: 25.0),
                          confirmPasswordField,
                          SizedBox(height: 25.0),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.deepOrangeAccent,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () {

                              },
                              child: Text("Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
