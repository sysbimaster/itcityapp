import 'package:itcity_online_store/api/models/models.dart';

abstract class CartEvent {}

class FetchTaxDetails extends CartEvent {
 final String taxPercentage;
  FetchTaxDetails(this.taxPercentage);
}

class AddProductToCart extends CartEvent {
 final  Cart cartInfo;
 String page;
  AddProductToCart(this.cartInfo,this.page);
}

class RemoveAllProductFromCartEvent extends CartEvent {
  final String? userid;
  RemoveAllProductFromCartEvent(this.userid);
}

class RemoveProductFromCartEvent extends CartEvent {
  final String? cartdata;
  final String? userId;
  final String? productId;
  final String productCount;
  RemoveProductFromCartEvent(this.cartdata,this.userId,this.productId,this.productCount);
}

class FetchCartDetailsEvent extends CartEvent {
  final String? userId;
  FetchCartDetailsEvent(this.userId);
}
class FetchCartRefreshEvent extends CartEvent {
  final String userId;
  FetchCartRefreshEvent(this.userId);
}

class FetchCartAddRefreshEvent extends CartEvent {
  final String? userId;
  FetchCartAddRefreshEvent(this.userId);
}
