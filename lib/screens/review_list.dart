import 'package:flutter/material.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:itcity_online_store/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReviewList extends StatefulWidget {
  final String? productId;
  ReviewList({this.productId});
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  bool _isVertical = false;
  List<Review> review = [];
  @override
  void initState() {
    super.initState();
    print('init state');
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProductReviewByProductId(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: Text('Review'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: kAppBarContainerDecoration,
        ),
      ),
      body: ListOfReview(review: review, isVertical: _isVertical),
    );
  }
}

class ListOfReview extends StatelessWidget {
  ListOfReview({
    Key? key,
    required this.review,
    required bool isVertical,
  })  : _isVertical = isVertical,
        super(key: key);

  List<Review> review;
  final bool _isVertical;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      print('State of Product review=>' + state.toString());
      review = BlocProvider.of<ProductBloc>(context).reviews;

      if (state is ProductReviewByProductIdLoadingState) {
        return Center(
            child: SpinKitCircle(
          color: Theme.of(context).primaryColor,
          size: 50,
        ));
      }
      if (review.length == 0) {
        return Container(
            color: Colors.white,
            child: Center(
              child: Text("No Reviews Found"),
            ));
      }
      return Container(
        // decoration: kContainerDecoration,
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.builder(
            itemCount: (review == null) ? 0 : review.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                             padding: EdgeInsets.all(8),
                          child: Text(
                            (review == null) ? '' : review[index].authorName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                             padding: EdgeInsets.all(8),
                          child: RatingBarIndicator(
                            rating: 3,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            unratedColor: Colors.amber.withAlpha(50),
                            direction:
                                _isVertical ? Axis.vertical : Axis.horizontal,
                          ),
                        ),
                                            Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      child: Text((review == null) ? '' : review[index].text!),
                    )

                      ],
                    ),
                  ],
                ),
              );
            }),
      );
    });
  }
}
