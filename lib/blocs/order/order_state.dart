import 'package:itcity_online_store/api/models/models.dart';
import 'package:itcity_online_store/api/models/purchase.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class CreateOrderLoadingState extends OrderState {}

class CreateOrderSuccessState extends OrderState {
  OrderStatus orderStatus;
  CreateOrderSuccessState (this.orderStatus);
}

class CreateOrderErrorState extends OrderState {}

class CreatePurchaseLoadingState extends OrderState {}

class CreatePurchaseSuccessState extends OrderState {
  Purchase purchase;
  CreatePurchaseSuccessState(this.purchase);
}

class CreatePurchaseErrorState extends OrderState {}
