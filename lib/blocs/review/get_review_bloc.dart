import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/get_review_model.dart';
import 'package:itcity_online_store/api/services/product_api.dart';
import 'package:meta/meta.dart';

part 'get_review_event.dart';
part 'get_review_state.dart';

class GetReviewBloc extends Bloc<GetReviewEvent, GetReviewState> {
  final ProductApi productApi;
  GetReviewBloc(this.productApi) : super(GetReviewInitial());
  GetReviewModel getReviewModel;

  @override
  Stream<GetReviewState> mapEventToState(
    GetReviewEvent event,
  ) async* {
    if(event is GetReview){
      yield* _mapGetReviewToState(state,event,event.productId);
    }
    // TODO: implement mapEventToState
  }
  Stream<GetReviewState> _mapGetReviewToState(
      GetReviewState state, GetReview event, String productId) async* {
    yield FetchReviewLoading();
    try {
      getReviewModel = await productApi.GetReview(productId);
      print(getReviewModel.data.length);
      yield FetchReviewLoaded();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield FetchReviewError();
    }
  }

}
