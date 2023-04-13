import 'package:itcity_online_store/api/models/models.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class TaxDetailsLoading extends CartState {}

class TaxDetailsLoaded extends CartState {
  final List<Tax> tax;
  TaxDetailsLoaded({required this.tax});
}

class TaxDetailsErrorState extends CartState {}

class AddProductToCartLoadingState extends CartState {}

class AddProductToCartSuccessState extends CartState {}

class AddProductToCartErrorState extends CartState {}

class RemoveAllProductFromCartLoadingState extends CartState {}

class RemoveAllProductFromCartSuccessState extends CartState {}

class RemoveAllProductFromCartErrorState extends CartState {}

class RemoveProductFromCartLoadingState extends CartState {}

class RemoveProductFromCartSuccessState extends CartState {}

class RemoveProductFromCartErrorState extends CartState {}

class CartDetailsLoadingState extends CartState {}
class CartRefreshLoadingState extends CartState {}
class CartDetailsLoadedState extends CartState {
  List<Cart> cartItems;
  CartDetailsLoadedState(this.cartItems);
}

class CartDetailsErrorState extends CartState {}

class CartAddRefreshLoadingState extends CartState {}
class CartAddRefreshLoadedState extends CartState {
  List<Cart> cartItems;
  CartAddRefreshLoadedState(this.cartItems);
}
class CartAddRefreshErrorState extends CartState {}
