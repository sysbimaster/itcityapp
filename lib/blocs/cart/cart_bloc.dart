import 'dart:async';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/blocs/cart/cart.dart';
import 'package:itcity_online_store/api/services/services.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.cartApi) : super(CartInitial());
  final CartApi cartApi;
  List<Tax> taxes = [];
  Map<String, int> productCount = Map();
  bool status;
  List<Cart> cartlistUpdated = [];
  List<Cart> cartUpdated = [];
  List<Cart> currentCartList = [];
  String page;
  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    CartState state;
    if (event is FetchTaxDetails) {
      yield* _mapFetchTaxDetailsToState(event, state, event.taxPercentage);
    }
    if (event is AddProductToCart) {
      yield* _mapAddProductToCartToState(event, state, event.cartInfo,event.page);
    }
    if (event is RemoveAllProductFromCartEvent) {
      yield* _mapRemoveAllProductFromCartToState(event, state, event.userid);
    }
    if (event is RemoveProductFromCartEvent) {
      yield* _mapRemoveProductFromCartToState(event, state,);
    }
    if (event is FetchCartDetailsEvent) {
      yield* _mapFetchCartDetailsToState(event, state, event.userId);
    }
    if (event is FetchCartRefreshEvent) {
      yield* _mapCartRefreshToState(event, state, event.userId);
    }
  }

  Stream<CartState> _mapFetchTaxDetailsToState(
      CartEvent event, CartState state, var taxPercentage) async* {
    yield TaxDetailsLoading();
    try {
      final List<Tax> taxlist = await cartApi.getTaxDetails(taxPercentage);
      taxes = taxlist;
      yield TaxDetailsLoaded(tax: taxlist);
    } catch (e) {
      print('error ==>' + e);
    }
  }

  // TO DO: post request
  Stream<CartState> _mapAddProductToCartToState(
      AddProductToCart event, CartState state, Cart cartInfo,String page) async* {
    yield AddProductToCartLoadingState();
    try {
      final bool cartStatus = await cartApi.addProductToCart(cartInfo);
      status = cartStatus;
      print('add product cartbloc worked' + status.toString());
      this.page = page;
      yield AddProductToCartSuccessState();
      this.add(FetchCartRefreshEvent(cartInfo.userId));

    } catch (e) {
      yield AddProductToCartErrorState();
    }
  }

  Stream<CartState> _mapRemoveAllProductFromCartToState(
      CartEvent event, CartState state, var userId) async* {
    yield AddProductToCartLoadingState();
    try {
      print("Removing all Cart Items"+userId);
      final List<Cart> cart = await cartApi.removeAllProductFromCart(userId);
      cartUpdated = cart;
      this.productCount = Map();
      yield AddProductToCartSuccessState();
       this.add(FetchCartRefreshEvent(userId));
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapRemoveProductFromCartToState(
      RemoveProductFromCartEvent event, CartState state) async* {

    yield AddProductToCartLoadingState();
    try {
      print("Removing one Cart Items"+event.userId);
      var response =
          await cartApi.removeProductFromCart(event.userId, event.cartdata,event.productCount);
      print(response);
      this.productCount.remove(event.productId);
      this.add(FetchCartRefreshEvent(event.userId));
    } catch (e) {}
  }

  Stream<CartState> _mapFetchCartDetailsToState(
      CartEvent event, CartState state, var userId) async* {
    yield CartDetailsLoadingState();
    try {
      print("Inside CartBloc method userid is" + userId);
      final List<Cart> cartlist = await cartApi.getCartDetails(userId);
      currentCartList = cartlist;
      print("Inside CartBloc method and cart count is " +
          cartlist.length.toString());
      // cartlist.forEach((element) {
      //   print(element.cartData.toString() + ">>>>>>>>>>>>>>>>>>");
      //   this.productCount[element.productId] = element.productCount;
      // });
      yield CartDetailsLoadedState(cartlist);
    } catch (e) {
      print(e);
    }
  }
  Stream<CartState> _mapCartRefreshToState(
      CartEvent event, CartState state, var userId) async* {
    yield CartRefreshLoadingState();
    try {
      print("Inside CartBloc method userid is" + userId);
      final List<Cart> cartlist = await cartApi.getCartDetails(userId);
      currentCartList = cartlist;
      print("Inside CartBloc method and cart count is " +
          cartlist.length.toString());
      // cartlist.forEach((element) {
      //   print(element.cartData.toString() + ">>>>>>>>>>>>>>>>>>");
      //   this.productCount[element.productId] = element.productCount;
      // });
      yield CartDetailsLoadedState(cartlist);
    } catch (e) {
      print(e);
    }
  }
}
