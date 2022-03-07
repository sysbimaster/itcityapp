import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class ReturnPolicyPage extends StatefulWidget {
  @override
  _ReturnPolicyPageState createState() => _ReturnPolicyPageState();
}

class _ReturnPolicyPageState extends State<ReturnPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
          title: Text(
            'Return Policy',
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
                          margin: EdgeInsets.all(19),
                          padding: EdgeInsets.all(19),
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: Text(
                            '1.Returns are acceptable within 24 hours from the date of purchase ,if it is physically damage with free of cost.\n2.Please save all packaging and accessories for any item that is returned. All original equipment, components, manuals, cables, documents and packaging must be returned with your item in order to process your return order.\n3.Part must be undamaged and completely serviceable.\n4.The customer is responsible for packaging and return shipping cost.\n5.If you don\'t like unopend product and you would like to return it within 2 day\'s, we will charge 2kd for pickup.\n6.Don\'t hesitate to contact us for any clarification about our online store : Our customer care :+965 90019287 (10am-10pm)',
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
