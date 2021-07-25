import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/resources/values.dart';

class ProductRatingNew extends StatefulWidget {
  const ProductRatingNew({Key key}) : super(key: key);

  @override
  _ProductRatingNewState createState() => _ProductRatingNewState();
}

class _ProductRatingNewState extends State<ProductRatingNew> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
  builder: (context, state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.WHITE,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            //margin: EdgeInsets.all(8),
              padding: EdgeInsets.fromLTRB(15, 5, 20, 5),
              width: MediaQuery.of(context).size.width,
              child: Text('Product Review',
                style: TextStyle(color: AppColors.LOGO_BLACK,fontSize: 20,fontWeight: FontWeight.w500),
              )),
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 20, 5),
            width: MediaQuery.of(context).size.width,
            child: RatingBar.builder(
              itemSize: 20,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.orange,
                size: 10,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                // _ratingValue = rating;
              },
            ),
          ),
        ],

      ),

    );
  },
);
  }
}
