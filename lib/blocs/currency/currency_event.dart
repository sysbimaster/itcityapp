part of  'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
  @override
  List<Object> get props => [];
}

class CurrencyInitialEvent extends CurrencyEvent{

}
class CurrencyDefaultEvent extends CurrencyEvent{}
class CurrencyChangeEvent extends CurrencyEvent{
  String firstCurrencyType;
  String ChangeCurrencyType;
  var price;
  CurrencyChangeEvent(this.firstCurrencyType,this.ChangeCurrencyType,var this.price);
}