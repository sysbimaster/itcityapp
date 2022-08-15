import 'dart:async';
import 'package:itcity_online_store/blocs/wishlist/wishlist.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc(this.wishlistApi) : super(WishlistInitial());
  WishlistApi wishlistApi;
  List<CustomerWishlist> customerWishlist = [];
  List<Cart> cartlist = [];
  List<Cart> cartProductlist = [];
  List<Wishlist> wishlists = [];
  List<Wishlist> wish = [];
  List<Wishlist> productWishlist = [];
  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if (event is FetchWishlistEvent) {
      yield* _mapFetchWishlistToState(event, state, event.username,event.currency);
    }
    if (event is MoveProductFromWishlistToCartEvent) {
      yield* _mapMoveProductFromWishlistToCartToState(
          event, state, event.productId);
    }
    if (event is MoveAllProductFromWishlistToCartEvent) {
      yield* _mapMoveAllProductFromWishlistToCartToState(
          event, state, event.wishlistId);
    }
    if (event is RemoveAllProductFromWishlistEvent) {
      yield* _mapRemoveAllProductFromWishlistToState(
          event, state, event.wishlistId);
    }
    if (event is RemoveProductFromWishlistEvent) {
      yield* _mapRemoveProductFromWishlistToState(event, state, event.wishlist,event.currency);
    }
    if (event is AddProductToWishlist) {
      yield* _mapAddProductToWishlistToState(event, state, event.wish);
    }
  }

  Stream<WishlistState> _mapFetchWishlistToState(
      WishlistEvent event, WishlistState state, String username,String currency) async* {
    yield WishlistLoadingState();
    try {
      final List<CustomerWishlist> favourite =
          await wishlistApi.fetchWishlist(username,currency);
      customerWishlist = favourite;

      yield WishlistLoadedState(wishlist: customerWishlist);
    } catch (e) {
      print('error in wishlist=>' + e.toString());
    }
  }

  Stream<WishlistState> _mapMoveProductFromWishlistToCartToState(
      WishlistEvent event, WishlistState state, var productId) async* {
    try {
      final List<Cart> cart =
          await wishlistApi.moveProductFromWishlistToCart(productId);
      cartlist = cart;
    } catch (e) {}
  }

  Stream<WishlistState> _mapMoveAllProductFromWishlistToCartToState(
      WishlistEvent event, WishlistState state, var wishlistId) async* {
    try {
      final List<Cart> cart =
          await wishlistApi.moveAllProductFromWishlistToCart(wishlistId);
      cartProductlist = cart;
    } catch (e) {}
  }

  Stream<WishlistState> _mapRemoveAllProductFromWishlistToState(
      WishlistEvent event, WishlistState state, var wishlistId) async* {
    try {
      final List<Wishlist> wishlist =
          await wishlistApi.removeAllProductFromWishlist(wishlistId);
      wishlists = wishlist;
    } catch (e) {}
  }

  Stream<WishlistState> _mapRemoveProductFromWishlistToState(
      RemoveProductFromWishlistEvent event,
      WishlistState state,
      Wishlist wishlist,String currency) async* {
    yield RemoveProductFromWishlistLoadingState();
    try {
      var removeProductStatus =
          await wishlistApi.removeProductFromWishlist(wishlist);
      print('remove product from wishlist status>>>>>>>' + removeProductStatus);
      this.add(FetchWishlistEvent(event.wishlist.username,currency));
    } catch (e) {
      print('error in removing product from wishlist >>>>>>>>' + e.toString());
    }
  }

  Stream<WishlistState> _mapAddProductToWishlistToState(
      AddProductToWishlist event, WishlistState state, Wishlist wish) async* {
    try {
      final String status = await wishlistApi.addProductToWishlist(wish);
      customerWishlist = [];
      //  this.add(FetchWishlistEvent(event.wish.username));
    } catch (e) {}
  }
}
