part of 'get_review_bloc.dart';

@immutable
abstract class GetReviewEvent {}
class GetReview extends GetReviewEvent{
  String? productId;
  GetReview({this.productId});

}