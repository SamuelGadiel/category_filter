import 'package:category_filter/app/core/domain/failures/failure.dart';

import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/domain/repositories/categories_list_repository.dart';
import 'package:dartz/dartz.dart';

abstract class GetCategoriesList {
  Future<Either<Failure, List<Category>>> call();
}

class GetCategoriesListImplementation implements GetCategoriesList {
  final CategoriesListRepository repository;

  GetCategoriesListImplementation(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call() async {
    return await repository();
  }
}
