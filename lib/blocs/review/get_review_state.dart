part of 'get_review_bloc.dart';

@immutable
abstract class GetReviewState {}

class GetReviewInitial extends GetReviewState {}
class FetchReviewLoading extends GetReviewState {}
class FetchReviewLoaded extends GetReviewState {}
class FetchReviewError extends GetReviewState {}
