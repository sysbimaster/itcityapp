import 'package:flutter/material.dart';
import 'package:itcity_online_store/screens/product_details_page.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/constants.dart';

class DealsCard extends StatefulWidget {
  DealOfTheDay deal;
  DealsCard({Key key, @required this.deal}) : super(key: key);
  @override
  _DealsCardState createState() => _DealsCardState();
}

class _DealsCardState extends State<DealsCard> {
  bool _isFavorited = true;
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double returnAmount;
    //  if (widget.deal.productPrice == null || widget.deal.productPrice == 0) return 0.0;
    String strAmount = widget.deal.productPrice.toString();

    if (strAmount.contains('.')) {
      returnAmount = double.parse(strAmount);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailPage(
            productId: widget.deal.productId,
          );
        }));
      },
      child: Container(
        constraints: BoxConstraints(
            minHeight: 300),
        // width: MediaQuery.of(context).size.width * .49,
        // height:MediaQuery.of(context).size.height *.20,

        child: Card(

      shadowColor: Colors.lightBlue[100],
          elevation: 3,
          child: Column(
            children: [

              Container(
                height: 170.0,
                width: 80.0,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(widget.deal == null
                        ? ''
                        : productImage + widget.deal.productImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              widget.deal == null
                                  ? ''
                                  : widget.deal.productName,
                              maxLines: 2,
                             // softWrap: false,
                              // overflow: TextOverflow.fade,

                              style: (TextStyle(
                                // fontFamily: 'YanoneKaffeesatz',

                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              )))),
                      SizedBox(
                        width: 5,
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'KWD ' +
                                          widget.deal.productPrice.toString(),
                                      style: (TextStyle(
                                      //  fontFamily: 'RobotoSlab',
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.deepOrangeAccent,
                                        fontWeight: FontWeight.w800,
                                      )))),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'KWD ' +
                                          widget.deal.productPriceOffer
                                              .toString(),
                                      style: (TextStyle(
                                       // fontFamily: 'RobotoSlab',
                                        fontSize: 18,
                                        color: Colors.deepOrangeAccent,
                                        fontWeight: FontWeight.w800,
                                      )))),
                              SizedBox(
                                width: 5,
                                height: 2,
                              ),
                            ],
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                size: 30,
                              ),
                              onPressed: null)
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
