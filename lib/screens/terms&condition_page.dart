import 'package:flutter/material.dart';
import 'package:itcity_online_store/constants.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
          title: Text(
            'Terms & Condition',
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
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'This App belongs to www.itcityonlinestore.com. (here in after referred to as "itcityonlinestore/we/our/us"). As a user of this app (hereinafter referred to as "you/your"), you acknowledge that any use of this app including any transactions you make ("use/using") is subject to our terms and conditions below.',
                            textAlign: TextAlign.justify,
                            style: (TextStyle(
                              // fontFamily: 'YanoneKaffeesatz',
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            )),
                          )),
                      textFeild('1.GENERAL',
                          '1.1 The Seller is itcityonlinestore, Habeeb al Munawar street, Maghatheer complex, Mezzanine floor, Farwaniah, Kuwait.\n\n 1.2 itcityonlinestore  is a division of IT City International Kuwait Hence these terms and conditions are for and on behalf of IT City International , Kuwait We reserve our right to change these terms and conditions at any point of time, but such changes will be posted and it will take effect as and when it is posted . It is your responsibility to read the terms and conditions on each occasion you use and your continued use of the App shall signify your acceptance to be bound by the latest terms and conditions. All orders and purchases made on the itcityonlinestore will be governed by the terms and conditions applicable to that product.Certain website services will require registration and subsequent access to those services will be subject to an approved login name and password. Information that you provide on this App must be accurate and complete. All Passwords Details are accepted and may be withdrawn at our sole discretion and are exclusive to you and non-transferable and must be treated as strictly confidential at all times. In the event that you have any concerns regarding your Password Details or become aware of any misuse, kindly alert us immediately'),
                      textFeild('2.ORDER PROCESS',
                          '2.1.All orders you place on our app will be subject to acceptance in accordance with these terms and conditions. We will contact you by email or telephone if there is a query or discrepancy with reference to your order.\n\n2.2. The \'confirmation\' stage displays the order related information. Following this, we will send an order acknowledgement email detailing the products you have ordered. Please note that this email is not an order confirmation or order acceptance from itcityonlinestore acceptance of your order followed by delivery concludes that particular transaction unless we have notified you that we do not accept your order or you have cancelled the same.\n\n2.3.We do not file details of your order on the app and therefore request you to maintain a copy of the same for reference. In case you wish to view the details of previous orders please Contact Us.'),
                      textFeild('3.DELIVERY',
                          '3.1.All goods must be signed for by an adult aged 18 years or over at the time of delivery. The signature of the person accepting delivery at the delivery address will be proof that delivery has been received by you or the person to whom the order is addressed.\n\n3.2.Delivery charges (if any) and estimated time scale are specified in the Shipping Info section and also when you place an order. We make every effort to deliver goods within the estimated time period; however delays are occasionally inevitable due to unforeseen factors. itcityonlinestore shall be under no liability for any delay or failure to deliver the products within estimated time scales.\n\n3.3 In case if the product is tampered or not in its original/genuine condition, the product should not be accepted by the customer. Once the product/ order is accepted by the customer, any claims are subject itcityonlinestore Shipping & Returns Policy\n\n3.4 Risk of loss and damage of products passes to you on the date and time when the products are delivered or on the date of first attempted delivery by us.\n\n3.5 Cash on Delivery orders are applicable only in Kuwait.'),
                      textFeild('4.PAYMENT',
                          '4.1 We accept payment through credit/debit card. Payment is accepted only after availability of stock is verified. In the event that we are unable to supply the goods, we will inform you at the earliest and a full refund will be given in case you have already paid for the goods.\n\n4.2.to ensure that your credit or debit card not being used without your consent, we will validate name, address and other personal information supplied by you during the order process against appropriate third party databases. By accepting these terms and conditions you consent to such checks being made. In performing these checks, personal information provided by you may be disclosed to a registered Credit Reference Agency which may keep a record of that information. You can rest assured that this is done only to confirm your identity, that a credit check is not performed and that your credit rating will be unaffected. All information provided by you will be treated securely and strictly.\n\n4.3. The price you pay is the price displayed on this app at the time we receive your order apart from the following two exceptions: a) While we try and ensure that all prices on our app are accurate, errors may occur. If we discover an error in the price of goods you have ordered we will inform you as soon as possible and give you the option of reconfirming your order at the correct price or cancelling it. If we are unable to contact you we will treat the order as cancelled. If you cancel and you have already paid for the goods, you will receive a full refund.\n\n4.4.For information about secure online ordering see our Privacy Policy.\n\n4.5.Title to any products you order on this app shall pass to you on delivery of the products provided that we have processed and received payment in full for the products.\n\n4.6. All prices shown exclude delivery charges, unless expressly stated otherwise.'),
                      textFeild('5.CANCELLATIONS, SUBSTITUTIONS & SHIPPING',
                          '5.1 itcityonlinestore repair [if possible] or replacement if not possible to repair, in respect of any manufacturing defect in the product within the warranty period as stipulated in warranty conditions of that specific product. \n\n5.2 All sizes and measurements are approximate but we strive to make sure that they are as accurate as possible.\n\n5.3 The acceptance of the contract with itcityonlinestore has occurred only when the product is shipped to you.'),
                      textFeild('6.INTELLECTUAL PROPERTY',
                          '6.1 You acknowledge and agree that trademark itcityonlinestore copy right of the product\'s design and all other intellectual property rights shall vested in us.'),
                      textFeild('7. LIABILITY AND INDEMNITY',
                          '7.1 itcityonlinestore will use certain chosen process to verify the accuracy of any information on the site but makes no representation or warranty of any kind express or implied statutory or otherwise regarding the contents or availability of the site or that it will be timely or error-free, that defects will be corrected, or that the site or the server that makes it available are free of viruses or bugs or represents the full functionality, accuracy, reliability of the app. itcityonlinestore will not be responsible or liable to you for any loss of content or material uploaded or transmitted through the app and itcityonlinestore accepts no liability of any kind for any loss or damage from action taken or taken in reliance on material or information contained on the site. \n\n7.2 itcityonlinestore will not be liable, in contract, tort (including, without limitation, negligence), pre-contract or other representations (other than fraudulent on negligent misrepresentations) or otherwise out of or in connection with the terms and conditions for any: \n1.economic losses (including without limitation loss of revenues, data, profits, contracts, business or anticipated savings); or\n2.loss of goodwill or reputation; or \n3.special or indirect losses. \n4.suffered or incurred by that party arising out of or in connection with the provisions of any matter under these terms and conditions.\n\n7.3 itcityonlinestore aggregate liability (whether in contract, tort or otherwise) for loss or damage shall in any event be limited to a sum equal to the amount paid or payable by you for the product(s) in respect of one incident or series of incidents attributable to the same clause. \n\n7.4 We take all precautions to keep the details of your order and payment secure, but, we cannot be held liable for any losses caused as a result of unauthorized access to information provided by you.'),
                      textFeild(
                          '8. SPECIAL PROMOTIONS / SCHEMES / GIFTS / OFFERS AND LIMITED OFFERS',
                          'Any special promotion, campaign / schemes and gift products offered in this app will have to adhere to the following terms & conditions:\n\n8.1 Any gifts / promotional schemes offered in this app are subject to the availability of the stocks.\n\n8.2 Purchase under these schemes will have to be in \'one single purchase\' / \'order number\' and cannot be claimed otherwise.\n\n8.3 In case of any and all disputes arising out of this, the decision of the management of Teqnixonline.com will be final and binding.\n\n8.4 No refunds or cash reimbursement will be made against the promotions / gifts and offer.\n\n8.5 Prices are subject to change without prior notice.\n\n8.6 Discount coupons are not applicable for the products already on sale.'),
                      textFeild('9. MISCELLANEOUS PROVISIONS',
                          '9.1 The contract between us shall be governed by the laws of Kuwait and any dispute between us will be resolved exclusively in the Kuwaiti law.\n\n9.2 itcityonlinestore shall be under no liability for any delay or failure to deliver products or otherwise perform any obligation as specified in these terms and conditions if the same is wholly or partly caused whether directly or indirectly by circumstances beyond its reasonable control.\n\n9.3 You may not assign or sub-contract any of your rights or obligations under these terms and conditions or any related order for products to any third party unless agreed upon in writing by itcityonlinestore.\n\n9.4 itcityonlinestore reserves the right to transfer, assign, novate or sub-contract the benefit of the whole or part of any of its rights or obligations under these terms and conditions or any related contract to any third party.\n\n9.5 If any portion of these terms and conditions is held by any competent authority to be invalid or unenforceable in whole or in part, the validity or enforceability of the other sections of these terms and conditions shall not be affected.\n\n9.6 No delay or failure by itcityonlinestore to exercise any powers, rights or remedies under these terms and conditions will operate as a waiver of them nor will any single or partial exercise of any such powers, rights or remedies preclude any other or further exercise of them. Any waiver to be effective must be in writing and signed by an authorized representative of itcityonlinestore.\n\n9.7 These terms and conditions including the documents or other sources referred to in these terms and conditions supersede all prior representations understandings and agreements between you and itcityonlinestore relating to the use of this app (including the order of products) and sets forth the entire agreement and understanding between you and itcityonlinestore for your use of this app.'),
                      textFeild('10.SHIPPING & DELIVERY POLICY:',
                          '10.1 Although estimated delivery time is mentioned on the app Delivering of the shipment is subject to Courier Company / post office norms. itcityonlinestore is not liable for any delay in delivery by the courier company / postal authorities. Delivery of all orders will be to registered shipping address of the buyer at all times (Unless specified at the time of Order).'),
                      textFeild('11.LIABILITY AND INDEMNITY',
                          'The information contained in this app is for general information purposes only. we endeavour to keep the information up to date and correct, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability or availability with respect to the app or the information, products, services, or related graphics contained on the app for any purpose. Any reliance you place on such information is therefore strictly at your own risk. In no event will we be liable for any loss or damage including without limitation, indirect or consequential loss or damage, or any loss or damage whatsoever arising from loss of data or profits arise out of, or in connection with, the use of this app. Through this app you are able to link to other websites which are not under the control of itcityonlinestore We have no control over the nature, content and availability of those sites. The inclusion of any links does not necessarily imply a recommendation or endorse the views expressed within them. Every effort is made to keep the app up and running smoothly. However, itcityonlinestore takes no responsibility for, and will not be liable for, the app being temporarily unavailable due to technical issues beyond our control. If you have any questions regarding the itcityonlinestore app, please see contact support@itcityonlinestore.com'),
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
