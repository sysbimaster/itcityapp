import 'package:itcity_online_store/api/models/models.dart';
import 'package:meta/meta.dart';

abstract class CategoryState{}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<Category> category;
  CategoryLoadedState({@required this.category})
      : assert(category != null);
}
class CategoryErrorState extends CategoryState {}
