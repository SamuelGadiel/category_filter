import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/categories_list_bloc.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/events/get_categories_list_event.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_failure_state.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_loading_state.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_states.dart';
import 'package:category_filter/app/modules/categories_list/presentation/blocs/categories_list_bloc/states/categories_list_success_state.dart';
import 'package:category_filter/app/tree_view_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categoriesListBloc = Modular.get<CategoriesListBloc>();

  @override
  void initState() {
    super.initState();

    categoriesListBloc.add(GetCategoriesListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TreeView Example"), centerTitle: true),
      body: Center(
        child: BlocConsumer<CategoriesListBloc, CategoriesListStates>(
          bloc: categoriesListBloc,
          listener: (context, state) {
            if (state is CategoriesListFailureState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Erro'),
                    content: Text(state.failure.message),
                    actions: [
                      TextButton(
                        onPressed: () => Modular.to.pop(),
                        child: Text('Okay'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is GetCategoriesListEvent) {
              return CircularProgressIndicator();
            }

            return TreeViewList();
          },
        ),
      ),
    );
  }
}
