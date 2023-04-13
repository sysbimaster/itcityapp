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

  Future<List<DealOfTheDay>> fetchTodaysDealsByDate(String currency) async {
    String url = '$_todaysDealsPath?cur=$currency';
    Response response =
        await _apiclient.invokeAPI(url, 'GET', null);
    print( "Deals test >>>>" +response.body.toString());
    return DealOfTheDay.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> fetchPopularProduct(String? currency) async {
    String url = '$_popularProductPath?cur=$currency';
    Response response =
    await _apiclient.invokeAPI(url, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> fetchMobileCollections(String? currency) async {
    String url = '$_mobileCollectionsPath?cur=$currency';
    Response response =
        await _apiclient.invokeAPI(url, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }
  Future<List<Product>> fetchComputerCollections(String? currency) async {
    String url = '$_computerCollectionsPath?cur=$currency';
    Response response =
    await _apiclient.invokeAPI(url, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }

  Future<List<Product>> fetchFeaturedProduct(String? currency) async {
    String url = '$_featuredProductPath?cur=$currency';
    Response response =
        await _apiclient.invokeAPI(url, 'GET', null);
    return Product.listFromJson(jsonDecode(response.body)['data']);
  }

  
}
