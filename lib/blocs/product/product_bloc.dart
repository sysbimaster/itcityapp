import 'dart:async';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/product/products.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';
import '../blocs.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductApi productApi;
  ProductBloc({this.productApi})
      : assert(productApi != null),
        super(null);
  
  @override
  ProductState get initialState => ProductInitialState();
  List<Product> currentProducts = [];
  Product currentProduct;
  List<ProductStockList> stocklist = [];
  List<Product> productListByCategory = [];
  List<ProductPriceList> price = [];
  List<ProductImages> images = [];
  List<ProductAttributes> attributes = [];
  List<Review> reviews = [];
  List<Product> productListByBrand = [];
  Review userReview;
  List<Product> sortedProducts = [];
  List<Product> relatedProduct = [];
  String reviewStatus;
  List<DealOfTheDay> dealsFullList;
  List<Product> mobileCollectionsFull;
  List<Product> popularProductsFull;
  List<Product> computerCollectionsFull;
  List<Product> featuredProductsFull;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    ProductState state;
    if (event is FetchProduct) {
      yield* _mapFetchProductToState(state, event);
    }
    if (event is FetchProductByCategoryId) {
      yield* _mapFetchProductByCategoryIdToState(state, event, event.id,event.currency);
    }
    if (event is FetchProductByProductId) {
      yield* _mapFetchProductByProductIdToState(state, event, event.id,event.currency);
    }

    if (event is FetchProductStockListByProductId) {
      yield* _mapFetchProductStockListByProductIdToState(
          state, event, event.id);
    }
    if (event is FetchProductPriceListByProductId) {
      yield* _mapFetchProductPriceListByProductIdToState(
          state, event, event.id);
    }
    if (event is FetchProductImagesByProductId) {
      yield* _mapFetchProductImagesByProductIdToState(state, event, event.id);
    }
    if (event is FetchProductAttributesByProductId) {
      yield* _mapFetchProductAttributesByProductIdToState(
          state, event, event.id);
    }
    if (event is FetchProductReviewByProductId) {
      yield* _mapFetchProductReviewByProductIdToState(state, event, event.id);
    }
    if (event is FetchAllProductByBrandByBrandId) {
      yield* _mapFetchProductByBrandbyBrandIdToState(
          state, event, event.brandId);
    }
    if (event is CreateUserReviewEvent) {
      yield* _mapCreateUserReviewToState(state, event, event.review);
    }
    if (event is SortProductBySortOrderEvent) {
      yield* _mapSortProductBySortOrderToState(state, event, event.sortOrder);
    }
    if (event is CheckProductStockByProductAttributeEvent) {
      yield* _mapCheckProductStockByProductAttributeToState(
          state, event, event.attributeValue, event.productId);
    }
    if (event is ShareProductByProductIdEvent) {
      yield* _mapShareProductByProductIdToState(
          state, event, event.productSlug);
    }
    if (event is FetchRelatedProductByProductBrand) {
      yield* _mapFetchRelatedProductByProductBrandToState(
          state, event, event.brand,event.currency);
    }
    if(event is FetchDealsFull){
      yield* _mapFetchDealsFullToState(state,event,event.currency);
    }
    if(event is FetchMobileCollectionsFull){
      yield* _mapFetchMobileCollectionsFullToState(state,event,event.currency);
    }
    if(event is FetchPopularProductsFull){
      yield* _mapFetchPopularProductsFullToState(state,event,event.currency);
    }
    if(event is FetchComputerCollectionsFull){
      yield* _mapFetchComputerCollectionsFullToState(state,event,event.currency);
    }
    if(event is FetchFeaturedProductFull){
      yield* _mapFetchFeaturedProductsFullToState(state,event,event.currency);
    }
  }
  Stream<ProductState> _mapFetchFeaturedProductsFullToState(
      ProductState state, ProductEvent event,String currency) async* {
    yield FeaturedProductFullLoadingState();
    try {
      final List<Product> productList = await productApi.getfeaturedProductFull(currency);
      featuredProductsFull = productList;
      yield FeaturedProductFullLoadedState();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield FeaturedProductFullErrorState();
    }
  }
  Stream<ProductState> _mapFetchComputerCollectionsFullToState(
      ProductState state, ProductEvent event,String currency) async* {
    yield ComputerCollectionsFullLoadingState();
    try {
      final List<Product> productList = await productApi.getcomputerCollectionFull(currency);
      computerCollectionsFull = productList;
      yield ComputerCollectionsFullLoadedState();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield ComputerCollectionsFullErrorState();
    }
  }
  Stream<ProductState> _mapFetchDealsFullToState(
      ProductState state, ProductEvent event,String currency) async* {
    yield DealFullLoadingState();
    try {
      final List<DealOfTheDay> DealOftheDay = await productApi.getDealsFull(currency);

      // if (product != null) {
      dealsFullList= DealOftheDay;
      // }

      yield DealFullLoadedState();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield DealFullErrorState();
    }
  }
  Stream<ProductState> _mapFetchMobileCollectionsFullToState(
      ProductState state, ProductEvent event,String currency) async* {
    yield MobileCollectionsFullLoadingState();
    try {
      final List<Product> productList = await productApi.getmobileCollectionFull(currency);
      mobileCollectionsFull = productList;


      yield MobileCollectionsFullLoadedState();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield MobileCollectionsFullErrorState();
    }
  }
  Stream<ProductState> _mapFetchPopularProductsFullToState(
      ProductState state, ProductEvent event,String currency) async* {
    yield PopularProductFullLoadingState();
    try {
      final List<Product> productList = await productApi.getpopularProductFull(currency);
      popularProductsFull = productList;
      yield PopularProductFullLoadedState();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield PopularProductFullErrorState();
    }
  }
  Stream<ProductState> _mapFetchProductToState(
      ProductState state, ProductEvent event) async* {
    yield ProductLoadingState();
    try {
      final List<Product> products = await productApi.getproduct();
      currentProducts = products;
      yield ProductLoadedState();
    } catch (e) {
      print("error in fetching all product>>>>>>>" + e.toString());
    }
  }

  Stream<ProductState> _mapFetchProductByCategoryIdToState(
      ProductState state, ProductEvent event, int id,String currency) async* {
    yield ProductByCategoryIdLoadingState();
    try {
      final List<Product> productlist =
          await productApi.getProductByCategory(id,currency);
      productListByCategory = productlist;
      yield ProductByCategoryIdLoadedState();
    } catch (e) {
      print("error");
      print(e);
    }
  }

  Stream<ProductState> _mapFetchProductByProductIdToState(
      ProductState state, ProductEvent event, var id,String currency) async* {
    yield ProductByProductIdLoadingState();
    try {
      final Product product = await productApi.getProductByProductId(id,currency);
      print('product id =>' + product.productId);
      // if (product != null) {
      currentProduct = product;
      // }

      yield ProductByProductIdLoadedState();
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
    }
  }

  Stream<ProductState> _mapFetchProductStockListByProductIdToState(
      ProductState state, ProductEvent event, var id) async* {
    yield ProductStockListByProductIdLoadingState();
    try {
      List<ProductStockList> stock =
          await productApi.getProductStockListByProductId(id);
      stocklist = stock;
      yield ProductStockListByProductIdLoadedState();
    } catch (e) {
      print(e);
      print("error in loading product stock list");
    }
  }

  Stream<ProductState> _mapFetchProductPriceListByProductIdToState(
      ProductState state, ProductEvent event, var id) async* {
    yield ProductPriceListByProductIdLoadingState();
    try {
      List<ProductPriceList> prices =
          await productApi.getProductPriceListByProductId(id);
      price = prices;
      yield ProductPriceListByProductIdLoadedState();
    } catch (e) {
      print(e);
      print("error in loading product price list");
    }
  }

  Stream<ProductState> _mapFetchProductImagesByProductIdToState(
      ProductState state, ProductEvent event, var id) async* {
    yield ProductImagesByProductIdLoadingState();
    try {
      List<ProductImages> image =
          await productApi.getProductImagesByProductId(id);
      images = image;
      yield ProductImagesByProductIdLoadedState();
    } catch (e) {
      print(e);
      print("error in loading product images");
    }
  }

  Stream<ProductState> _mapFetchProductAttributesByProductIdToState(
      ProductState state, ProductEvent event, var id) async* {
    yield ProductAttributesByProductIdLoadingState();
    try {
      List<ProductAttributes> attributes =
          await productApi.getProductAttributesByProductId(id);
      attributes = attributes;
      yield ProductAttributesByProductIdLoadedState();
    } catch (e) {
      print(e);
      print("error in loading product Attributes");
    }
  }

  Stream<ProductState> _mapFetchProductReviewByProductIdToState(
      ProductState state, ProductEvent event, var id) async* {
    yield ProductReviewByProductIdLoadingState();
    try {
      reviews = await productApi.getProductReviewByProductId(id);

      yield ProductReviewByProductIdLoadedState();
    } catch (e) {
      print(e);
      print("error in loading product reviews");
    }
  }

  Stream<ProductState> _mapFetchProductByBrandbyBrandIdToState(
      ProductState state, ProductEvent event, var brandId) async* {
    try {
      List<Product> productlist =
          await productApi.getProductByBrandByBrandId(brandId);
      productListByBrand = productlist;
    } catch (e) {}
  }

  Stream<ProductState> _mapCreateUserReviewToState(
      ProductState state, ProductEvent event, Review review) async* {
    try {
      String s = await productApi.createUserReview(review);
      reviewStatus = s;
      yield CreateUserReviewSuccessState();
    } catch (e) {}
  }

  Stream<ProductState> _mapSortProductBySortOrderToState(
      ProductState state, ProductEvent event, var sortOrder) async* {
    try {
      List<Product> productlist =
          await productApi.sortProductBySortOrder(sortOrder);
      sortedProducts = productlist;
    } catch (e) {}
  }

  Stream<ProductState> _mapCheckProductStockByProductAttributeToState(
      ProductState state,
      ProductEvent event,
      var attributeValue,
      var productId) async* {
    try {
      ProductAttributes attributes = await productApi
          .checkProductStockByProductAttribute(attributeValue, productId);
    } catch (e) {}
  }

  Stream<ProductState> _mapShareProductByProductIdToState(
      ProductState state, ProductEvent event, var productSlug) async* {
    try {
      String url = await productApi.shareProductByProductId(productSlug);
    } catch (e) {}
  }

  Stream<ProductState> _mapFetchRelatedProductByProductBrandToState(
      ProductState state, ProductEvent event, var brand, String currency) async* {
    yield RelatedProductByProductBrandLoadingState();
    try {
      List<Product> related =
          await productApi.getRelatedProductByProductBrand(brand,currency);
      relatedProduct = related;
      yield RelatedProductByProductBrandLoadedState();
    } catch (e) {
      print('Error in fetching related product' + e.toString());
    }
  }
}
