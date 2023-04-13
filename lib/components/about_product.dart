import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:itcity_online_store/api/models/models.dart';

class AboutProduct extends StatefulWidget {
  final Product product;
  AboutProduct(this.product);
  @override
  _AboutProductState createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  @override
  Widget build(BuildContext context) {

    String? description = widget.product.productDesc;
    return Card(
        shadowColor: Colors.grey,
        color: Colors.blueGrey[100],
        elevation: 3,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left:10,top:10),
              child: Text(
                "Details",
                textScaleFactor: 1,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top:20,bottom: 30,left: 5,right: 5),
                alignment: Alignment.centerLeft,
                child: Html(
                  style: {
                    "li":Style(
                      // fontWeight: FontWeight.bold,
                      fontSize: FontSize(15)
                    ),
                  },
                  data: widget.product == null
                      ? 'Loading'
                      : description!.toLowerCase(),
                )),
          ],
        ));
  }
}
