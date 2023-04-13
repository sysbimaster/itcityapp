
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/get_review_model.dart';
import 'package:itcity_online_store/api/models/post_review_model.dart';
import 'package:itcity_online_store/api/services/product_api.dart';
import 'package:meta/meta.dart';

part 'random_review_event.dart';
part 'random_review_state.dart';

class RandomReviewBloc extends Bloc<RandomReviewEvent, RandomReviewState> {
  final ProductApi productApi;
  PostReviewModel? postReviewModel;
  double? ratingReview;
  GetReviewModel? getReviewModel;
  RandomReviewBloc({required this.productApi})
      :super(RandomReviewInitial()){
    on<FetchReview>((event, emit) => _mapFetchReviewToState(event,emit));
    on<PostReview>((event, emit) => _mapPostReviewToState(event,emit,event.productId,event.authorName,event.text,event.rating));
  }



 void _mapFetchReviewToState(
       RandomReviewEvent event,Emitter<RandomReviewState> emit) async {
    emit( RandomReviewLoading());
    try {
      final double review = await productApi.getRandomReview();
      ratingReview = review;
      emit(RandomReviewLoaded());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      emit(RandomReviewError());
    }
  }

void _mapPostReviewToState(
       PostReview event,Emitter<RandomReviewState> emit, String? productId, String? authorName, String? text, int? rating) async {
  emit( PostReviewLoading());
    try {
     postReviewModel = await productApi.PostRandomReview(authorName, productId, text, rating);

     emit( PostReviewLoaded());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      emit(PostReviewError());
    }
  }


}
