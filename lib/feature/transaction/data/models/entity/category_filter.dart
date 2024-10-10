import 'package:equatable/equatable.dart';

class CategoryFilter extends Equatable {
  final int id;
  final String name;

  const CategoryFilter({required this.id, required this.name});

  const CategoryFilter.firstItem()
      : id = 0,
        name = 'Select Category';

  @override
  List<Object> get props => [id, name];
}

class SubCategoryFilter extends Equatable {
  final int parentId;

  final int id;
  final String name;

  const SubCategoryFilter({required this.parentId, required this.id, required this.name});

  const SubCategoryFilter.firstItem()
      : id = 0,
        parentId = 0,
        name = 'Select Sub Category';

  @override
  List<Object> get props => [id, name, parentId];
}
