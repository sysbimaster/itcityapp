import 'package:itcity_online_store/api/models/models.dart';

abstract class ProductEvent {}

class FetchProduct extends ProductEvent {}

class FetchDealsFull extends ProductEvent{
  final String? currency;
  FetchDealsFull(this.currency);
}

class FetchMobileCollectionsFull extends ProductEvent {
  final String? currency;
  FetchMobileCollectionsFull(this.currency);
}

class FetchComputerCollectionsFull extends ProductEvent{
  final String? currency;
  FetchComputerCollectionsFull(this.currency);
}
class FetchPopularProductsFull extends ProductEvent {
  final String? currency;
  FetchPopularProductsFull(this.currency);
}

class FetchFeaturedProductFull extends ProductEvent{
  final String? currency;
  FetchFeaturedProductFull(this.currency);
}


class FetchProductByCategoryId extends ProductEvent {
  final int? id;
  final String? currency;
  FetchProductByCategoryId(this.id,this.currency);
}

class FetchProductByProductId extends ProductEvent {
  final String? id;
  final String? currency;
  FetchProductByProductId(this.id,this.currency);
}
class FetchMultiImageByProductId extends ProductEvent {
  final String? id;

  FetchMultiImageByProductId (this.id);
}

class FetchProductStockListByProductId extends ProductEvent {
  final String id;
  FetchProductStockListByProductId(this.id);
}

class FetchProductPriceListByProductId extends ProductEvent {
  final String id;
  FetchProductPriceListByProductId(this.id);
}

class FetchProductImagesByProductId extends ProductEvent {
  final String id;
  FetchProductImagesByProductId(this.id);
}

class FetchProductAttributesByProductId extends ProductEvent {
  final String id;
  FetchProductAttributesByProductId(this.id);
}

class FetchProductReviewByProductId extends ProductEvent {
  final String? id;
  FetchProductReviewByProductId(this.id);
}

class FetchAllProductByBrandByBrandId extends ProductEvent {
  final String brandId;
  FetchAllProductByBrandByBrandId(this.brandId);
}

class CreateUserReviewEvent extends ProductEvent {
  final Review review;
  CreateUserReviewEvent(this.review);
}

class SortProductBySortOrderEvent extends ProductEvent {
  final int sortOrder;
  SortProductBySortOrderEvent(this.sortOrder);
}

class CheckProductStockByProductAttributeEvent extends ProductEvent {
  final String attributeValue;
  final String productId;
  CheckProductStockByProductAttributeEvent(this.attributeValue, this.productId);
}

class ShareProductByProductIdEvent extends ProductEvent {
  final String productSlug;
  ShareProductByProductIdEvent(this.productSlug);
}

class FetchRelatedProductByProductBrand extends ProductEvent {
  final String? brand;
  final String? currency;
  FetchRelatedProductByProductBrand(this.brand, this.currency);
}
