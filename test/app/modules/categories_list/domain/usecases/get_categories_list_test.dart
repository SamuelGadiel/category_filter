import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/domain/failures/categories_list_failure.dart';
import 'package:category_filter/app/modules/categories_list/domain/repositories/categories_list_repository.dart';
import 'package:category_filter/app/modules/categories_list/domain/usecases/get_categories_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CategoriesListRepositoryMock extends Mock implements CategoriesListRepository {}

class CategoriesListFake extends Fake implements List<Category> {}

void main() {
  final repository = CategoriesListRepositoryMock();
  final usecase = GetCategoriesListImplementation(repository);

  test('Must return a List<Category> entity on success', () async {
    when(() => repository()).thenAnswer((invocation) async => Right(CategoriesListFake()));

    final result = await usecase();

    expect(result.fold(id, id), isA<CategoriesListFake>());
  });

  test('Must return a CategoriesListFailure on failure', () async {
    when(() => repository()).thenAnswer((invocation) async => Left(CategoriesListFailure('error')));

    final result = await usecase();

    expect(result.fold(id, id), isA<CategoriesListFailure>());
  });
}
