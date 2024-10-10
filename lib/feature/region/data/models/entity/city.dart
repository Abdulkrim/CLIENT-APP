import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final String name;
  final int? countryId;
  final String? countryName;

  const City({required this.id, required this.name, this.countryId, this.countryName});

  @override
  List<Object> get props => [id, name];

  const City.firstItem()
      : id = 0,
        name = 'Select City',
        countryId = null,
        countryName = null;
}

