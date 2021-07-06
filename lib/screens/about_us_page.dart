import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class AboutUsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
          title: Text(
            'About Us',
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
                          'Itcityonlinestore.com is a division of IT City International Kuwait ,which was a Technology leader last 12 years in Kuwait, IT City International has started a Computer retail outlet in farwaniya ,Kuwait 2004,and showrooms expanted in different areas in Kuwait ., after that they have started a wholesale division and importing computers and laptops ,storage devices, components and accessories and many more consumer products, on 2015 on wards move to the online business and started with social media promotions and online eCommerce platform in the name of itcityonlinestore.com.in Kuwait region, featuring Huge range of products across categories such as consumer electronics, IT products, mobile communication devices & accessories, Health and beauty , sports and fitness, jewellery , perfumes and many more etc…..! itcityonlinestore.com offers a convenient and safe online shopping experience with express delivery and online payment option to such as pay cash on delivery and knet on delivery , master card, visa, American express etc…and free returns.',
                          textAlign: TextAlign.justify,
                          style: (TextStyle(
                            // letterSpacing: 1,
                            // fontFamily: 'YanoneKaffeesatz',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      )
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
