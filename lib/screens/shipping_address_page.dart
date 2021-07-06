import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomButton(),
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
           title: Text(
            'Address',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
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
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text("Customer Name"),
                        ),
                        feilds(),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text("Email Address"),
                        ),
                        feilds(),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text("Mobile Number"),
                        ),
                        feilds(),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text("Address"),
                        ),
                        feilds(),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text("Place/Area"),
                        ),
                        feilds(),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text("Country"),
                        ),
                        feilds(),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          child: Text("Remarks"),
                        ),
                        feilds(),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })));
  }

  Widget feilds() {
    return TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class BottomButton extends StatefulWidget {
  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
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
  }
}
