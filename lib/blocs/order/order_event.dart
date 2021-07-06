import 'package:itcity_online_store/api/models/models.dart';

abstract class OrderEvent  {}

class CreateOrderEvent extends OrderEvent {
  final Order order;
  CreateOrderEvent(this.order);
}

class FetchOrderStatusEvent extends OrderEvent {
  final String orderStatusId;
  FetchOrderStatusEvent(this.orderStatusId);
}

class CreatePurchaseForOrderEvent extends OrderEvent{
  String userId;
  double subTotal;
  CreatePurchaseForOrderEvent(this.userId,this.subTotal);
}