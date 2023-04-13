import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:itcity_online_store/api/models/get_review_model.dart';
import 'package:itcity_online_store/blocs/review/get_review_bloc.dart';
import 'package:itcity_online_store/resources/values.dart';

class ShowReviews extends StatefulWidget {
  String? productId;
  ShowReviews({Key? key, this.productId}) : super(key: key);

  @override
  _ShowReviewsState createState() => _ShowReviewsState();
}

class _ShowReviewsState extends State<ShowReviews> {
  bool isReview = false;
  GetReviewModel? getReviewModel;

  @override
  void initState() {
    BlocProvider.of<GetReviewBloc>(context)
        .add(GetReview(productId: widget.productId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReviewBloc, GetReviewState>(
      builder: (context, state) {
        if (state is FetchReviewLoading) {
          return Center(
              child: SpinKitRipple(
            color: Theme.of(context).primaryColor,
            size: 50,
          ));
        }
        if (state is FetchReviewLoaded) {
          this.getReviewModel =
              BlocProvider.of<GetReviewBloc>(context).getReviewModel;


          return Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.WHITE,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 10, 0),
                  child: Row(
                    children: [
                      Container(

                          //margin: EdgeInsets.all(8),

                          child: Text(
                        'Reviews',
                        style: TextStyle(
                            color: AppColors.LOGO_BLACK,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),


                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: getReviewModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.GREY,width: 1.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(getReviewModel!.data![index].authorName!.compareTo('null') !=0 ?getReviewModel!.data![index].authorName! : ''  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(getReviewModel!.data![index].rating!,style: TextStyle(
                                          fontFamily: 'Arial',
                                          // fontFamily: 'RobotoSlab',
                                          fontSize: 14,
                                          //decoration:
                                          //TextDecoration.lineThrough,
                                          color: AppColors.LOGO_BLACK,
                                          // fontWeight: FontWeight.bold,
                                        ),),
                                        Icon(Icons.star,color: AppColors.LOGO_ORANGE,size: 20,),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: Text(getReviewModel!.data![index].text!.compareTo('null') != 0 ? getReviewModel!.data![index].text!:''),
                            )

                          ],
                        ),
                      );
                    })
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
