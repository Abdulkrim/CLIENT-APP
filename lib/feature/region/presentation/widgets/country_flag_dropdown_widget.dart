import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../widgets/searchable_dropdown.dart';
import '../../data/models/entity/country.dart';
import '../blocs/region_cubit.dart';

class CountryFlagDropdownWidget extends StatelessWidget {
  const CountryFlagDropdownWidget({super.key, this.preCountrySelected});

  final int? preCountrySelected;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdown<Country>(
      items: context
          .select<RegionCubit, List<Country>>((value) => value.countries)
          .map((e) => e.toSearchableDropDownModel(
              selectedMode: SearchableDropDownItemMode.leading, itemMode: SearchableDropDownItemMode.title))
          .toList(),
      onSelectedItemChanged: (selectedItem) {},
      preDefinedItem: preCountrySelected != null
          ? context
              .read<RegionCubit>()
              .countries
              .firstWhereOrNull((element) => element.id == preCountrySelected!)
              ?.toSearchableDropDownModel(
                  selectedMode: SearchableDropDownItemMode.leading, itemMode: SearchableDropDownItemMode.title)
          : null,
    );
  }
}
