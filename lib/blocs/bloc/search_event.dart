part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


class SearchTermEvent extends SearchEvent {
  String term;
  SearchTermEvent(this.term);
}

class SearchReset extends SearchEvent {
  
}