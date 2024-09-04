import 'package:category_filter/app/modules/categories_list/domain/failures/categories_list_failure.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_states.dart';

class CategoriesListFailureState implements CategoriesListStates {
  final CategoriesListFailure failure;

  CategoriesListFailureState(this.failure);
}
