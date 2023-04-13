import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:itcity_online_store/api/api_client.dart';
import 'package:itcity_online_store/api/models/MultipleImageModel.dart';
import 'package:itcity_online_store/api/models/get_review_model.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/models/post_review_model.dart';
import 'dart:async';


class ProductApi {
  final ApiClient _apiClient = ApiClient();
  Random rnd = new Random();

  String _productPath = '/findAllProducts';
  String _categoryPath = '/findAllCategories';
  String _productByCategoryPath = '/findAllProductbyCategoryid';
  String _productByProductIdPath = '/findProductbyProductId';
  String _productStockListByProductIdPath = '/getProductStockListbyProductId';
  String _productPriceListByProductIdPath = '/getProductPriceListbyProductId';
  String _productImagesByProductIdPath = '/getProductImagesbyProductId';
  String _productAttributesByProductIdPath = '/getProductAttributesbyProductId';
  String _productReviewByProductIdPath = '/findProductReviewbyProductId';
  String _productByBrandByBrandIdPath = '';
  String _createUserReviewPath = '/createUserReview';
  String _sortProductBySortOrderPath = '';
  String _checkProductStockListByProductAttributePath = '';
  String _shareProductByProductIdPath = '';
  String _relatedProductByProductBrandPath = '/relatedproductbyproductid';
  String _dealsFullPath ='/getTodaysDealByDatefull';
  String _mobileCollectionsFullPath ='/findmobileProductbyCategoryidfull';
  String _computerCollectionsFullPath = '/findcomputerProductbyCategoryidfull';
  String _featuredProductFullPath ='/featuresproductfull';
  String _popularProductFullPath ='/popularproductfull';
  String _postReviewPath='/createUserReview';
  String _fetchReviewPath = '/findProductReviewbyProductId';
  String _fetchMultiImagesPath = '/getProductImagesbyProductId?product_id=';


  Future<List<Product>> getproduct() async {
    Response response = await _apiClient.invokeAPI(_productPath, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Category>> getCategory() async {
    Response response = await _apiClient.invokeAPI(_categoryPath, 'GET', null);
    print("Category>>>>>"+response.body.toString());
    return Category.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Product>> getProductByCategory(int? id,String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_productByCategoryPath?category_id=$id&cur=$currency', 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<DealOfTheDay>> getDealsFull(String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_dealsFullPath?cur=$currency', 'GET', null);
    return DealOfTheDay.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> getmobileCollectionFull(String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_mobileCollectionsFullPath?cur=$currency', 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> getcomputerCollectionFull(String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_computerCollectionsFullPath?cur=$currency', 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> getpopularProductFull(String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_popularProductFullPath?cur=$currency', 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> getfeaturedProductFull(String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_featuredProductFullPath?cur=$currency', 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<Product> getProductByProductId(String? id,String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_productByProductIdPath?product_id=$id&cur=$currency', 'GET', null);
    return Product.fromJson(jsonDecode(response.body)['data'][0]);
  }
  Future<MultipleImageModel> getmultiImagesByProductId(String? id) async {
    Response response = await _apiClient.invokeAPI(
        '$_fetchMultiImagesPath$id', 'GET', null);
    return MultipleImageModel.fromJson(jsonDecode(response.body));
  }

  Future<List<ProductStockList>> getProductStockListByProductId(
      String id) async {
    Response response = await _apiClient.invokeAPI(
        '$_productStockListByProductIdPath?product_id=$id', 'GET', null);
    return ProductStockList.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<ProductPriceList>> getProductPriceListByProductId(
      String id) async {
    Response response = await _apiClient.invokeAPI(
        '$_productPriceListByProductIdPath?product_id=$id', 'GET', null);
    return ProductPriceList.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<ProductImages>> getProductImagesByProductId(String id) async {
    Response response = await _apiClient.invokeAPI(
        '$_productImagesByProductIdPath?product_id=$id', 'GET', null);
    return ProductImages.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<ProductAttributes>> getProductAttributesByProductId(
      String id) async {
    Response response = await _apiClient.invokeAPI(
        '$_productAttributesByProductIdPath?product_id=$id', 'GET', null);
    return ProductAttributes.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Review>> getProductReviewByProductId(String? id) async {
    Response response = await _apiClient.invokeAPI(
        '$_productReviewByProductIdPath?product_id=$id', 'GET', null);
    return Review.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Product>> getProductByBrandByBrandId(String brandId) async {
    Response response =
        await _apiClient.invokeAPI(_productByBrandByBrandIdPath, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<String?> createUserReview(Review review) async {
    String jsonString =
        '{"author_name": "${review.authorName}","product_id":"${review.productId}","text":"${review.text}","rating":"${review.rating}","review_status":"1"}';
    Response response = await _apiClient.invokeAPI(
        '$_createUserReviewPath', 'POST', jsonString);

    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<List<Product>> sortProductBySortOrder(var sortOrder) async {
    Response response = await _apiClient.invokeAPI(
        _sortProductBySortOrderPath, 'GET', sortOrder.toJson());
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<ProductAttributes> checkProductStockByProductAttribute(
      var attributeValue, var productId) async {
    ProductAttributes attributes = ProductAttributes();
    attributes.attributeValue = attributeValue;
    attributes.productId = productId;
    Response response = await _apiClient.invokeAPI(
        _checkProductStockListByProductAttributePath,
        'GET',
        attributes.toJson());
    return ProductAttributes.fromJson(jsonDecode(response.body)['data']);
  }

  Future<String?> shareProductByProductId(var productId) async {
    Response response =
        await _apiClient.invokeAPI(_shareProductByProductIdPath, 'GET', null);
    return (jsonDecode(response.body)['data']).cast<String>();
  }

  Future<List<Product>> search(String term, String? currency) async {
    var url = "/searchProductOrBrandOrCategory?value=$term&cur=$currency";
    print(url);
    Response response =  await _apiClient.invokeAPI(url, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']['data']);
  }

  Future<List<Product>> getRelatedProductByProductBrand(var brand,String? currency) async {
    Response response = await _apiClient.invokeAPI(
        '$_relatedProductByProductBrandPath?product_brand=$brand&cur=$currency', 'GET', null);
        print(response.body);
    return Product.listFromJson(jsonDecode(response.body)['data']['data']);
  }

  Future<double> getRandomReview() async {
    double max = 5.0;
    double min = 3.9;
    double rating  = min + rnd.nextDouble();
    if(rating > 5.0){
      return 5.0;
    }
    return min + rnd.nextDouble();
  }

  Future<PostReviewModel> PostRandomReview(String? author,String? productId,String? text,int? rating) async {
    Response response = await _apiClient.invokeAPI(
        '$_postReviewPath?author_name=$author&product_id=$productId&text=$text&rating=$rating', 'POST', null);
    print(response);
    return PostReviewModel.fromJson(jsonDecode(response.body));
  }
  Future<GetReviewModel> GetReview(String? productId) async {
    Response response = await _apiClient.invokeAPI(
        '$_fetchReviewPath?product_id=$productId', 'GET', null);
    print(response);
    return GetReviewModel.fromJson(jsonDecode(response.body));
  }
}
