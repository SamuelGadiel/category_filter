import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/infrastructure/datasources/categories_list_datasource.dart';
import 'package:category_filter/app/modules/categories_list/infrastructure/models/category_model.dart';

import 'package:category_filter/server_response.dart';

class CategoriesListDatasourceImplementation implements CategoriesListDatasource {
  @override
  Future<List<Category>> call() async {
    return ((serverResponse ?? []) as List).map((e) => CategoryModel.fromJson(e)).toList();
  }
}
