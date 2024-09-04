import 'dart:async';

import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';
import 'package:category_filter/app/modules/categories_list/domain/failures/categories_list_failure.dart';
import 'package:category_filter/app/modules/categories_list/domain/usecases/get_categories_list.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/events/get_categories_list_event.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/events/toggle_category_event.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_failure_state.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_loading_state.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_states.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_success_state.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/toggle_category_loading_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/categories_list_events.dart';
import 'states/toggle_category_success_state.dart';

class CategoriesListBloc extends Bloc<CategoriesListEvents, CategoriesListStates> {
  final GetCategoriesList usecase;

  CategoriesListBloc(this.usecase) : super(CategoriesListLoadingState()) {
    on<GetCategoriesListEvent>(_mapGetCategoriesListEventToState);
    on<ToggleCategoryEvent>(_mapToggleCategoryEventToState);
  }

  List<Category> categories = [];

  void _mapGetCategoriesListEventToState(GetCategoriesListEvent event, Emitter<CategoriesListStates> emit) async {
    emit(CategoriesListLoadingState());

    final result = await usecase();

    result.fold(
      (l) => emit(CategoriesListFailureState(l as CategoriesListFailure)),
      (r) {
        categories = r;
        emit(CategoriesListSuccessState(r));
      },
    );
  }

  void selectAllChildren(List<Category>? children, bool value) {
    if (children != null) {
      children.forEach((e) {
        e.isSelected = value;
        selectAllChildren(e.children, value);
      });
    }
  }

  // List<int> findParents (){
    
  // }

  void _mapToggleCategoryEventToState(ToggleCategoryEvent event, Emitter<CategoriesListStates> emit) {
    emit(ToggleCategoryLoadingState());

    event.category.isSelected = event.value;
    selectAllChildren(event.category.children, event.value);

    // List<int> parentIndexes = findParents();
    emit(ToggleCategorySuccessState());

  }
}
