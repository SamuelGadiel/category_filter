import 'package:category_filter/app/core/domain/failures/failure.dart';

import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesListRepository {
  Future<Either<Failure, List<Category>>> call();
}
