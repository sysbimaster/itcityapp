import 'package:equatable/equatable.dart';

abstract class HomeEvent  {}
  

class FetchHomeImages extends HomeEvent {}

class FetchBrandDetails extends HomeEvent {}

class FetchTodaysDealsByDate extends HomeEvent {}

class FetchPopularProduct extends HomeEvent {}

class FetchFeaturedProduct extends HomeEvent {}

class FetchDealsProductByProductId extends HomeEvent {
  final String productid;
  FetchDealsProductByProductId(this.productid);
}