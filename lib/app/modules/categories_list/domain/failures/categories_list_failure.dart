import 'package:category_filter/app/modules/categories_list/domain/failures/categories_list_failures.dart';

class CategoriesListFailure implements CategoriesListFailures {
  final String message;

  CategoriesListFailure(this.message);
}
