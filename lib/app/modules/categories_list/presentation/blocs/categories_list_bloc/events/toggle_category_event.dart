import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/events/categories_list_events.dart';

class ToggleCategoryEvent implements CategoriesListEvents {
  final Category category;
  final bool value;

  ToggleCategoryEvent(this.category, this.value);
}
