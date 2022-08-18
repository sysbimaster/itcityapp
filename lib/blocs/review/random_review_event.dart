part of 'random_review_bloc.dart';

@immutable
abstract class RandomReviewEvent {}
class FetchReview extends RandomReviewEvent{


}


class PostReview extends RandomReviewEvent{
  String? authorName;
  String? productId;
  String? text;
  int? rating;
  PostReview({this.productId,this.rating,this.authorName,this.text});

}


