import 'package:equatable/equatable.dart';
import 'package:itcity_online_store/api/models/models.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedState extends WishlistState {
  final List<CustomerWishlist> wishlist;
  const WishlistLoadedState({required this.wishlist});
}

class WishlistErrorState extends WishlistState {}

class MoveProductFromWishlistToCartLoadingState extends WishlistState {}

class MoveProductFromWishlistToCartSuccessState extends WishlistState {
  final List<Cart> cartlist;
  const MoveProductFromWishlistToCartSuccessState({required this.cartlist});
}

class MoveProductFromWishlistToCartErrorState extends WishlistState {}

class MoveAllProductFromWishlistToCartLoadingState extends WishlistState {}

class MoveAllProductFromWishlistToCartSuccessState extends WishlistState {
  final List<Cart> cart;
  const MoveAllProductFromWishlistToCartSuccessState({required this.cart});
}

class MoveAllProductFromWishlistToCartErrorState extends WishlistState {}

class RemoveAllProductFromWishlistLoadingState extends WishlistState {}

class RemoveAllProductFromWishlistSuccessState extends WishlistState {}

class RemoveAllProductFromWishlistErrorState extends WishlistState {}

class RemoveProductFromWishlistLoadingState extends WishlistState {}

class RemoveProductFromWishlistSuccessState extends WishlistState {}

class RemoveProductFromWishlistErrorState extends WishlistState {}

class AddProductToWishlistLoadingState extends WishlistErrorState {}

class AddProductToWishlistSuccessState extends WishlistErrorState {}

class AddProductToWishlistErrorState extends WishlistErrorState {}
