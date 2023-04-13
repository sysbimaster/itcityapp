import 'package:itcity_online_store/blocs/wishlist/wishlist.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/services/services.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {

  WishlistApi wishlistApi;
  List<CustomerWishlist> customerWishlist = [];
  List<Cart> cartlist = [];
  List<Cart> cartProductlist = [];
  List<Wishlist> wishlists = [];
  List<Wishlist> wish = [];
  List<Wishlist> productWishlist = [];

  WishlistBloc(this.wishlistApi) : super(WishlistInitial()){
    on<FetchWishlistEvent>((event, emit) => _mapFetchWishlistToState(event,emit, event.username,event.currency));
    on<MoveProductFromWishlistToCartEvent>((event, emit) => _mapMoveProductFromWishlistToCartToState(event, emit, event.productId));
    on<MoveAllProductFromWishlistToCartEvent>((event, emit) => _mapMoveAllProductFromWishlistToCartToState(event, emit, event.wishlistId));
    on<RemoveAllProductFromWishlistEvent>((event, emit) => _mapRemoveAllProductFromWishlistToState(event, emit, event.wishlistId));
    on<RemoveProductFromWishlistEvent>((event, emit) => _mapRemoveProductFromWishlistToState(event, emit, event.wishlist,event.currency));
    on<AddProductToWishlist>((event, emit) =>_mapAddProductToWishlistToState(event, emit, event.wish));
  }

  // @override
  // Stream<WishlistState> mapEventToState(
  //   WishlistEvent event,
  // ) async* {
  //   if (event is FetchWishlistEvent) {
  //     yield* _mapFetchWishlistToState(event, state, event.username,event.currency);
  //   }
  //   if (event is MoveProductFromWishlistToCartEvent) {
  //     yield* _mapMoveProductFromWishlistToCartToState(
  //         event, state, event.productId);
  //   }
  //   if (event is MoveAllProductFromWishlistToCartEvent) {
  //     yield* _mapMoveAllProductFromWishlistToCartToState(
  //         event, state, event.wishlistId);
  //   }
  //   if (event is RemoveAllProductFromWishlistEvent) {
  //     yield* _mapRemoveAllProductFromWishlistToState(
  //         event, state, event.wishlistId);
  //   }
  //   if (event is RemoveProductFromWishlistEvent) {
  //     yield* _mapRemoveProductFromWishlistToState(event, state, event.wishlist,event.currency);
  //   }
  //   if (event is AddProductToWishlist) {
  //     yield* _mapAddProductToWishlistToState(event, state, event.wish);
  //   }
  // }

void _mapFetchWishlistToState(
      WishlistEvent event, Emitter<WishlistState> emit, String? username,String? currency) async {
    emit(WishlistLoadingState());
    try {
      final List<CustomerWishlist> favourite =
          await wishlistApi.fetchWishlist(username,currency);
      customerWishlist = favourite;

      emit(WishlistLoadedState(wishlist: customerWishlist));
    } catch (e) {
      print('error in wishlist=>' + e.toString());
    }
  }

void _mapMoveProductFromWishlistToCartToState(
      WishlistEvent event, Emitter<WishlistState> emit, var productId) async {
    try {
      final List<Cart> cart =
          await wishlistApi.moveProductFromWishlistToCart(productId);
      cartlist = cart;
    } catch (e) {}
  }

void _mapMoveAllProductFromWishlistToCartToState(
      WishlistEvent event, Emitter<WishlistState> emit, var wishlistId) async {
    try {
      final List<Cart> cart =
          await wishlistApi.moveAllProductFromWishlistToCart(wishlistId);
      cartProductlist = cart;
    } catch (e) {}
  }

void _mapRemoveAllProductFromWishlistToState(
      WishlistEvent event, Emitter<WishlistState> emit, var wishlistId) async {
    try {
      final List<Wishlist> wishlist =
          await wishlistApi.removeAllProductFromWishlist(wishlistId);
      wishlists = wishlist;
    } catch (e) {}
  }

void _mapRemoveProductFromWishlistToState(
      RemoveProductFromWishlistEvent event,
    Emitter<WishlistState> emit,
      Wishlist wishlist,String? currency) async {
    emit(RemoveProductFromWishlistLoadingState());
    try {
      var removeProductStatus =
          await wishlistApi.removeProductFromWishlist(wishlist);
      print('remove product from wishlist status>>>>>>>' + removeProductStatus);
      this.add(FetchWishlistEvent(event.wishlist.username,currency));
    } catch (e) {
      print('error in removing product from wishlist >>>>>>>>' + e.toString());
    }
  }

 void _mapAddProductToWishlistToState(
      AddProductToWishlist event, Emitter<WishlistState> emit, Wishlist wish) async {
    try {
      final String status = await wishlistApi.addProductToWishlist(wish);
      customerWishlist = [];
      //  this.add(FetchWishlistEvent(event.wish.username));
    } catch (e) {}
  }
}
