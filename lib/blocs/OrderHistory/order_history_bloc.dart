import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/orderHistoryModel.dart';
import 'package:itcity_online_store/api/services/order_api.dart';
import 'package:meta/meta.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc(this.orderApi) : super(OrderHistoryInitial());

  OrderApi orderApi;
  OrderHistoryModel? orderHistoryModel;
  @override
  Stream<OrderHistoryState> mapEventToState(
    OrderHistoryEvent event,
  ) async* {
    if (event is GetOrderHistory) {
      yield* _mapGetOrderHistoryToState(event, state, event.CustomerID);
    }
  }

  Stream<OrderHistoryState> _mapGetOrderHistoryToState(OrderHistoryEvent event,
      OrderHistoryState state, String? customerID) async* {
    yield OrderHistoryLoading();
    try {
      orderHistoryModel = await orderApi.getOrderHistory(customerID);
      print(orderHistoryModel);
      yield OrderHistoryLoaded();
    } catch (e) {
      print("order trace>>" + e.toString());
      yield OrderHistoryError();
    }
  }
}
