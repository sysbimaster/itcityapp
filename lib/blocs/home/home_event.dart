
abstract class HomeEvent  {}
  

class FetchHomeImages extends HomeEvent {}

class FetchBrandDetails extends HomeEvent {}

class FetchTodaysDealsByDate extends HomeEvent {
  final String? currency;
  FetchTodaysDealsByDate(this.currency);
}

class FetchPopularProduct extends HomeEvent {
  final String? currencyp;
  FetchPopularProduct(this.currencyp);
}

class FetchFeaturedProduct extends HomeEvent {
  final String? currencyf;
  FetchFeaturedProduct(this.currencyf);
}

class FetchMobileCollections extends HomeEvent{
  final String? currencym;
  FetchMobileCollections(this.currencym);
}

class FetchHomeCollections extends HomeEvent{}

class FetchComputerCollections extends HomeEvent {
  final String? currencyco;
  FetchComputerCollections(this.currencyco);
}

class FetchHomeAds extends HomeEvent{}

class FetchDealsProductByProductId extends HomeEvent {
  final String productid;
  FetchDealsProductByProductId(this.productid);
}