import 'package:flutter/material.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:itcity_online_store/screens/screens.dart';

class ProductRatingReview extends StatefulWidget {
  final String productId;
  ProductRatingReview({this.productId});
  @override
  _ProductRatingReviewState createState() => _ProductRatingReviewState();
}

class _ProductRatingReviewState extends State<ProductRatingReview> {
  final _reviewController = TextEditingController();
  var _ratingValue;
  IconData _selectedIcon;
  double _userRating = 4;
  String reviewResponse;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
  builder: (context, state) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {

      return Column(
        children: [
          Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Rating & Reviews",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8, right: 8),
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ReviewList(
                              productId: widget.productId,
                            );
                          }));
                        },
                        color: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                        child: Text("See All".toUpperCase(),
                            style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '4.0',
                            style: TextStyle(fontSize: 30),
                          ),
                          RatingBarIndicator(
                            itemPadding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            rating: _userRating,
                            itemBuilder: (context, index) => Icon(
                              _selectedIcon ?? Icons.star,
                              color: Colors.orange,
                            ),
                            itemCount: 1,
                            itemSize: 33.0,
                            unratedColor: Colors.amber.withAlpha(50),
                          ),
                        ],
                      ),
                    )),
                Text(
                  'Based on 3 review',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Add a review",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        itemSize: 15,
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
                          _ratingValue = rating;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          controller: _reviewController,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Your comments here....",
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8, right: 8),
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            print(BlocProvider.of<UserBloc>(context).state.toString());
                            if(UserState is CustomerLoginSuccessState || UserState is CustomerInformationLoadedState){
                              setState(() {
                                Review review = Review();
                                review.text = _reviewController.text;
                                review.productId = widget.productId;
                                review.rating = _ratingValue.toString();
                                review.authorName = 'testing';
                                review.reviewStatus = 1;

                                BlocProvider.of<ProductBloc>(context)
                                    .add(CreateUserReviewEvent(review));
                                _reviewController.clear();
                                reviewResponse =
                                    BlocProvider.of<ProductBloc>(context)
                                        .reviewStatus;
                                // print(
                                //     'response of review>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' +
                                //         reviewResponse.toString());

                                if (state is CreateUserReviewLoadingState) {
                                  print('review added======>' + review.text);
                                  return (Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              });
                            } else{
                              print("Login dialogue shood run");
                              showDialog<void>(
                                  context: context,
                                  builder:(BuildContext context) => LoginDialog(),
                              );

                            }

                          },
                          color: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          child: Text("Submit".toUpperCase(),
                              style: TextStyle(fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  },
);
  }
}
class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(left: 0.0, right: 0.0),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 18.0,
                ),
                margin: EdgeInsets.only(top: 13.0, right: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.green,
                      size: 100,
                    ),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text(
                              "Please  Login to Add a Review",
                              style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                        ) //
                    ),
                    SizedBox(height: 24.0),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)),
                        ),
                        child: Text(
                          "Login / Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}