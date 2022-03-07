import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class DeliveryInfoPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
          title: Text(
            'Delivery Information',
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                          padding: EdgeInsets.all(19),
                          margin: EdgeInsets.all(19),
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '1.Our delivery charge will be 1 kd for all over kuwait.\n2.Delivery time will be within 24 hours.\n3.For Shippment tracking kindly contact our customer care on : +965 90019287.\n4.If any delay\'s in delivery we will inform you via sms/ phone / email.',
                            textAlign: TextAlign.justify,
                            style: (TextStyle(
                              // fontFamily: 'YanoneKaffeesatz',
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
