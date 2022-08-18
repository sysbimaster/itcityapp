import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';

class RatingAndReviewPage extends StatefulWidget {
  final String? productId;
  RatingAndReviewPage({this.productId});
  @override
  _RatingAndReviewPageState createState() => _RatingAndReviewPageState();
}

class _RatingAndReviewPageState extends State<RatingAndReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 18,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Reviews'),
            centerTitle: true,
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.orange, Colors.deepOrangeAccent])),
            )),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: new LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstrains) {
            return Stack(children: [
              ItemList(
                productId: widget.productId,
              )
            ]);
          }),
        ));
  }
}

class ItemList extends StatefulWidget {
  final String? productId;
  ItemList({this.productId});
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  IconData? _selectedIcon;
  @override
  void initState() {
    super.initState();
    print('init state');
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProductReviewByProductId(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      print('State of Product review=>' + state.toString());
      List<Review> review = BlocProvider.of<ProductBloc>(context).reviews;

      if (state is ProductReviewByProductIdLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Container(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '4.0',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                RatingBarIndicator(
                  rating: 4,
                  itemBuilder: (context, index) => Icon(
                    _selectedIcon ?? Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  unratedColor: Colors.amber.withAlpha(50),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Based on ${review.length} reviews",
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
          SliverToBoxAdapter(
            child: AddReviewSection(
              productId: widget.productId,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: ReviewSection(review: review[index]),
                );
              },
              childCount: review.length,
            ),
          ),
        ]),
      );
    });
  }
}

class ReviewSection extends StatefulWidget {
  final Review? review;
  ReviewSection({this.review});
  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  double _userRating = 3.5;

  bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 25,
                    //   backgroundColor: Colors.orange[700],
                    //   child: ClipOval(
                    //     child: SizedBox(
                    //       width: 64.0,
                    //       height: 64.0,
                    //       child: Image.asset(
                    //         'assets/images/boy1.jpg',
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 4,
                          ),
                          child: Text(
                            widget.review!.authorName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        RatingBarIndicator(
                          rating: _userRating,
                          itemBuilder: (context, index) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          unratedColor: Colors.amber.withAlpha(50),
                          direction:
                              _isVertical ? Axis.vertical : Axis.horizontal,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 4,
                  ),
                  child: Text('two weeks ago'),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(
                (widget.review == null) ? 'oops' : widget.review!.text!,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddReviewSection extends StatefulWidget {
  final String? productId;
  AddReviewSection({this.productId});
  @override
  _AddReviewSectionState createState() => _AddReviewSectionState();
}

class _AddReviewSectionState extends State<AddReviewSection> {
  final _reviewController = TextEditingController();
  var _ratingValue;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return Container(
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
              style: TextStyle(fontSize: 20),
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
                color: Colors.amber,
                size: 8,
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
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                  Review review = Review();
                  review.text = _reviewController.text;
                  review.productId = widget.productId;
                  review.rating = _ratingValue;
                  BlocProvider.of<ProductBloc>(context)
                      .add(CreateUserReviewEvent(review));
                },
                color: Colors.deepOrangeAccent,
                textColor: Colors.white,
                child: Text("Submit".toUpperCase(),
                    style: TextStyle(fontSize: 17)),
              ),
            ),
          ],
        ),
      );
    });
  }
}
