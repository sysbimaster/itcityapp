import 'package:itcity_online_store/api/models/HomeAds.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/api_client.dart';
import 'dart:convert';
import 'package:http/http.dart';

class HomeApi {
  ApiClient _apiclient = ApiClient();

  String _homeImagesPath = '/findHomeImages';
  String _brandDetailsPath = '/findAllBrandDetails';
  String _todaysDealsPath = '/getTodaysDealByDate';
  String _popularProductPath = '/popularproduct';
  String _featuredProductPath = '/featuresproduct';
  String _mobileCollectionsPath = '/findmobileProductbyCategoryid';
  String _computerCollectionsPath = '/findcomputerProductbyCategoryid';
  String _homeAdsPath = '/homeads';

  Future<List<HomeImages>> fetchHomeimages() async {
    Response response =
        await _apiclient.invokeAPI(_homeImagesPath, 'GET', null);
    return HomeImages.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<HomeAds>> fetchHomeAds() async {
    Response response =
    await _apiclient.invokeAPI(_homeAdsPath, 'GET', null);
    return HomeAds.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Brands>> fetchBrandDetails() async {
    Response response =
        await _apiclient.invokeAPI(_brandDetailsPath, 'GET', null);
    return Brands.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<DealOfTheDay>> fetchTodaysDealsByDate() async {
    Response response =
        await _apiclient.invokeAPI(_todaysDealsPath, 'GET', null);
    return DealOfTheDay.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> fetchPopularProduct() async {
    Response response =
    await _apiclient.invokeAPI(_popularProductPath, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> fetchMobileCollections() async {
    Response response =
        await _apiclient.invokeAPI(_mobileCollectionsPath, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> fetchComputerCollections() async {
    Response response =
    await _apiclient.invokeAPI(_computerCollectionsPath, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Product>> fetchFeaturedProduct() async {
    Response response =
        await _apiclient.invokeAPI(_featuredProductPath, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }

  
}
