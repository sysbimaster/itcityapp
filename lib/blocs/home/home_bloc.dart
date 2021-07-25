import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:itcity_online_store/blocs/home/home.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.homeApi) : super(HomeInitial());
  HomeApi homeApi;
  List<HomeImages> image = [];
  List<Brands> brands = [];
  List<DealOfTheDay> dealslist = [];
  List<Product> popularProduct = [];
  List<Product> featuredProduct = [];
  List<Product> mobileColletions = [];
  List<Product> computerCollections = [];
  List<HomeAds> homeadslist = [];

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchHomeImages) {
      yield* _mapFetchHomeImagesToState(event, state);
    }
    if (event is FetchBrandDetails) {
      yield* _mapFetchBrandDetailsToState(event, state);
    }
    if (event is FetchTodaysDealsByDate) {
      yield* _mapFetchTodaysDealsByDatetoState(event, state,event.currency);
    }
    if (event is FetchPopularProduct) {
      yield* _mapFetchPopularProductToState(event, state,event.currencyp);
    }
    if (event is FetchFeaturedProduct) {
      yield* _mapFetchFeaturedProductToState(event, state,event.currencyf);
    }
    if(event is FetchMobileCollections){
      yield* _mapFetchMobileCollections(event,state,event.currencym);
    }
    if(event is FetchComputerCollections){
      yield* _mapFetchComputerCollections(event,state,event.currencyco);
    }
    if (event is FetchHomeAds){
      yield* _mapFetchHomeAdsToState(event, state);
    }
   
  }

  Stream<HomeState> _mapFetchHomeImagesToState(
      HomeEvent event, HomeState state) async* {
    yield HomeImagesLoadingState();
    try {
      image = await homeApi.fetchHomeimages();
      yield HomeImagesLoadedState();
    } catch (e) {
      print('error in home image Loading >>>>>>.' + e.toString());
      yield HomeImagesErrorState();
    }
  }
  Stream<HomeState> _mapFetchHomeAdsToState(
      HomeEvent event, HomeState state) async* {
    yield HomeAdsLoadingState();
    try {
      final List<HomeAds> homeadslist = await homeApi.fetchHomeAds();
      this.homeadslist = homeadslist;
      print("in ads bloc"+homeadslist.length.toString());
      yield HomeAdsLoadedState();
    } catch (e) {
      print('error in home image Loading >>>>>>.' + e.toString());
      yield HomeAdsErrorState();
    }
  }

  Stream<HomeState> _mapFetchBrandDetailsToState(
      HomeEvent event, HomeState state) async* {
    yield BrandDetailsLoadingState();
    try {
      final List<Brands> brand = await homeApi.fetchBrandDetails();
      brands = brand;
      yield BrandDetailsLoadedState();
    } catch (e) {
      print('error in brand details >>>>>>>>>>>' + e.toString());
      yield BrandDetailsErrorState();
    }
  }

  Stream<HomeState> _mapFetchTodaysDealsByDatetoState(
      HomeEvent event, HomeState state,String currency) async* {
    try {
      dealslist = await homeApi.fetchTodaysDealsByDate(currency);
      print("deals called in home bloc" + currency);
    //  print('deal list length'+ dealslist[0].productPrice);
      // for(var i=0;i<dealslist.length;i++){
      //   print("product price ="  + dealslist[i].productPrice);
      // }

      yield TodaysDealsLoadedState(deals: dealslist);
    } catch (e) {
      print("error in today deals >>>>>>>>>>>>" + e.toString());
      yield TodaysDealsErrorState();
    }
  }

  Stream<HomeState> _mapFetchPopularProductToState(
      HomeEvent event, HomeState state,String currency) async* {
    yield PopularProductLoadingState();
    try {
      final List<Product> product = await homeApi.fetchPopularProduct(currency);
      popularProduct = product;
      yield PopularProductLoadedState(popular: popularProduct);
    } catch (e) {
      print('error in popular product  >>>>>>>>>>>>.' + e.toString());
      yield PopularProductErrorState();
    }
  }

  Stream<HomeState> _mapFetchFeaturedProductToState(
      HomeEvent event, HomeState state,String currency) async* {
    yield FeaturedProductLoadingState();
    try {
      final List<Product> product = await homeApi.fetchFeaturedProduct(currency);
      featuredProduct = product;
      print(product.length.toString()+ "inside mapfetchfeaturedproductstate");

      yield FeaturedProductLoadedState(featured: featuredProduct);
    } catch (e) {
      print('error in featured product  >>>>>>>>>' + e.toString());
      yield FeaturedProductErrorState();
    }
  }

  Stream<HomeState> _mapFetchMobileCollections (HomeEvent event, HomeState state,String currency) async*{
        yield MobileCollectionLoadingState();
        try {
          final List<Product> product = await homeApi.fetchMobileCollections(currency);
          mobileColletions = product;
          yield MobileCollectionLoadedState(mobileCollections: mobileColletions);
        }catch (e){
          print('error in MobileCollection product  >>>>>>>>>' + e.toString());
      yield MobileCollectionErrorState();
    }

}

  Stream<HomeState> _mapFetchComputerCollections (HomeEvent event, HomeState state,String currency) async*{
    yield ComputerCollectionLoadingState();
    try {
      final List<Product> product = await homeApi.fetchComputerCollections(currency);
     computerCollections = product;
     print('computerCollections length in bloc' + computerCollections.length.toString() );
      yield ComputerCollectionLoadedState(computerCollections: computerCollections);
    }catch (e){
      print('error in ComputerCollection product  >>>>>>>>>' + e.toString());
      yield ComputerCollectionErrorState();
    }

  }
 
}

