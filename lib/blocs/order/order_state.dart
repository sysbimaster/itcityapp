import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/models/order_details.dart';
import 'package:itcity_online_store/api/models/order_status_new.dart';
import 'package:itcity_online_store/api/models/purchase.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class CreateOrderLoadingState extends OrderState {}

class CreateOrderSuccessState extends OrderState {
  OrderStatusNew? orderStatusNew;
  CreateOrderSuccessState (this.orderStatusNew);
}

class CreateOrderErrorState extends OrderState {}

class CreatePurchaseLoadingState extends OrderState {}

class CreatePurchaseSuccessState extends OrderState {
  Purchase purchase;
  CreatePurchaseSuccessState(this.purchase);
}

class CreatePurchaseErrorState extends OrderState {}
class GetOrderDetailsLoadingState extends OrderState{}
class GetOrderDetailsLoadedState extends OrderState{
  OrderDetails? orderDetails;
  GetOrderDetailsLoadedState(this.orderDetails);
}
class GetOrderDetailsErrorState extends OrderState{}
