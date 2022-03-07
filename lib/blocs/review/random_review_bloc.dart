import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/get_review_model.dart';
import 'package:itcity_online_store/api/models/post_review_model.dart';
import 'package:itcity_online_store/api/services/product_api.dart';
import 'package:meta/meta.dart';

part 'random_review_event.dart';
part 'random_review_state.dart';

class RandomReviewBloc extends Bloc<RandomReviewEvent, RandomReviewState> {
  final ProductApi productApi;
  PostReviewModel postReviewModel;
  double ratingReview;
  GetReviewModel getReviewModel;
  RandomReviewBloc({this.productApi})
      : assert(productApi != null),
        super(null);

  @override
  Stream<RandomReviewState> mapEventToState(
    RandomReviewEvent event,
  ) async* {
    if (event is FetchReview) {
      yield* _mapFetchReviewToState(state, event);
    }
    if(event is PostReview){
      yield* _mapPostReviewToState(state, event,event.productId,event.authorName,event.text,event.rating);
    }

    // TODO: implement mapEventToState
  }

  Stream<RandomReviewState> _mapFetchReviewToState(
      RandomReviewState state, RandomReviewEvent event) async* {
    yield RandomReviewLoading();
    try {
      final double review = await productApi.getRandomReview();
      ratingReview = review;
      yield RandomReviewLoaded();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield RandomReviewError();
    }
  }

  Stream<RandomReviewState> _mapPostReviewToState(
      RandomReviewState state, PostReview event, String productId, String authorName, String text, int rating) async* {
    yield PostReviewLoading();
    try {
     postReviewModel = await productApi.PostRandomReview(authorName, productId, text, rating);

     yield PostReviewLoaded();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield PostReviewError();
    }
  }


}
