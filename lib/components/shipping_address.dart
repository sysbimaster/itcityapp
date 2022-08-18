import 'package:flutter/material.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.grey[100]!,
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Card(
          child: SizedBox(
            width: 500,
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
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.orange,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: Text("SUBMIT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
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
