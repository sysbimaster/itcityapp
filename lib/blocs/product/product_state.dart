
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {}
 
class ProductErrorState extends ProductState {}

class ProductByProductIdLoadingState extends ProductState {}

class ProductByProductIdLoadedState extends ProductState {}
class MultiImageByProductIdLoadedState extends ProductState {}

class ProductByProductIdErrorState extends ProductState {}

class ProductByCategoryIdLoadingState extends ProductState {}

class ProductByCategoryIdLoadedState extends ProductState {}

class ProductByCategoryIdErrorState extends ProductState {}

class ProductStockListByProductIdLoadingState extends ProductState {}

class ProductStockListByProductIdLoadedState extends ProductState {}

class ProductStockListByProductIdErrorState extends ProductState {}

class ProductPriceListByProductIdLoadingState extends ProductState {}

class ProductPriceListByProductIdLoadedState extends ProductState {}

class ProductPriceListByProductIdErrorState extends ProductState {}

class ProductImagesByProductIdLoadingState extends ProductState {}

class ProductImagesByProductIdLoadedState extends ProductState {}
  

class ProductImagesByProductIdErrorState extends ProductState {}

class ProductAttributesByProductIdLoadingState extends ProductState {}

class ProductAttributesByProductIdLoadedState extends ProductState {}

class ProductAttributesByProductIdErrorState extends ProductState {}

class ProductReviewByProductIdLoadingState extends ProductState {}

class ProductReviewByProductIdLoadedState extends ProductState {}

class ProductReviewByProductIdErrorState extends ProductState {}

class ProductByBrandByBrandIdLoadingState extends ProductState {}

class ProductByBrandByBrandIdLoadedState extends ProductState {}

class ProductByBrandByBrandIdErrorState extends ProductState {}

class CreateUserReviewLoadingState extends ProductState {}

class CreateUserReviewSuccessState extends ProductState {}

class CreateUserReviewErrorState extends ProductState {}

class SortProductBySortOrderLoadingState extends ProductState {}

class SortProductBySortOrderLoadedgState extends ProductState {}

class SortProductBySortOrderErrorState extends ProductState {}

class CheckProductStockByProductAttributeLoadingState extends ProductState {}

class CheckProductStockByProductAttributeLoadedState extends ProductState {}

class CheckProductStockByProductAttributeErrorState extends ProductState {}

class ShareProductByProductIdLoadingState extends ProductState {}

class ShareProductByProductIdLoadedState extends ProductState {}

class ShareProductByProductIdErrorState extends ProductState {}

class RelatedProductByProductBrandLoadingState extends ProductState{}

class RelatedProductByProductBrandLoadedState extends ProductState{}

class RelatedProductByProductBrandErrorState extends ProductState{}

class DealFullLoadingState extends ProductState{}
class DealFullLoadedState extends ProductState{}
class DealFullErrorState extends ProductState{}

class PopularProductFullLoadingState extends ProductState{}
class PopularProductFullLoadedState extends ProductState{}
class PopularProductFullErrorState extends ProductState{}

class FeaturedProductFullLoadingState extends ProductState{}
class FeaturedProductFullLoadedState extends ProductState{}
class FeaturedProductFullErrorState extends ProductState{}

class MobileCollectionsFullLoadingState extends ProductState{}
class MobileCollectionsFullLoadedState extends ProductState{}
class MobileCollectionsFullErrorState extends ProductState{}

class ComputerCollectionsFullLoadingState extends ProductState{}
class ComputerCollectionsFullLoadedState extends ProductState{}
class ComputerCollectionsFullErrorState extends ProductState{}