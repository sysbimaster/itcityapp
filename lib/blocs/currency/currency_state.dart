part of 'currency_bloc.dart';


abstract class CurrencyState extends Equatable {
  const CurrencyState();
  @override
  List<Object> get props => [];
}

class CurrencyInitial extends CurrencyState{

}
class CurrencyLoading extends CurrencyState{}

class CurrencyChanged extends CurrencyState{
  var price ;
  String? CurrencyType;
  CurrencyChanged({required this.price, this.CurrencyType });
}
class CurrencyChangedErrorState extends CurrencyState{}

