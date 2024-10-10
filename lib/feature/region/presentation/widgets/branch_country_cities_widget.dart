import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/region/presentation/blocs/region_cubit.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/searchable_dropdown.dart';
import '../../data/models/entity/city.dart';
import '../../data/models/entity/region_data.dart';

class BranchCountryCitiesWidget extends StatefulWidget {
  const BranchCountryCitiesWidget(
      {super.key, required this.onCityChanged, this.mandatoryChar = '*', this.preDefinedCity, this.isEnabled = true});

  final Function(RegionData selectedItem) onCityChanged;
  final String mandatoryChar;
  final City? preDefinedCity;
  final bool isEnabled;

  @override
  State<BranchCountryCitiesWidget> createState() => _BranchCountryCitiesWidgetState();
}

class _BranchCountryCitiesWidgetState extends State<BranchCountryCitiesWidget> {
  late City? _selectedCity = widget.preDefinedCity ?? const City.firstItem();

  @override
  void initState() {
    super.initState();

    context.read<RegionCubit>().getBranchCities();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${S.current.city}${widget.mandatoryChar}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        context.sizedBoxHeightMicro,
        SearchableDropdown<City>(
          key: UniqueKey(),
          isEnabled: widget.isEnabled,
          preDefinedItem:
              _selectedCity != null ? SearchableDropDownModel(item: _selectedCity!, displayName: _selectedCity!.name) : null,
          items: context
              .select<RegionCubit, List<City>>((value) => value.cities)
              .map((e) => SearchableDropDownModel(item: e, displayName: e.name))
              .toList(),
          onSelectedItemChanged: (selectedItem) {
            if (selectedItem?.item == null) {
              _selectedCity = City(id: -1, name: selectedItem!.displayName);
            } else {
              _selectedCity = selectedItem?.item;
            }
            widget.onCityChanged(
                RegionData(countryId: _selectedCity?.countryId, cityId: _selectedCity?.id, cityName: _selectedCity?.name));
          },
        )
      ],
    );
  }
}
