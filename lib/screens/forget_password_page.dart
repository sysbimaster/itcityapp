import 'package:flutter/material.dart';
import 'package:itcity_online_store/screens/screens.dart';
import 'package:itcity_online_store/constants.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String? _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildEmail() {
    return TextFormField(
      // decoration: InputDecoration(labelText: 'Email'),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String? value) {
        _email = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstrains) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstrains.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'forgot Your Password?',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'To reset your password, please enter your IT City Online Store Registered EmailID. itcityonlinestore.com will send the password reset instructions to the email address for this account.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          _buildEmail(),
                          SizedBox(
                            height: 25.0,
                            //  height: 15.0,
                          ),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.deepOrangeAccent,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                _formKey.currentState!.save();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ResetPasswordPage();
                                }));


                              },
                              child: Text("Send",
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
