
import 'package:itcity_online_store/api/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/blocs/cart/cart.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartApi cartApi;
  List<Tax> taxes = [];
  Map<String, int> productCount = Map();
  bool? status;
  List<Cart> cartlistUpdated = [];
  List<Cart> cartUpdated = [];
  List<Cart> currentCartList = [];
  String? page;
  CartBloc(this.cartApi) : super(CartInitial()){
    on<FetchTaxDetails>((event, emit) => _mapFetchTaxDetailsToState(event,emit,event.taxPercentage));
    on<AddProductToCart>((event, emit) =>_mapAddProductToCartToState(event,emit,event.cartInfo,event.page));
    on<RemoveAllProductFromCartEvent>((event, emit) => _mapRemoveAllProductFromCartToState(event,emit,event.userid));
    on<RemoveProductFromCartEvent>((event, emit) => _mapRemoveProductFromCartToState(event,emit));
    on<FetchCartDetailsEvent>((event, emit) => _mapFetchCartDetailsToState(event,emit,event.userId));
    on<FetchCartRefreshEvent>((event, emit) =>_mapCartRefreshToState(event,emit,event.userId));
    on<FetchCartAddRefreshEvent>((event, emit) => _mapCartAddRefreshToState(event,emit,event.userId));

  }

  // @override
  // Stream<CartState> mapEventToState(
  //   CartEvent event,
  // ) async* {
  //   CartState? state;
  //   if (event is FetchTaxDetails) {
  //     // yield* _mapFetchTaxDetailsToState(event, state, event.taxPercentage);
  //   }
  //   if (event is AddProductToCart) {
  //    // yield* _mapAddProductToCartToState(event, state, event.cartInfo,event.page);
  //   }
  //   if (event is RemoveAllProductFromCartEvent) {
  //    // yield* _mapRemoveAllProductFromCartToState(event, state, event.userid);
  //   }
  //   if (event is RemoveProductFromCartEvent) {
  //    // yield* _mapRemoveProductFromCartToState(event, state,);
  //   }
  //   if (event is FetchCartDetailsEvent) {
  //     //yield* _mapFetchCartDetailsToState(event, state, event.userId);
  //   }
  //   if (event is FetchCartRefreshEvent) {
  //    // yield* _mapCartRefreshToState(event, state, event.userId);
  //   }
  //   if (event is FetchCartAddRefreshEvent) {
  //   //  yield* _mapCartAddRefreshToState(event, state, event.userId);
  //   }
  // }

void _mapFetchTaxDetailsToState(
      CartEvent event, Emitter<CartState> emit, var taxPercentage) async {
    emit(TaxDetailsLoading());
    try {
      final List<Tax> taxlist = await cartApi.getTaxDetails(taxPercentage);
      taxes = taxlist;
      emit (TaxDetailsLoaded(tax: taxlist));
    } catch (e) {
      print('error ==>' + e.toString());
    }
  }

  // TO DO: post request
 void _mapAddProductToCartToState(
      AddProductToCart event, Emitter<CartState> emit, Cart cartInfo,String page) async {
    emit(AddProductToCartLoadingState());
    try {
      final bool? cartStatus = await cartApi.addProductToCart(cartInfo);
      status = cartStatus;
      //print('add product cartbloc worked' + status.toString());
      this.page = page;
      emit(AddProductToCartSuccessState());
     this.add(FetchCartAddRefreshEvent(cartInfo.userId));

    } catch (e) {
      emit(AddProductToCartErrorState());
    }
  }

  void _mapRemoveAllProductFromCartToState(
      CartEvent event, Emitter<CartState> emit, var userId) async {
    emit(AddProductToCartLoadingState());
    try {

      final List<Cart> cart = await cartApi.removeAllProductFromCart(userId);
      cartUpdated = cart;
      this.productCount = Map();
      emit(AddProductToCartSuccessState());
      this.add(FetchCartAddRefreshEvent(userId));
    } catch (e) {
      print(e);
    }
  }

 void _mapRemoveProductFromCartToState(
      RemoveProductFromCartEvent event, Emitter<CartState> emit) async {
    if(int.parse(event.productCount) == 0){
      emit( RemoveProductFromCartLoadingState());
    }else {
      emit( AddProductToCartLoadingState());
    }


    try {

      var response =
          await cartApi.removeProductFromCart(event.userId, event.cartdata,event.productCount);
      print(response);
      this.productCount.remove(event.productId);
      this.add(FetchCartAddRefreshEvent(event.userId));
    } catch (e) {}
  }

  void _mapFetchCartDetailsToState(
      CartEvent event,Emitter<CartState> emit, var userId) async {
    emit(CartDetailsLoadingState());
    try {

      final List<Cart> cartlist = await cartApi.getCartDetails(userId);
      currentCartList = cartlist;
      setCartCount(currentCartList.length);

      emit(CartDetailsLoadedState(cartlist));
    } catch (e) {
      print(e);
    }
  }
void _mapCartRefreshToState(
      CartEvent event,Emitter<CartState> emit, var userId) async {
    emit(CartRefreshLoadingState());
    try {

      final List<Cart> cartlist = await cartApi.getCartDetails(userId);
      currentCartList = cartlist;
      setCartCount(currentCartList.length);

      emit(CartDetailsLoadedState(cartlist));
    } catch (e) {
      print(e);
    }
  }

void _mapCartAddRefreshToState(
      CartEvent event, Emitter<CartState> emit, var userId) async {
    emit(CartAddRefreshLoadingState());
    try {

      final List<Cart> cartlist = await cartApi.getCartDetails(userId);
      currentCartList = cartlist;
      setCartCount(currentCartList.length);

      emit(CartAddRefreshLoadedState(cartlist));
    } catch (e) {
      print(e);
    }
  }

  void setCartCount(int cartcount) async {
    print(cartcount);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cartcount', cartcount);
  }
}
