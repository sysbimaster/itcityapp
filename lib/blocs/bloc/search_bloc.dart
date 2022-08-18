import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:itcity_online_store/api/models/product.dart';
import 'package:itcity_online_store/api/services/product_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
    final ProductApi productApi;

  SearchBloc(this.productApi) : super(SearchInitial()){
    on<SearchTermEvent>((event, emit) => search(event,emit));
  }

  // @override
  // Stream<SearchState> mapEventToState(
  //   SearchEvent event,
  // ) async* {
  //   if(event is SearchTermEvent) {
  //     yield* this.search(event);
  //   } else if(event is SearchReset) {
  //     yield SearchInitial();
  //   }
  // }

void search(SearchTermEvent event,Emitter<SearchState> emit) async {
      emit(SearchLoadingState());
    try {
      List<Product> product = await (productApi.search(event.term,event.currency) as FutureOr<List<Product>>);
      emit (SearchSuccessState(product));
    } catch (e) {
      print("error in fetching all product>>>>>>>" + e.toString());
    }
  }
}
