import 'package:category_filter/app/core/domain/failures/failure.dart';
import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/domain/failures/categories_list_failure.dart';
import 'package:category_filter/app/modules/categories_list/domain/repositories/categories_list_repository.dart';
import 'package:category_filter/app/modules/categories_list/infrastructure/datasources/categories_list_datasource.dart';
import 'package:category_filter/app/modules/categories_list/infrastructure/errors/categories_list_datasource_error.dart';
import 'package:dartz/dartz.dart';

class CategoriesListRepositoryImplementation implements CategoriesListRepository {
  final CategoriesListDatasource datasource;

  CategoriesListRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<Category>>> call() async {
    try {
      return Right(await datasource());
    } on CategoriesListDatasourceError catch (e) {
      return Left(CategoriesListFailure(e.message));
    } on Exception {
      return Left(CategoriesListFailure('Ocorreu um erro.'));
    }
  }
}
