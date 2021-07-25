import 'package:flutter/material.dart';
import 'package:itcity_online_store/screens/home_page_content.dart';
class ListHeader extends StatefulWidget {
  final String headerName;
  final Function onTap;
  final Widget leftWidget;
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
              child: Text(widget.headerName,
                  style: (TextStyle(
                    // fontFamily: 'YanoneKaffeesatz',
                  //  fontFamily: 'RobotoSlab',
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  )))),
                widget.leftWidget != null?Container(
                  child: TimerApp()
                ):Container()

          // Padding(
          //   padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          //   child: InkWell(
          //     onTap: widget.onTap,
          //     child: Text(("View All"),
          //         style: Theme.of(context)
          //             .textTheme
          //             .subtitle2
          //             .copyWith(color: Colors.blue)),
          //   ),
          // )
        ],
      ),
    );
  }
}
 