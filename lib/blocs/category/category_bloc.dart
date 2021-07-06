import 'package:itcity_online_store/blocs/category/category.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductApi productApi;
  CategoryBloc({this.productApi})
      : assert(productApi != null),
        super(null);
  List<Category> categoryList;
  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategory) {
      yield CategoryLoadingState();
      try {
        final List<Category> category = await productApi.getCategory();
        categoryList = category;
        yield CategoryLoadedState(category: category);
      } catch (e) {
        print('error in fetching category>>>>>>>>>>>' + e.toString());
        print(e);
      }
    }
  }
}
