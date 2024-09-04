import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/domain/failures/categories_list_failure.dart';
import 'package:category_filter/app/modules/categories_list/domain/usecases/get_categories_list.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/categories_list_bloc.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/events/get_categories_list_event.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_failure_state.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_loading_state.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_success_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class GetCategoriesListMock extends Mock implements GetCategoriesList {}

class CategoriesListFake extends Fake implements List<Category> {}

void main() {
  final usecase = GetCategoriesListMock();
  final bloc = CategoriesListBloc(usecase);

  test('Must return all states in order on success', () {
    when(() => usecase()).thenAnswer((invocation) async => Right(CategoriesListFake()));

    bloc.add(GetCategoriesListEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<CategoriesListLoadingState>(),
          isA<CategoriesListSuccessState>(),
        ]));
  });

  test('Must return all states in order on failure', () {
    when(() => usecase()).thenAnswer((invocation) async => Left(CategoriesListFailure('error')));

    bloc.add(GetCategoriesListEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<CategoriesListLoadingState>(),
          isA<CategoriesListFailureState>(),
        ]));
  });
}
