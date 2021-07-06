import 'package:flutter/material.dart';

class Quantity extends StatefulWidget {
  final int stock;
  int quantity;
  Function(int) onQuantityChange;
  Quantity({this.stock, this.onQuantityChange,this.quantity});
  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {

  @override
  Widget build(BuildContext context) {
    int productStock = (widget.stock);
    return Row(
      children: <Widget>[
        widget.quantity!= 0
            ? Container(
                width: 35,
                height: 35,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[100],
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Card(
                  child: Center(
                    child: IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 12,
                        onPressed: () {
                          widget.quantity--;
                           widget.onQuantityChange(widget.quantity);
                                        print("kkkkk"+widget.quantity.toString());
                          setState(() => widget.quantity);
                         
                        }),
                  ),
                ),
              )
            : Container(
                width: 35,
                height: 35,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[100],
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Card(
                  child: Center(
                    child: IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 12,
                        onPressed: () {}),
                  ),
                ),
              ),
        Text(widget.quantity.toString()),
        Container(
          width: 35,
          height: 35,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[100],
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Card(
            child: Center(
              child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 12,
                  onPressed: () {
                    setState(() {
                      if (widget.quantity < productStock) {
                        widget.quantity++;
                        widget.onQuantityChange(widget.quantity);
                      }
                    });
                  }),
            ),
          ),
        )
      ],
    );
  }
}
