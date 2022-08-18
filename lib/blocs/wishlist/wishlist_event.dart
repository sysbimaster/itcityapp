import 'package:itcity_online_store/api/models/models.dart';

abstract class WishlistEvent {}

class FetchWishlistEvent extends WishlistEvent {
  final String? username;
  String? currency;
  FetchWishlistEvent(this.username,this.currency);
}

class MoveProductFromWishlistToCartEvent extends WishlistEvent {
  final String productId;
  MoveProductFromWishlistToCartEvent(this.productId);
}

class MoveAllProductFromWishlistToCartEvent extends WishlistEvent {
  final String wishlistId;
  MoveAllProductFromWishlistToCartEvent(this.wishlistId);
}

class RemoveAllProductFromWishlistEvent extends WishlistEvent {
  final String wishlistId;
  RemoveAllProductFromWishlistEvent(this.wishlistId);
}

class RemoveProductFromWishlistEvent extends WishlistEvent {
  final Wishlist wishlist;
  String? currency;
  RemoveProductFromWishlistEvent(this.wishlist,this.currency);
}

class AddProductToWishlist extends WishlistEvent {
  final Wishlist wish;
  AddProductToWishlist(this.wish);
}
