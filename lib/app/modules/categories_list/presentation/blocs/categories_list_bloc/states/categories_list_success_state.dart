import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_states.dart';

class CategoriesListSuccessState implements CategoriesListStates {
  final List<Category> categories;

  CategoriesListSuccessState(this.categories);
}
