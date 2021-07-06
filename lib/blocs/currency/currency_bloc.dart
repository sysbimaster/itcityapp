import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent,CurrencyState>{
  CurrencyBloc(CurrencyState initialState) : super(CurrencyInitial());

  @override
  Stream<CurrencyState> mapEventToState(CurrencyEvent event) async* {
    if (event is CurrencyInitialEvent){
      yield CurrencyInitial();
    }else  if (event is CurrencyChangeEvent){
    yield* this.changeCurrency(event);
  }
  }

 Stream<CurrencyState> changeCurrency(CurrencyChangeEvent event) async* {
    yield CurrencyLoading();
    try {

    }catch (e) {

    }

 }


}