import 'package:equatable/equatable.dart';

class ProductFilter extends Equatable {
  final int id;
  final String name;
  final int subCategoryId;

  const ProductFilter({required this.id, required this.name, required this.subCategoryId});

  const ProductFilter.firstItem()
      : id = 0,
        name = 'Select Product',
        subCategoryId = 0;

  @override
  List<Object> get props => [id, name, subCategoryId];
}
