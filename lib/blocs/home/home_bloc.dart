import 'package:itcity_online_store/blocs/home/home.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeApi homeApi;
  List<HomeImages> image = [];
  List<Brands> brands = [];
  List<DealOfTheDay> dealslist = [];
  List<Product> popularProduct = [];
  List<Product> featuredProduct = [];
  List<Product> mobileColletions = [];
  List<Product> computerCollections = [];
  List<HomeAds> homeadslist = [];

  HomeBloc(this.homeApi) : super(HomeInitial()){
    on<FetchHomeImages>((event, emit) => _mapFetchHomeImagesToState(event,emit));
    on<FetchBrandDetails>((event, emit) => _mapFetchBrandDetailsToState(event,emit));
    on<FetchTodaysDealsByDate>((event, emit) => _mapFetchTodaysDealsByDatetoState(event,emit,event.currency!));
    on<FetchPopularProduct>((event, emit) => _mapFetchPopularProductToState(event,emit,event.currencyp));
    on<FetchFeaturedProduct>((event, emit) => _mapFetchFeaturedProductToState(event,emit,event.currencyf));
    on<FetchMobileCollections>((event, emit) => _mapFetchMobileCollections(event,emit,event.currencym));
    on<FetchComputerCollections>((event, emit) => _mapFetchComputerCollections(event,emit,event.currencyco));
    on<FetchHomeAds>((event, emit) => _mapFetchHomeAdsToState(event,emit));
  }




  void _mapFetchHomeImagesToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeImagesLoadingState());
    try {
      image = await homeApi.fetchHomeimages();
      emit(HomeImagesLoadedState());
      print('emit should work');
    } catch (e) {

      emit(HomeImagesErrorState());
    }
  }
 void _mapFetchHomeAdsToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeAdsLoadingState());
    try {
      final List<HomeAds> homeadslist = await homeApi.fetchHomeAds();
      this.homeadslist = homeadslist;

      emit( HomeAdsLoadedState());
    } catch (e) {

     emit(HomeAdsErrorState());
    }
  }

void _mapFetchBrandDetailsToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(BrandDetailsLoadingState());
    try {
      final List<Brands> brand = await homeApi.fetchBrandDetails();
      brands = brand;
      emit(BrandDetailsLoadedState());
    } catch (e) {
      print('error in brand details >>>>>>>>>>>' + e.toString());
      emit(BrandDetailsErrorState());
    }
  }

void _mapFetchTodaysDealsByDatetoState(
      HomeEvent event, Emitter<HomeState> emit,String currency) async {
    try {
      dealslist = await homeApi.fetchTodaysDealsByDate(currency);


     emit(TodaysDealsLoadedState(deals: dealslist));
    } catch (e) {
      print("error in today deals >>>>>>>>>>>>" + e.toString());
      emit(TodaysDealsErrorState());
    }
  }

  void _mapFetchPopularProductToState(
      HomeEvent event, Emitter<HomeState> emit,String? currency) async {
    emit(PopularProductLoadingState());
    try {
      final List<Product> product = await homeApi.fetchPopularProduct(currency);
      popularProduct = product;
      emit(PopularProductLoadedState(popular: popularProduct));
    } catch (e) {

      emit(PopularProductErrorState());
    }
  }

void _mapFetchFeaturedProductToState(
      HomeEvent event,Emitter<HomeState> emit,String? currency) async {
    emit(FeaturedProductLoadingState());
    try {
      final List<Product> product = await homeApi.fetchFeaturedProduct(currency);
      featuredProduct = product;


      emit(FeaturedProductLoadedState(featured: featuredProduct));
    } catch (e) {

      emit(FeaturedProductErrorState());
    }
  }

 void _mapFetchMobileCollections (HomeEvent event, Emitter<HomeState> emit,String? currency) async{
        emit(MobileCollectionLoadingState());
        try {
          final List<Product> product = await homeApi.fetchMobileCollections(currency);
          mobileColletions = product;
          emit(MobileCollectionLoadedState(mobileCollections: mobileColletions));
        }catch (e){

      emit(MobileCollectionErrorState());
    }

}

 void _mapFetchComputerCollections (HomeEvent event, Emitter<HomeState> emit,String? currency) async{
    emit( ComputerCollectionLoadingState());
    try {
      final List<Product> product = await homeApi.fetchComputerCollections(currency);
     computerCollections = product;

      emit(ComputerCollectionLoadedState(computerCollections: computerCollections));
    }catch (e){
      print('error in ComputerCollection product  >>>>>>>>>' + e.toString());
      emit(ComputerCollectionErrorState());
    }

  }
 
}

