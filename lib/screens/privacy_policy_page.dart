import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
          title: Text(
            'Privacy Policy',
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
                            'This privacy policy sets out how uses and protects any information that you give when you use this app. is committed to ensuring that your privacy is protected. Should we ask you to provide certain information by which you can be identified when using this app, then you can be assured that it will only be used in accordance with this privacy statement. May change this policy from time to time by updating this page. You should check this page from time to time to ensure that you are happy with any changes.',
                            textAlign: TextAlign.justify,
                            style: (TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                          )),
                      textFeild('WHAT WE COLLECT?',
                          'We may collect the following information:\n1.Name\n2.Contact information including email address \n3.Demographic information such as postcode, preferences and interests \n4.Other information relevant to customer surveys and/or offers For the exhaustive list of cookies we collect see the List of cookies we collect section.'),
                      textFeild('WHAT WE DO WITH THE INFORMATION WE GATHER?',
                          'We require this information to understand your needs and provide you with a better service, and in particular for the following reasons:\n1.Internal record keeping.\n2.We may use the information to improve our products and services.\n3.We may periodically send promotional emails about new products, special offers or other information which we think you may find interesting using the email address which you have provided.\n4.From time to time, we may also use your information to contact you for market research purposes. We may contact you by email, phone, fax or mail. We may use the information to customise the app according to your interests'),
                      textFeild('SECURITY',
                          'We are committed to ensuring that your information is secure. In order to prevent unauthorized access or disclosure, we have put in place suitable physical, electronic and managerial procedures to safeguard and secure the information we collect online.'),
                      textFeild('LINKS TO OTHER WEBSITES',
                          'Our app may contain links to other websites of interest. we cannot be responsible for the protection and privacy of any information which you provide whilst visiting such sites and such sites are not governed by this privacy statement. You should exercise caution and look at the privacy statement applicable to the app in question.'),
                      textFeild('CONTROLLING YOUR PERSONAL INFORMATION',
                          'You may choose to restrict the collection or use of your personal information in the following ways:\n1.Whenever you are asked to fill in a form on the app, look for the box that you can click to indicate that you do not want the information to be used by anybody for direct marketing purposes.\n2.If you have previously agreed to us using your personal information for direct marketing purposes,you may change your mind at any time by writing to or emailing us at support@itcityonlinestore.com.\n3.We will not sell, distribute or lease your personal information to third parties unless we have your permission or are required by law to do so. We may use your personal information to send you promotional information about third parties which we think you may find interesting if you tell us that you wish this to happen.\n4.You may request details of personal information which we hold about you under the Data Protection Act 1998. A small fee will be payable. If you would like a copy of the information held on you please write to.\n5.If you believe that any information we are holding on you is incorrect or incomplete, please write to or email us as soon as possible, at the above address. We will promptly correct any information found to be incorrect.'),
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

  Widget textFeild(String heading, String content) {
    return Container(
      padding: EdgeInsets.all(19),
      margin: EdgeInsets.only(left: 19, right: 19),
      color: Colors.white,
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                heading,
                style: (TextStyle(
                  // fontFamily: 'YanoneKaffeesatz',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
              )),
          SizedBox(
            height: 5,
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                content,
                textAlign: TextAlign.justify,
                style: (TextStyle(
                  // fontFamily: 'YanoneKaffeesatz',
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                )),
              )),
        ],
      ),
    );
  }
}
