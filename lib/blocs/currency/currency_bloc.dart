import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:itcity_online_store/api/models/Currency.dart';
import 'package:itcity_online_store/api/services/currency_api.dart';
import 'package:meta/meta.dart';


part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent,CurrencyState>{
  final CurrencyApi currencyApi;
  var ChangedPrice;

  CurrencyBloc({this.currencyApi})
      : assert(currencyApi != null),
        super(null);


  @override
  Stream<CurrencyState> mapEventToState(CurrencyEvent event) async* {
    if (event is CurrencyInitialEvent){
      yield CurrencyInitial();
    }else  if (event is CurrencyChangeEvent){
    yield* _mapFetchCurrencyChangeEventToState(state, event, event.firstCurrencyType, event.ChangeCurrencyType, event.price);
  }
  }

  Stream<CurrencyState> _mapFetchCurrencyChangeEventToState(
      CurrencyState state, CurrencyEvent event,String firstcurrency,String currencyToChange, var price) async* {
    yield CurrencyLoading();
    try {
     final Currency currency = await currencyApi.getChangedCurrency(firstcurrency, currencyToChange, price);
     print('inside currency bloc'+ firstcurrency+currencyToChange);
     print("changed currency value  "+ currency.result.toString());
     this.ChangedPrice = currency.result;
      yield CurrencyChanged(price: currency.result);
    } catch (e) {
      print("error in loading product>>>>>>>>>>>" + e.toString());
      yield CurrencyChangedErrorState();
    }
  }

}