import 'package:category_filter/app/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'categories_list/domain/usecases/get_categories_list.dart';
import 'categories_list/external/datasources/categories_list_datasource_implementation.dart';
import 'categories_list/infrastructure/repositories/categories_list_repository_implementation.dart';
import 'categories_list/presentation/blocs/categories_list_bloc/categories_list_bloc.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetCategoriesListImplementation(i())),
    Bind((i) => CategoriesListRepositoryImplementation(i())),
    Bind((i) => CategoriesListDatasourceImplementation()),
    Bind((i) => CategoriesListBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => HomePage()),
  ];
}
