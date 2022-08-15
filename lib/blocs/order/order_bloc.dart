import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/order_details.dart';
import 'package:itcity_online_store/api/models/order_status_new.dart';
import 'package:itcity_online_store/api/models/product_order_details.dart';
import 'package:itcity_online_store/blocs/order/order.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:itcity_online_store/api/models/models.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this.orderApi) : super(OrderInitial());
  OrderApi orderApi;
  OrderStatusNew orderStatusNew;
  OrderDetails orderDetails;
  ProductOrderDetails productOrderDetails;

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
      yield* _mapCreatePurchaseForOrderToState(event, state,event.userId,event.subTotal,event.currency);
    }
    if(event is GetOrderDetailsEvent){
      yield* _mapCreateOrderDetailsToState(event,state,event.orderId);
    }
  }
  Stream<OrderState> _mapCreateOrderDetailsToState(
      OrderEvent event, OrderState state, int orderId) async* {
    yield GetOrderDetailsLoadingState();
    try {
      orderDetails = await orderApi.getPurchaseDetailsByOrderId(orderId);
      productOrderDetails = await orderApi.getPurchaseProductDetailsByOrderId(orderId);


      if(orderDetails!=null){
        print("data>>>"+productOrderDetails.data.length.toString());
        print(orderDetails.data[0].products);
      }
      yield GetOrderDetailsLoadedState(orderDetails);
    } catch (e) {
      print("order trace>>"+e.toString());
      GetOrderDetailsErrorState();
    }
  }
  Stream<OrderState> _mapCreateOrderToState(
      OrderEvent event, OrderState state, Order order) async* {
    yield CreateOrderLoadingState();
    try {
      orderStatusNew = await orderApi.createOrder(order);

      if(orderStatusNew!=null){
        print(orderStatusNew.customerEmail);
      }

      yield CreateOrderSuccessState(this.orderStatusNew);
    } catch (e) {
      yield CreateOrderErrorState();
      print(e.toString());
    }
  }

  Stream<OrderState> _mapFetchOrderStatusToState(
      OrderEvent event, OrderState state, var orderStatusId) async* {
    try {} catch (e) {}
  }

  Stream<OrderState> _mapCreatePurchaseForOrderToState(
      OrderEvent event, OrderState state,String userId  , double subTotal,String currency) async* {
    try {
      //  final bool cartStatus = await cartApi.addProductToCart(cartInfo);
      var json = await this.orderApi.createPurchase(userId,subTotal,currency);
      Purchase purchase = Purchase.fromJson(json);
      yield CreatePurchaseSuccessState(purchase);
    } catch (e) {

    }
  }
}
