part of 'order_history_bloc.dart';

@immutable
abstract class OrderHistoryState {}

class OrderHistoryInitial extends OrderHistoryState {}
class OrderHistoryLoading extends OrderHistoryState {}
class OrderHistoryLoaded extends OrderHistoryState {}
class OrderHistoryError extends OrderHistoryState {}