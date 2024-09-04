import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/categories_list_bloc.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/events/get_categories_list_event.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/events/toggle_category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/categories_list/domain/entities/category.dart';

class TreeViewList extends StatelessWidget {
  final categoriesListBloc = Modular.get<CategoriesListBloc>();

  @override
  Widget build(BuildContext context) {
    if (categoriesListBloc.categories.length == 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_outlined, size: 48, color: Colors.red),
          SizedBox(height: 12),
          Text(
            'Não foi possivel obter os dados',
            style: TextStyle(
              color: Colors.red,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              categoriesListBloc.add(GetCategoriesListEvent());
            },
            child: Text('Tentar novamente'),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          child: ExpansionTile(
            title: Text('Categorias'),
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            children: categoriesListBloc.categories.map((e) => ExpansionTileChild(e)).toList(),
          ),
        ),
      ),
    );
  }
}


class ExpansionTileChild extends StatefulWidget {
  final Category? currentCategory;

  const ExpansionTileChild(this.currentCategory);

  @override
  State<ExpansionTileChild> createState() => _ExpansionTileChildState();
}

class _ExpansionTileChildState extends State<ExpansionTileChild> {
  final categoriesListBloc = Modular.get<CategoriesListBloc>();

  Checkbox _checkBox() {
    return Checkbox(
      value: widget.currentCategory!.isSelected,
      onChanged: (value) {
        categoriesListBloc.add(ToggleCategoryEvent(widget.currentCategory!, value!));
        // widget.items!.firstWhere((element) => element.key == widget.currentCategory!.previous!.key).isSelected = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentCategory == null) {
      return SizedBox();
    }

    return widget.currentCategory!.children == null || widget.currentCategory!.children!.isEmpty
        ? ListTile(
            title: Text(widget.currentCategory!.description),
            leading: _checkBox(),
          )
        : ExpansionTile(
            title: Text(widget.currentCategory!.description),
            childrenPadding: EdgeInsets.symmetric(horizontal: 12),
            leading: _checkBox(),
            children: (widget.currentCategory!.children ?? []).map((e) => ExpansionTileChild(e)).toList(),
          );
  }
}
