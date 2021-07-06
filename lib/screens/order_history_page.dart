import 'package:flutter/material.dart';

class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({Key key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
      ),
      body: Container(),
    );
  }
}