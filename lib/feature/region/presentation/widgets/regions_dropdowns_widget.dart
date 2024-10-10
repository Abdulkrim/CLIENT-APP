import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/searchable_dropdown.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/entity/city.dart';
import '../../data/models/entity/country.dart';
import '../../data/models/entity/region_data.dart';
import '../blocs/region_cubit.dart';

class RegionsDropDownWidget extends StatefulWidget {
  const RegionsDropDownWidget(
      {super.key,
      required this.onCityChanged,
      this.preCountrySelected,
      this.onCountryChanged,
      this.mandatoryChar = '',
      this.isVertically = true,
      this.preSelectedCity});

  final int? preCountrySelected;
  final int? preSelectedCity;
  final String mandatoryChar;
  final bool isVertically;
  final Function(RegionData selectedItem) onCityChanged;
  final Function({String? countryCode})? onCountryChanged;

  @override
  State<RegionsDropDownWidget> createState() => _RegionsDropDownWidgetState();
}

class _RegionsDropDownWidgetState extends State<RegionsDropDownWidget> {
  @override
  void initState() {
    super.initState();

    context.read<RegionCubit>().cities = [];
    if (context.read<RegionCubit>().countries.isNotEmpty) {
      _selectedCountry =
          context.read<RegionCubit>().countries.firstWhereOrNull((element) => element.id == widget.preCountrySelected) ??
              context.read<RegionCubit>().countries.firstWhereOrNull(
                  (element) => element.name.toLowerCase() == context.read<RegionCubit>().countryNameByIP?.toLowerCase()) ??
              const Country.firstItem();
    }
    context.read<RegionCubit>().getAllCountriesAndCities(_selectedCountry?.id);
  }

  late Country? _selectedCountry = const Country.firstItem();

  late City? _selectedCity = const City.firstItem();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegionCubit, RegionState>(
      listener: (context, state) {
        if (state is GetCountriesState && state.isSuccess) {
          if (widget.preCountrySelected != null || context.read<RegionCubit>().countryNameByIP != null) {
            _selectedCountry =
                context.read<RegionCubit>().countries.firstWhereOrNull((element) => element.id == widget.preCountrySelected) ??
                    context.read<RegionCubit>().countries.firstWhereOrNull(
                        (element) => element.name.toLowerCase() == context.read<RegionCubit>().countryNameByIP?.toLowerCase()) ??
                    const Country.firstItem();
          }
        } else if (state is GetCitiesState && state.isSuccess) {
          if (widget.preSelectedCity != null || context.read<RegionCubit>().cityNameByIP != null) {
            _selectedCity =
                context.read<RegionCubit>().cities.firstWhereOrNull((element) => element.id == widget.preSelectedCity) ??
                    context.read<RegionCubit>().cities.firstWhereOrNull(
                        (element) => element.name.toLowerCase() == context.read<RegionCubit>().cityNameByIP?.toLowerCase()) ??
                    const City.firstItem();

            widget.onCityChanged(
                RegionData(countryId: _selectedCountry?.id, cityId: _selectedCity!.id, cityName: _selectedCity?.name));
          }
        }
      },
      child: widget.isVertically
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [..._countrySection(), context.sizedBoxHeightExtraSmall, ..._citySection()],
            )
          : Row(
              children: [
                context.sizedBoxWidthSmall,
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: _countrySection())),
                context.sizedBoxWidthExtraSmall,
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: _citySection())),
                context.sizedBoxWidthSmall,
              ],
            ),
    );
  }

  List<Widget> _countrySection() => [
        Text('${S.current.country}${widget.mandatoryChar}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        context.sizedBoxHeightMicro,
        SearchableDropdown<Country>(
          preDefinedItem: _selectedCountry?.toSearchableDropDownModel(),
          items: context
              .select<RegionCubit, List<Country>>((value) => value.countries)
              .map((e) => e.toSearchableDropDownModel())
              .toList(),
          onSelectedItemChanged: (selectedItem) {
            if (widget.onCountryChanged != null) {
              widget.onCountryChanged!(countryCode: selectedItem!.item!.countryCode);
            }

            context.read<RegionCubit>().getCountryCities(selectedItem!.item!.id);
            context.read<RegionCubit>().cities = [];

            setState(() {
              _selectedCountry = selectedItem.item;
              _selectedCity = null;
            });
          },
        )
      ];

  List<Widget> _citySection() => [
        Text('${S.current.city}${widget.mandatoryChar}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        context.sizedBoxHeightMicro,
        SearchableDropdown<City>(
          key: UniqueKey(),
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
                RegionData(countryId: _selectedCountry?.id, cityId: _selectedCity?.id, cityName: _selectedCity?.name));
          },
        )
      ];
}
