import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';

abstract class CategoriesListDatasource {
  Future<List<Category>> call();
}
