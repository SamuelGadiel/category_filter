import 'package:category_filter/app/core/domain/failures/failure.dart';

abstract class CategoriesListFailures implements Failure {
  final String message;

  CategoriesListFailures(this.message);
}
