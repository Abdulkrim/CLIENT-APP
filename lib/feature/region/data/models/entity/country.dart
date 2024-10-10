import 'package:flutter_svg/svg.dart';

import '../../../../../widgets/searchable_dropdown.dart';

class Country {
  final int id;
  final String name;
  final String flagPicture;
  final String? countryCode;

  const Country({required this.id, required this.name, required this.countryCode, required this.flagPicture});

  const Country.firstItem()
      : id = 0,
        name = 'Select Country',
        countryCode = '',
        flagPicture = '';
}

extension Converter on Country {
  SearchableDropDownModel<Country> toSearchableDropDownModel(
          {SearchableDropDownItemMode itemMode = SearchableDropDownItemMode.both,
          SearchableDropDownItemMode selectedMode = SearchableDropDownItemMode.both}) =>
      SearchableDropDownModel(
          searchableDropDownSelectedItemMode: selectedMode,
          searchableDropDownItemMode: itemMode,
          item: this,
          displayName: name,
          leadingWidget: SvgPicture.network(flagPicture, width: 20));
}
