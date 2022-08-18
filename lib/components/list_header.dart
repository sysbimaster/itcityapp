import 'package:flutter/material.dart';

class ListHeader extends StatefulWidget {
  final String? headerName;
  final Function? onTap;
  final Widget? leftWidget;
  ListHeader({this.headerName,this.onTap,this.leftWidget});
  @override
  _ListHeaderState createState() => _ListHeaderState();
}

class _ListHeaderState extends State<ListHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
              child: Text(widget.headerName!,
                  style: (TextStyle(

                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  )))),

        ],
      ),
    );
  }
}
 