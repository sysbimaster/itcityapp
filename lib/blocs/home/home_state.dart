
import 'package:itcity_online_store/api/models/models.dart';
import 'package:meta/meta.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeImagesErrorState extends HomeState {}

class HomeImagesLoadingState extends HomeState {}

class HomeImagesLoadedState extends HomeState {}

class BrandDetailsLoadingState extends HomeState {}

class BrandDetailsLoadedState extends HomeState {}

class BrandDetailsErrorState extends HomeState {}

class TodaysDealsLoadingState extends HomeState {}

class TodaysDealsLoadedState extends HomeState {
  List<DealOfTheDay> deals;
  TodaysDealsLoadedState({@required this.deals}) : assert(deals != null);
}

class TodaysDealsErrorState extends HomeState {}

class PopularProductLoadingState extends HomeState {}

class PopularProductLoadedState extends HomeState {
  List<Product> popular;
  PopularProductLoadedState({@required this.popular}) : assert(popular != null);
}

class PopularProductErrorState extends HomeState {}

class FeaturedProductLoadingState extends HomeState {}

class FeaturedProductLoadedState extends HomeState {
  List<Product> featured;
  FeaturedProductLoadedState({@required this.featured})
      : assert(featured != null);
}

class FeaturedProductErrorState extends HomeState {}

class DealProductByProductIdLoadingState extends HomeState {}

class DealProductByProductIdLoadedState extends HomeState {
  final Product dealproduct;
  DealProductByProductIdLoadedState({@required this.dealproduct})
      : assert(dealproduct != null);
}
