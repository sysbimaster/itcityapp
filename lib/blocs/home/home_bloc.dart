import 'dart:async';
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
      yield* _mapFetchTodaysDealsByDatetoState(event, state);
    }
    if (event is FetchPopularProduct) {
      yield* _mapFetchPopularProductToState(event, state);
    }
    if (event is FetchFeaturedProduct) {
      yield* _mapFetchFeaturedProductToState(event, state);
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
      HomeEvent event, HomeState state) async* {
    try {
      dealslist = await homeApi.fetchTodaysDealsByDate();

      yield TodaysDealsLoadedState(deals: dealslist);
    } catch (e) {
      print("error in today deals >>>>>>>>>>>>" + e.toString());
      yield TodaysDealsErrorState();
    }
  }

  Stream<HomeState> _mapFetchPopularProductToState(
      HomeEvent event, HomeState state) async* {
    yield PopularProductLoadingState();
    try {
      final List<Product> product = await homeApi.fetchPopularProduct();
      popularProduct = product;
      yield PopularProductLoadedState(popular: popularProduct);
    } catch (e) {
      print('error in popular product  >>>>>>>>>>>>.' + e.toString());
      yield PopularProductErrorState();
    }
  }

  Stream<HomeState> _mapFetchFeaturedProductToState(
      HomeEvent event, HomeState state) async* {
    yield FeaturedProductLoadingState();
    try {
      final List<Product> product = await homeApi.fetchFeaturedProduct();
      featuredProduct = product;
      print(product.length.toString()+ "inside mapfetchfeaturedproductstate");

      yield FeaturedProductLoadedState(featured: featuredProduct);
    } catch (e) {
      print('error in featured product  >>>>>>>>>' + e.toString());
      yield FeaturedProductErrorState();
    }
  }

 
}
