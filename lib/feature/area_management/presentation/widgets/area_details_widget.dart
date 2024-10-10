import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/entity/area_item.dart';
import 'package:merchant_dashboard/feature/area_management/presentation/blocs/area_management_cubit.dart';
import 'package:merchant_dashboard/feature/region/presentation/widgets/branch_country_cities_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/utils/translation/languages/tr.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/searchable_dropdown.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/rounded_text_input.dart';
import '../../../region/data/models/entity/city.dart';
import '../../data/models/entity/area_details.dart';

class AreaDetailsWidget extends StatefulWidget {
  const AreaDetailsWidget({super.key, this.areaItem, required this.onBackTap});

  final AreaItem? areaItem;
  final Function() onBackTap;

  @override
  State<AreaDetailsWidget> createState() => _AreaDetailsWidgetState();
}

class _AreaDetailsWidgetState extends State<AreaDetailsWidget> {
  late City? _selectedCity = widget.areaItem?.areaDetails?.toCity();
  late AreaDetails? _selectedArea = widget.areaItem?.areaDetails;

  late final _minOrderController = TextEditingController(text: widget.areaItem?.minOrderAmount.toString());
  late final _deliveryFeeController = TextEditingController(text: widget.areaItem?.deliveryFee.toString());
  late final _maxDiscountController = TextEditingController(text: widget.areaItem?.maxDeliveryDiscount.toString());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 310,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextButton.icon(
                onPressed: widget.onBackTap,
                label: Text(
                  S.current.addArea,
                  style: context.textTheme.titleLarge,
                ),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),

            Form(
              key: _formKey,
              child: ContainerSetting(
                  maxWidth: 300,
                  padding: const EdgeInsets.all(15),

                  blur: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BranchCountryCitiesWidget(
                        key: UniqueKey(),
                        preDefinedCity: _selectedCity,
                        isEnabled: widget.areaItem == null,
                        onCityChanged: (selectedItem) {
                          context.read<AreaManagementCubit>().getCityAreas(cityId: selectedItem.cityId!);

                          setState(() {
                            _selectedCity = City(id: selectedItem.cityId ?? 0, name: selectedItem.cityName ?? '');
                            _selectedArea = null;
                          });
                        },
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text(S.current.area, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      SearchableDropdown<AreaDetails>(
                        key: UniqueKey(),
                        isEnabled: widget.areaItem == null,
                        isRequired: true,
                        preDefinedItem: _selectedArea != null
                            ? SearchableDropDownModel(item: _selectedArea!, displayName: _selectedArea!.areaName)
                            : null,
                        items: context
                            .select((AreaManagementCubit bloc) => bloc.cityAreas.map(
                                  (e) => SearchableDropDownModel(item: e, displayName: e.areaName),
                                ))
                            .toList(),
                        onSelectedItemChanged: (selectedItem) {
                          _selectedArea = selectedItem!.item.toNewArea(selectedItem.displayName);
                        },
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text(S.current.minimumOrder, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                        textEditController: _minOrderController,
                        isRequired: true,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        hintText: '0.0',
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text(S.current.deliveryFee, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                        textEditController: _deliveryFeeController,
                        isRequired: true,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        hintText: '0.0',
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text(S.current.maxDiscount, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                        textEditController: _maxDiscountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        hintText: '0.0',
                      ),
                    ],
                  )),
            ),
            context.sizedBoxHeightSmall,
            Align(
              alignment: Alignment.topRight,
              child: BlocConsumer<AreaManagementCubit, AreaManagementState>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                    return;
                  }

                  switch (state) {
                    case CreateAreaState() when state.isSuccess:
                      context.showCustomeAlert(S.current.areaAddedSuccessfully, SnackBarType.success);
                      widget.onBackTap();

                    case EditAreaState() when state.isSuccess:
                      context.showCustomeAlert(S.current.areaEditedSuccessfully, SnackBarType.success);
                      widget.onBackTap();

                    case DeleteAreaState() when state.isSuccess:
                      context.showCustomeAlert(S.current.areaDeletedSuccessfully, SnackBarType.success);
                      widget.onBackTap();
                    default:
                      null;
                  }
                },
                builder: (context, state) => ((state is CreateAreaState || state is EditAreaState) && state.isLoading)
                    ? const LoadingWidget()
                    : RoundedBtnWidget(
                        onTap: () {
                          if (!_formKey.currentState!.validate()) return;
                          (widget.areaItem == null)
                              ? context.read<AreaManagementCubit>().createArea(
                                  cityName: _selectedCity?.name,
                                  cityId: _selectedCity?.id,
                                  areaName: _selectedArea?.areaName,
                                  areaId: _selectedArea?.areaId,
                                  maxDeliveryDiscount: num.tryParse(_maxDiscountController.text.trim()),
                                  minimumOrderAmount: num.parse(_minOrderController.text.trim()),
                                  deliveryFee: num.parse(_deliveryFeeController.text.trim()))
                              : context.read<AreaManagementCubit>().editArea(
                                  id: widget.areaItem!.id,
                                  maxDeliveryDiscount: num.tryParse(_maxDiscountController.text.trim()),
                                  minimumOrderAmount: num.parse(_minOrderController.text.trim()),
                                  deliveryFee: num.parse(_deliveryFeeController.text.trim()));
                        },
                        btnText: S.current.save,
                        btnPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
