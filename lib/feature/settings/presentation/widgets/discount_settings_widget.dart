import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/tooltip_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import '../../../../generated/l10n.dart';
import '../../../../injection.dart';
import '../../../../theme/theme_data.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/rounded_dropdown_list.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../blocs/settings_bloc.dart';

enum DiscountType {
  value(1),
  percentage(0);

  const DiscountType(this.valueNumber);

  final int valueNumber;
}

class DiscountSettingsWidget extends StatefulWidget {
  const DiscountSettingsWidget({super.key});

  @override
  State<DiscountSettingsWidget> createState() => _DiscountSettingsWidgetState();
}

class _DiscountSettingsWidgetState extends State<DiscountSettingsWidget> {
  DiscountType _selectedDiscountType = DiscountType.value;

  final _discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ContainerSetting(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(S.current.productDiscount,
                style: context.textTheme.titleSmall
                    ?.copyWith(
                    fontWeight: FontWeight.bold,color: AppColors.headerColor)),
            Text(
              S.current.allowDiscountToAllProducts,
              style:
              context.textTheme.titleSmall?.copyWith(color: AppColors.gray),
            ),


            context.sizedBoxHeightExtraSmall,


            Text(
              S.current.discountType,style:  Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.black),
            ),
            context.sizedBoxHeightMicro,
            Wrap(
              children: [
                RoundedDropDownList(
                    maxWidth: 150,
                    margin: const EdgeInsets.only(right: 20),
                    selectedValue: _selectedDiscountType,
                    isExpanded: false,
                    onChange: (p0) =>
                        setState(() => _selectedDiscountType = p0!),
                    items: DiscountType.values
                        .map((e) => DropdownMenuItem<DiscountType>(
                        value: e,
                        child: Text(
                          e.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColors.black),
                        )))
                        .toList()),

                SizedBox(
                  width: 75,
                  height: 48,
                  child: RoundedTextInputWidget(
                    hintText: '0',
                    suffixIcon:
                    (_selectedDiscountType == DiscountType.percentage)
                        ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('%'),
                      ],
                    )
                        : null,
                    keyboardType: TextInputType.number,
                    textEditController: _discountController,
                  ),
                ),
                context.sizedBoxWidthMicro,
                BlocConsumer<SettingsBloc, SettingsState>(
                  listener: (context, state) {
                    if (state is UpdateDiscountValueStates &&
                        state.error != null) {
                      context.showCustomeAlert(state.error);
                    } else if (state is UpdateDiscountValueStates &&
                        state.isSuccess) {
                      context.showCustomeAlert(
                          S.current.discountUpdatedSuccessfully);
                    }
                  },
                  builder: (context, state) {
                    return (state is UpdateDiscountValueStates &&
                        state.isLoading)
                        ? const LoadingWidget()
                        : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          backgroundColor:AppColors.lightPrimaryColor ,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: context.colorScheme.primaryColor),
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        if (_discountController.text.trim().isEmpty) {
                          context.showCustomeAlert(
                              S.current.enterDiscountError);
                          return;
                        }
                        _showMyDialog(
                          onYesTapped: () {
                            context.read<SettingsBloc>().add(
                                UpdateDiscountValue(
                                    discountType:
                                    _selectedDiscountType.valueNumber,
                                    discountValue: num.parse(
                                        _discountController.text
                                            .trim())));
                          },
                        );
                      },
                      child: Text(
                        S.current.applyDiscount,
                        style: context.textTheme.titleSmall
                            ?.copyWith(color: context.colorScheme.primaryColor),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog({required Function() onYesTapped}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(S.current.discountSettings),
          content: Text(S.current.applyDiscountWarning),
          actions: [
            TextButton(
              onPressed: () {
                onYesTapped();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
