import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/blocs/order/order.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:itcity_online_store/api/models/models.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this.orderApi) : super(OrderInitial());
  OrderApi orderApi;
  OrderStatus orderStatus;

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is CreateOrderEvent) {
      yield* _mapCreateOrderToState(event, state, event.order);
    }
    if (event is FetchOrderStatusEvent) {
      yield* _mapFetchOrderStatusToState(event, state, event.orderStatusId);
    }
    if (event is CreatePurchaseForOrderEvent) {
      yield* _mapCreatePurchaseForOrderToState(event, state,event.userId,event.subTotal);
    }
  }

  Stream<OrderState> _mapCreateOrderToState(
      OrderEvent event, OrderState state, Order order) async* {
    try {
      OrderStatus status = await orderApi.createOrder(order);
      orderStatus = status;
      if(orderStatus!=null){
        print(orderStatus.data);
      }

      yield CreateOrderSuccessState(this.orderStatus);
    } catch (e) {}
  }

  Stream<OrderState> _mapFetchOrderStatusToState(
      OrderEvent event, OrderState state, var orderStatusId) async* {
    try {} catch (e) {}
  }

  Stream<OrderState> _mapCreatePurchaseForOrderToState(
      OrderEvent event, OrderState state,String userId  , double subTotal) async* {
    try {
      //  final bool cartStatus = await cartApi.addProductToCart(cartInfo);
      var json = await this.orderApi.createPurchase(userId,subTotal);
      Purchase purchase = Purchase.fromJson(json);
      yield CreatePurchaseSuccessState(purchase);
    } catch (e) {
      
    }
  }
}
