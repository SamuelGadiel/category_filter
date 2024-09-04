class Category {
  final Category? previous;
  final List<Category>? children;
  final String description;
  final String key;
  bool isSelected;

  Category({
    this.previous,
    this.children,
    required this.description,
    required this.key,
    required this.isSelected,
  });
}
