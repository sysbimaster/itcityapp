part of 'random_review_bloc.dart';

@immutable
abstract class RandomReviewState {}

class RandomReviewInitial extends RandomReviewState {}

class RandomReviewLoading extends RandomReviewState {}
class RandomReviewLoaded extends RandomReviewState {}
class RandomReviewError extends RandomReviewState {}

class PostReviewLoading extends RandomReviewState {}
class PostReviewLoaded extends RandomReviewState {}
class PostReviewError extends RandomReviewState {}

