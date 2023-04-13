import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/review/get_review_bloc.dart';
import 'package:itcity_online_store/blocs/review/random_review_bloc.dart';
import 'package:itcity_online_store/resources/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRatingNew extends StatefulWidget {
  String? productId;
  ProductRatingNew({Key? key, this.productId}) : super(key: key);

  @override
  _ProductRatingNewState createState() => _ProductRatingNewState();
}

class _ProductRatingNewState extends State<ProductRatingNew> {
  TextEditingController textEditingController = new TextEditingController();
  late SharedPreferences prefs;
  bool isReviewOpen = false;
  int? rating;
  String? authorname;
  getCountry() async {
    this.prefs = await SharedPreferences.getInstance();
    //   this.currency = prefs.getString('currency');
    // this.country = prefs.getString('country');
    if (prefs.containsKey("email")) {
      this.authorname = prefs.getString('email');

      BlocProvider.of<UserBloc>(context)
          .add(FetchCustomerInformationEvent(prefs.getString('email')));
    }
  }

  @override
  void initState() {
    getCountry();
    BlocProvider.of<RandomReviewBloc>(context).add(FetchReview());
    // TODO: implement initState
    super.initState();
  }

  togglePostReviewvisibility() {
    setState(() {
      isReviewOpen = !isReviewOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomReviewBloc, RandomReviewState>(
      builder: (context, state) {
        if (state is PostReviewLoading) {
          return Center(
              child: SpinKitRipple(
            color: Theme.of(context).primaryColor,
            size: 50,
          ));
        }
        if (state is PostReviewLoaded) {
          BlocProvider.of<GetReviewBloc>(context)
              .add(GetReview(productId: widget.productId));

          return Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.WHITE,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Thank you for your review',
                        style: TextStyle(
                          // fontFamily: 'YanoneKaffeesatz',
                          fontSize: 16,
                          color: AppColors.LOGO_BLACK,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          color: AppColors.WHITE,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  togglePostReviewvisibility();
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                          //margin: EdgeInsets.all(8),

                          child: Text(
                        'Rate this Product',
                        style: TextStyle(
                            color: AppColors.LOGO_BLACK,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                      isReviewOpen
                          ? IconButton(
                              onPressed: togglePostReviewvisibility,
                              icon: Icon(Icons.keyboard_arrow_up))
                          : IconButton(
                              onPressed: togglePostReviewvisibility,
                              icon: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 20, 5),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: RatingBar.builder(
                    itemSize: 35,
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.orange,
                      //  size: 10,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        isReviewOpen = true;
                        this.rating = rating.toInt();
                      });

                      // _ratingValue = rating;
                    },
                  ),
                ),
              ),
              isReviewOpen
                  ? Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 20, 5),
                      child: Column(children: [
                        TextField(
                          controller: textEditingController,
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.LOGO_DARK_ORANGE,
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.LOGO_ORANGE, width: 1.0),
                            ),
                            hintText: 'Please write a review',
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 2, //Normal textInputField will be displayed
                          maxLines: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(5.0),
                            color: AppColors.LOGO_ORANGE,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () {
                                if (prefs.containsKey('email')) {
                                  BlocProvider.of<RandomReviewBloc>(context)
                                      .add(PostReview(
                                          authorName: this.authorname,
                                          productId: widget.productId,
                                          rating: this.rating,
                                          text: textEditingController
                                              .value.text));
                                }else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Login to post a review ')));
                                }

                                // if(goHomePressed){
                                //
                                // }else {
                                //   _requestReview;
                                // }
                              },
                              child: Text(" POST REVIEW".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ),
                        ),
                      ]),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
