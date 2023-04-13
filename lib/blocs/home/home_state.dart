
import 'package:itcity_online_store/api/models/models.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeImagesErrorState extends HomeState {}

class HomeImagesLoadingState extends HomeState {}

class HomeImagesLoadedState extends HomeState {}

class BrandDetailsLoadingState extends HomeState {}

class BrandDetailsLoadedState extends HomeState {}

class BrandDetailsErrorState extends HomeState {}

class TodaysDealsLoadingState extends HomeState {}
class HomeAdsLoadingState extends HomeState{
}
class HomeAdsLoadedState extends HomeState {}
class HomeAdsErrorState extends HomeState {}

class ComputerCollectionLoadingState extends HomeState {}


class TodaysDealsLoadedState extends HomeState {
  List<DealOfTheDay> deals;
  TodaysDealsLoadedState({required this.deals});
}

class TodaysDealsErrorState extends HomeState {}

class PopularProductLoadingState extends HomeState {}

class PopularProductLoadedState extends HomeState {
  List<Product> popular;
  PopularProductLoadedState({required this.popular});
}

class PopularProductErrorState extends HomeState {}

class FeaturedProductLoadingState extends HomeState {}

class FeaturedProductLoadedState extends HomeState {
  List<Product> featured;
  FeaturedProductLoadedState({required this.featured});
}
class MobileCollectionLoadingState extends HomeState{}
class ComputerCollectionErrorState extends HomeState{}

class MobileCollectionLoadedState extends HomeState {
  List<Product> mobileCollections;
  MobileCollectionLoadedState({required this.mobileCollections});
}
class ComputerCollectionLoadedState extends HomeState {
  List<Product> computerCollections;
  ComputerCollectionLoadedState({required this.computerCollections});
}

class MobileCollectionErrorState extends HomeState{}
class FeaturedProductErrorState extends HomeState {}

class DealProductByProductIdLoadingState extends HomeState {}

class DealProductByProductIdLoadedState extends HomeState {
  final Product dealproduct;
  DealProductByProductIdLoadedState({required this.dealproduct});
}
