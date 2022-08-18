import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/order_details.dart';
import 'package:itcity_online_store/api/models/order_status_new.dart';
import 'package:itcity_online_store/api/models/product_order_details.dart';
import 'package:itcity_online_store/blocs/order/order.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:itcity_online_store/api/models/models.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderApi orderApi;
  OrderStatusNew? orderStatusNew;
  OrderDetails? orderDetails;
  ProductOrderDetails? productOrderDetails;

  OrderBloc(this.orderApi) : super(OrderInitial()){
    on<CreateOrderEvent>((event, emit) => _mapCreateOrderToState(event,emit,event.order));
    on<FetchOrderStatusEvent>((event, emit) => _mapFetchOrderStatusToState(event,emit,event.orderStatusId));
    on<CreatePurchaseForOrderEvent>((event, emit) => _mapCreatePurchaseForOrderToState(event,emit,event.userId,event.subTotal,event.currency));
    on<GetOrderDetailsEvent>((event, emit) => _mapCreateOrderDetailsToState(event,emit,event.orderId));
  }


  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    // if (event is CreateOrderEvent) {
    //   yield* _mapCreateOrderToState(event, state, event.order);
    // }
    // if (event is FetchOrderStatusEvent) {
    //   yield* _mapFetchOrderStatusToState(event, state, event.orderStatusId);
    // }
    // if (event is CreatePurchaseForOrderEvent) {
    //   yield* _mapCreatePurchaseForOrderToState(event, state,event.userId,event.subTotal,event.currency);
    // }
    // if(event is GetOrderDetailsEvent){
    //   yield* _mapCreateOrderDetailsToState(event,state,event.orderId);
    // }
  }
void _mapCreateOrderDetailsToState(
      OrderEvent event, Emitter<OrderState> emit, int? orderId) async {
    emit(GetOrderDetailsLoadingState());
    try {
      orderDetails = await orderApi.getPurchaseDetailsByOrderId(orderId);
      productOrderDetails = await orderApi.getPurchaseProductDetailsByOrderId(orderId);



      emit(GetOrderDetailsLoadedState(orderDetails));
    } catch (e) {

      GetOrderDetailsErrorState();
    }
  }
void _mapCreateOrderToState(
      OrderEvent event, Emitter<OrderState> emit, Order order) async {
    emit(CreateOrderLoadingState());
    try {
      orderStatusNew = await orderApi.createOrder(order);



     emit(CreateOrderSuccessState(this.orderStatusNew));
    } catch (e) {
      emit(CreateOrderErrorState());
      print(e.toString());
    }
  }

  void _mapFetchOrderStatusToState(
      OrderEvent event,Emitter<OrderState> emit, var orderStatusId) async {
    try {} catch (e) {}
  }

void _mapCreatePurchaseForOrderToState(
      OrderEvent event, Emitter<OrderState> emit,String? userId  , double subTotal,String? currency) async {
    try {
      //  final bool cartStatus = await cartApi.addProductToCart(cartInfo);
      var json = await this.orderApi.createPurchase(userId,subTotal,currency);
      Purchase purchase = Purchase.fromJson(json);
      emit( CreatePurchaseSuccessState(purchase));
    } catch (e) {

    }
  }
}
