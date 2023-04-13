import 'package:itcity_online_store/api/models/MultipleImageModel.dart';
import 'package:itcity_online_store/blocs/blocs.dart';
import 'package:itcity_online_store/blocs/product/products.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductApi productApi;

  
  @override
  ProductState get initialState => ProductInitialState();
  List<Product> currentProducts = [];
  Product? currentProduct;
  List<ProductStockList> stocklist = [];
  List<Product> productListByCategory = [];
  List<ProductPriceList> price = [];
  List<ProductImages> images = [];
  List<ProductAttributes> attributes = [];
  List<Review> reviews = [];
  List<Product> productListByBrand = [];
  Review? userReview;
  List<Product> sortedProducts = [];
  List<Product> relatedProduct = [];
  String? reviewStatus;
  List<DealOfTheDay>? dealsFullList;
  List<Product>? mobileCollectionsFull;
  List<Product>? popularProductsFull;
  List<Product>? computerCollectionsFull;
  List<Product>? featuredProductsFull;
  MultipleImageModel? multipleImageModel;

  ProductBloc({required this.productApi})
      :         super(ProductInitialState()){
    on<FetchProduct>((event, emit) => _mapFetchProductToState(emit, event));
    on<FetchProductByCategoryId>((event, emit) => _mapFetchProductByCategoryIdToState(emit, event, event.id,event.currency));
    on<FetchProductByProductId>((event, emit) => _mapFetchProductByProductIdToState(emit, event, event.id,event.currency));
    on<FetchMultiImageByProductId>((event, emit) => _mapFetchMultiImageByProductIdToState(emit, event, event.id));
    on<FetchProductStockListByProductId>((event, emit) => _mapFetchProductStockListByProductIdToState(emit, event, event.id));
    on<FetchProductPriceListByProductId>((event, emit) =>_mapFetchProductPriceListByProductIdToState(emit, event, event.id));
    on<FetchProductImagesByProductId>((event, emit) => _mapFetchProductImagesByProductIdToState(emit, event, event.id));
    on<FetchProductAttributesByProductId>((event, emit) => _mapFetchProductAttributesByProductIdToState(emit, event, event.id));
    on<FetchProductReviewByProductId>((event, emit) => _mapFetchProductReviewByProductIdToState(emit, event, event.id));
    on<FetchAllProductByBrandByBrandId>((event, emit) => _mapFetchProductByBrandbyBrandIdToState(emit, event, event.brandId));
    on<CreateUserReviewEvent>((event, emit) => _mapCreateUserReviewToState(emit, event, event.review));
    on<SortProductBySortOrderEvent>((event, emit) => _mapSortProductBySortOrderToState(emit, event, event.sortOrder));
    on<CheckProductStockByProductAttributeEvent>((event, emit) => _mapCheckProductStockByProductAttributeToState(
        emit, event, event.attributeValue, event.productId));
    on<ShareProductByProductIdEvent>((event, emit) => _mapShareProductByProductIdToState(
        emit, event, event.productSlug));
    on<FetchRelatedProductByProductBrand>((event, emit) => _mapFetchRelatedProductByProductBrandToState(
        emit, event, event.brand,event.currency));
    on<FetchDealsFull>((event, emit) => _mapFetchDealsFullToState(emit,event,event.currency));
    on<FetchMobileCollectionsFull>((event, emit) => _mapFetchMobileCollectionsFullToState(emit,event,event.currency));
    on<FetchPopularProductsFull>((event, emit) => _mapFetchPopularProductsFullToState(emit,event,event.currency));
    on<FetchComputerCollectionsFull>((event, emit) => _mapFetchComputerCollectionsFullToState(emit,event,event.currency));
    on<FetchFeaturedProductFull>((event, emit) => _mapFetchFeaturedProductsFullToState(emit,event,event.currency));





  }


 void _mapFetchFeaturedProductsFullToState(
      Emitter<ProductState> emit, ProductEvent event,String? currency) async {
    emit(FeaturedProductFullLoadingState());
    try {
      final List<Product> productList = await productApi.getfeaturedProductFull(currency);
      featuredProductsFull = productList;
      emit( FeaturedProductFullLoadedState());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      emit(FeaturedProductFullErrorState());
    }
  }
 void _mapFetchComputerCollectionsFullToState(
     Emitter<ProductState> emit, ProductEvent event,String? currency) async {
    emit(ComputerCollectionsFullLoadingState());
    try {
      final List<Product> productList = await productApi.getcomputerCollectionFull(currency);
      computerCollectionsFull = productList;
      emit(ComputerCollectionsFullLoadedState());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      emit(ComputerCollectionsFullErrorState());
    }
  }
  void _mapFetchDealsFullToState(
      Emitter<ProductState> emit, ProductEvent event,String? currency) async {
    emit(DealFullLoadingState());
    try {
      final List<DealOfTheDay> DealOftheDay = await productApi.getDealsFull(currency);

      // if (product != null) {
      dealsFullList= DealOftheDay;
      // }

      emit(DealFullLoadedState());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      emit(DealFullErrorState());
    }
  }
  void _mapFetchMobileCollectionsFullToState(
      Emitter<ProductState> emit, ProductEvent event,String? currency) async {
    emit(MobileCollectionsFullLoadingState());
    try {
      final List<Product> productList = await productApi.getmobileCollectionFull(currency);
      mobileCollectionsFull = productList;


      emit(MobileCollectionsFullLoadedState());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      emit(MobileCollectionsFullErrorState());
    }
  }
  void _mapFetchPopularProductsFullToState(
      Emitter<ProductState> emit, ProductEvent event,String? currency) async {
    emit(PopularProductFullLoadingState());
    try {
      final List<Product> productList = await productApi.getpopularProductFull(currency);
      popularProductsFull = productList;
      emit(PopularProductFullLoadedState());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      emit(PopularProductFullErrorState());
    }
  }
  void _mapFetchProductToState(
      Emitter<ProductState> emit, ProductEvent event) async {
    emit(ProductLoadingState());
    try {
      final List<Product> products = await productApi.getproduct();
      currentProducts = products;
      emit(ProductLoadedState());
    } catch (e) {
      print("error in fetching all product>>>>>>>" + e.toString());
    }
  }

  void _mapFetchProductByCategoryIdToState(
      Emitter<ProductState> emit, ProductEvent event, int? id,String? currency) async {
   emit( ProductByCategoryIdLoadingState());
    try {
      final List<Product> productlist =
          await productApi.getProductByCategory(id,currency);
      productListByCategory = productlist;
      emit(ProductByCategoryIdLoadedState());
    } catch (e) {
      print("error");
      print(e);
    }
  }

 void _mapFetchProductByProductIdToState(
     Emitter<ProductState> emit, ProductEvent event, var id,String? currency) async {
    emit(ProductByProductIdLoadingState());
    try {
      final Product product = await productApi.getProductByProductId(id,currency);


      currentProduct = product;


      emit(ProductByProductIdLoadedState());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
    }
  }
 void _mapFetchMultiImageByProductIdToState(
     Emitter<ProductState> emit, ProductEvent event, var id) async {
    emit( ProductByProductIdLoadingState());
    try {
     multipleImageModel = await productApi.getmultiImagesByProductId(id);

      // if (product != null) {


      emit(MultiImageByProductIdLoadedState());
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
    }
  }

void _mapFetchProductStockListByProductIdToState(
    Emitter<ProductState> emit, ProductEvent event, var id) async {
    emit(ProductStockListByProductIdLoadingState());
    try {
      List<ProductStockList> stock =
          await productApi.getProductStockListByProductId(id);
      stocklist = stock;
      emit(ProductStockListByProductIdLoadedState());
    } catch (e) {

    }
  }

void _mapFetchProductPriceListByProductIdToState(
    Emitter<ProductState> emit, ProductEvent event, var id) async {
    emit(ProductPriceListByProductIdLoadingState());
    try {
      List<ProductPriceList> prices =
          await productApi.getProductPriceListByProductId(id);
      price = prices;
      emit(ProductPriceListByProductIdLoadedState());
    } catch (e) {
      print(e);

    }
  }

 void _mapFetchProductImagesByProductIdToState(
     Emitter<ProductState> emit, ProductEvent event, var id) async {
    emit( ProductImagesByProductIdLoadingState());
    try {
      List<ProductImages> image =
          await productApi.getProductImagesByProductId(id);
      images = image;
      emit(ProductImagesByProductIdLoadedState());
    } catch (e) {
      print(e);
      print("error in loading product images");
    }
  }

  void _mapFetchProductAttributesByProductIdToState(
      Emitter<ProductState> emit, ProductEvent event, var id) async {
  emit(ProductAttributesByProductIdLoadingState());
    try {
      List<ProductAttributes> attributes =
          await productApi.getProductAttributesByProductId(id);
      attributes = attributes;
      emit(ProductAttributesByProductIdLoadedState());
    } catch (e) {
      print(e);
      print("error in loading product Attributes");
    }
  }

  void _mapFetchProductReviewByProductIdToState(
      Emitter<ProductState> emit, ProductEvent event, var id) async {
    emit(ProductReviewByProductIdLoadingState());
    try {
      reviews = await productApi.getProductReviewByProductId(id);

      emit(ProductReviewByProductIdLoadedState());
    } catch (e) {
      print(e);
      print("error in loading product reviews");
    }
  }

  void _mapFetchProductByBrandbyBrandIdToState(
      Emitter<ProductState> emit, ProductEvent event, var brandId) async {
    try {
      List<Product> productlist =
          await productApi.getProductByBrandByBrandId(brandId);
      productListByBrand = productlist;
    } catch (e) {}
  }

void _mapCreateUserReviewToState(
    Emitter<ProductState> emit, ProductEvent event, Review review) async {
    try {
      String? s = await productApi.createUserReview(review);
      reviewStatus = s;
      emit(CreateUserReviewSuccessState());
    } catch (e) {}
  }

  void _mapSortProductBySortOrderToState(
      Emitter<ProductState> emit, ProductEvent event, var sortOrder) async {
    try {
      List<Product> productlist =
          await productApi.sortProductBySortOrder(sortOrder);
      sortedProducts = productlist;
    } catch (e) {}
  }

void _mapCheckProductStockByProductAttributeToState(
    Emitter<ProductState> emit,
      ProductEvent event,
      var attributeValue,
      var productId) async {
    try {
      ProductAttributes attributes = await productApi
          .checkProductStockByProductAttribute(attributeValue, productId);
    } catch (e) {}
  }

void _mapShareProductByProductIdToState(
    Emitter<ProductState> emit, ProductEvent event, var productSlug) async {
    try {
      String? url = await productApi.shareProductByProductId(productSlug);
    } catch (e) {}
  }

void _mapFetchRelatedProductByProductBrandToState(
    Emitter<ProductState> emit, ProductEvent event, var brand, String? currency) async {
   emit(RelatedProductByProductBrandLoadingState());
    try {
      List<Product> related =
          await productApi.getRelatedProductByProductBrand(brand,currency);
      relatedProduct = related;
      emit(RelatedProductByProductBrandLoadedState());
    } catch (e) {
      print('Error in fetching related product' + e.toString());
    }
  }
}
