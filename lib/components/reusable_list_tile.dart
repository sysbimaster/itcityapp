import 'package:flutter/material.dart';

class ReusableListTile extends StatelessWidget {
  final Icon leadingIcon;
  final String title;
  final Function ontap;
  ReusableListTile({this.leadingIcon, this.title, this.ontap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: leadingIcon,
      title: Text(
        title,
        style: (TextStyle(
          fontFamily: 'RobotoSlab',
          fontSize: 15,
          // fontWeight: FontWeight.w800,
        )),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 17,
        color: Colors.grey[300],
      ),
    );
  }
}
