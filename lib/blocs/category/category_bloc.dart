import 'package:itcity_online_store/blocs/category/category.dart';
import 'package:itcity_online_store/api/services/services.dart';
import 'package:itcity_online_store/api/models/models.dart';
import 'package:bloc/bloc.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductApi productApi;
  CategoryBloc({required this.productApi})
      : super(CategoryInitialState()){
    on<FetchCategory>((event, emit) => mapEventToState(event,emit));
  }
  List<Category>? categoryList;
  @override
 void mapEventToState(CategoryEvent event,Emitter<CategoryState> emit) async {
    if (event is FetchCategory) {
      emit(CategoryLoadingState());
      try {
        final List<Category> category = await productApi.getCategory();
        categoryList = category;
        emit(CategoryLoadedState(category: category));
      } catch (e) {

        print(e);
      }
    }
  }
}
