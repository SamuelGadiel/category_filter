import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/domain/failures/categories_list_failure.dart';
import 'package:category_filter/app/modules/categories_list/infrastructure/datasources/categories_list_datasource.dart';
import 'package:category_filter/app/modules/categories_list/infrastructure/errors/categories_list_datasource_error.dart';
import 'package:category_filter/app/modules/categories_list/infrastructure/repositories/categories_list_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CategoriesListDatasourceMock extends Mock implements CategoriesListDatasource {}

class CategoriesListFake extends Fake implements List<Category> {}

void main() {
  final datasource = CategoriesListDatasourceMock();
  final repository = CategoriesListRepositoryImplementation(datasource);

  test('Must return a List<Category> entity on success', () async {
    when(() => datasource()).thenAnswer((invocation) async => CategoriesListFake());

    final result = await repository();

    expect(result.fold(id, id), isA<CategoriesListFake>());
  });

  test('Must return a CategoriesListFailure on CategoriesListDatasourceError error', () async {
    when(() => datasource()).thenThrow(CategoriesListDatasourceError('CategoriesListDatasourceError'));

    final result = await repository();

    expect(result.fold(id, id), isA<CategoriesListFailure>());
    expect((result.fold(id, id) as CategoriesListFailure).message, 'CategoriesListDatasourceError');
  });

  test('Must return a CategoriesListFailure on Exception', () async {
    when(() => datasource()).thenThrow(Exception());

    final result = await repository();

    expect(result.fold(id, id), isA<CategoriesListFailure>());
    expect((result.fold(id, id) as CategoriesListFailure).message, 'Ocorreu um erro.');
  });
}
