import 'package:equatable/equatable.dart';

class ItemType extends Equatable{
  final int id;
  final String name;

  const ItemType({required this.id, required this.name});

  const ItemType.empty(): id = 0 , name = '';


  bool get isAddOnType => name.toLowerCase() == 'add-on';


  @override
  List<Object> get props => [id , name];
}


extension ItemTypesUtils on List<ItemType> {
  int get addOnItemTypeId => firstWhere((e) => e.name.toLowerCase() == 'add-on').id;
}