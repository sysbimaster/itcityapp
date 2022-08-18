part of 'order_history_bloc.dart';

@immutable
abstract class OrderHistoryEvent {


}
class GetOrderHistory extends OrderHistoryEvent {
String? CustomerID;

GetOrderHistory(this.CustomerID);

}