import 'package:flutter/material.dart';
class BannerAdds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      // color: Colors.grey[200],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 390,
        itemCount: 6,
        padding: EdgeInsets.all(3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return CategoryDetail();
              // }));
            },
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                ),
                Container(
                  height: 180.0,
                  width: 360.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.white,
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/banner/banner$index.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
  );}}