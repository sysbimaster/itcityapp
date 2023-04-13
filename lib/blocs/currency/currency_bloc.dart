import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:itcity_online_store/api/models/Currency.dart';
import 'package:itcity_online_store/api/services/currency_api.dart';


part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent,CurrencyState>{
  final CurrencyApi currencyApi;
  var ChangedPrice;

  CurrencyBloc({required this.currencyApi})
      :super(CurrencyInitial()){
    on<CurrencyInitialEvent>((event, emit) =>mapEventToState(event, emit));
    on<CurrencyChangeEvent>((event, emit) => _mapFetchCurrencyChangeEventToState(event,emit,event.firstCurrencyType,event.ChangeCurrencyType,event.price));

  }



  void mapEventToState(CurrencyEvent event,Emitter<CurrencyState> emit) async {
    emit(CurrencyInitial());

  }

void _mapFetchCurrencyChangeEventToState(
       CurrencyEvent event,Emitter<CurrencyState> emit,String firstcurrency,String currencyToChange, var price) async {
    emit(CurrencyLoading());
    try {
     final Currency currency = await currencyApi.getChangedCurrency(firstcurrency, currencyToChange, price);

     this.ChangedPrice = currency.result;
      emit(CurrencyChanged(price: currency.result));
    } catch (e) {

      emit(CurrencyChangedErrorState());
    }
  }

}