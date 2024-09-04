import 'package:category_filter/app/modules/categories_list/infrastructure/errors/categories_list_datasource_errors.dart';

class CategoriesListDatasourceError implements CategoriesListDatasourceErrors {
  final String message;

  CategoriesListDatasourceError(this.message);
}
