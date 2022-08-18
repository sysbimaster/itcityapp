import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class SellOnItcityPage extends StatefulWidget {
  @override
  _SellOnItcityPageState createState() => _SellOnItcityPageState();
}

class _SellOnItcityPageState extends State<SellOnItcityPage> {
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'name',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
    final companynameField = TextFormField(
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Company Name',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your company name';
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
    final contactNumberField = TextFormField(
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: 'Contact Number',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value!.isEmpty) return 'Please enter your contact number';

        return null;
      },
    );

    final submitButton = Material(
      elevation: 5.0,
      color: Colors.deepOrangeAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("SUBMIT",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        bottomNavigationBar: submitButton,
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
                child: IntrinsicHeight(
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
                                'Sell on IT City',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 33,
                                ),
                              )),
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Create an Account',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.topLeft,
                            child: Text("Name"),
                          ),
                          feilds(""),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.topLeft,
                            child: Text("Company Name"),
                          ),
                          feilds(""),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.topLeft,
                            child: Text("Email"),
                          ),
                          feilds(""),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.topLeft,
                            child: Text("Contact Number"),
                          ),
                          feilds(""),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.topLeft,
                            child: Text("Products for sell"),
                          ),
                          feilds("Mobiles, tablets etc"),
                          SizedBox(
                            height: 35,
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

  Widget feilds(String label) {
    return TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
