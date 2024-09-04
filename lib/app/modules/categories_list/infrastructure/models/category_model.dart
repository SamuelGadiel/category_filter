import 'package:category_filter/app/modules/categories_list/domain/entities/category.dart';

class CategoryModel extends Category {
  final Category? previous;
  final List<Category>? children;
  final String description;
  final String key;
  bool isSelected;

  CategoryModel({
    this.previous,
    this.children,
    required this.description,
    required this.key,
    required this.isSelected,
  }) : super(
          previous: previous,
          children: children,
          description: description,
          key: key,
          isSelected: isSelected,
        );

  static CategoryModel fromJson(Map<String, dynamic> json, {Category? previous}) {
    CategoryModel currentCategory = CategoryModel(
      previous: previous,
      children: [],
      description: json['value'] ?? '',
      key: json['key'] ?? -double.maxFinite.toInt(),
      isSelected: false,
    );

    currentCategory.children!.addAll(
      ((json['list'] ?? []) as List).map((e) => CategoryModel.fromJson(e, previous: currentCategory)).toList(),
    );

    return currentCategory;
  }
}
