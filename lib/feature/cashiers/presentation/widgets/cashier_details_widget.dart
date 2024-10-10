import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/blocs/cashier_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../theme/theme_data.dart';
import '../../../../widgets/item_hint_textfield_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/rounded_dropdown_list.dart';
import '../../../../widgets/rounded_text_input.dart';
import '../../data/models/entity/cashier_role.dart';

class CashierDetailsWidget extends StatefulWidget {
  final Cashier? cashier;

  const CashierDetailsWidget({
    Key? key,
    this.cashier,
  }) : super(key: key);

  @override
  State<CashierDetailsWidget> createState() => _CashierDetailsWidgetState();
}

class _CashierDetailsWidgetState extends State<CashierDetailsWidget> {
  CashierRole? selectedCashierRole;

  late final TextEditingController _fullNameController = TextEditingController(text: widget.cashier?.name);
  late final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      height: 420,
      width: 350,
      title: (widget.cashier == null) ? S.current.addCashier : S.current.editCashier,
      child: ScrollableWidget(
        scrollViewPadding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ItemHintTextFieldWidget(textEditingController: _fullNameController, hintText: S.current.fullName),
            context.sizedBoxHeightExtraSmall,
            Text(S.current.role, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            context.sizedBoxHeightMicro,
            RoundedDropDownList(
                margin: EdgeInsets.zero,
                selectedValue: selectedCashierRole ??
                    () {
                      selectedCashierRole = context.select((CashierBloc bloc) => bloc.cashierRoles).firstWhere(
                          (element) => element.roleCode == widget.cashier?.cashierRoleId,
                          orElse: () => context.read<CashierBloc>().cashierRoles.first);
                      return selectedCashierRole;
                    }.call(),
                isExpanded: true,
                onChange: (p0) {
                  selectedCashierRole = p0;
                },
                items: context
                    .select((CashierBloc bloc) => bloc.cashierRoles)
                    .map((e) => DropdownMenuItem<CashierRole>(
                        value: e,
                        child: Text(
                          e.roleName,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                        )))
                    .toList()),
            context.sizedBoxHeightExtraSmall,
            Visibility(
                visible: widget.cashier == null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(S.current.password, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    context.sizedBoxHeightMicro,
                    RoundedTextInputWidget(
                      textEditController: _passwordController,
                      hintText: S.current.password,
                      obscureText: true,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )),
            context.sizedBoxHeightSmall,
            BlocConsumer<CashierBloc, CashierState>(
              listener: (context, state) {
                if (state is EditCashierStates && state.successMsg.isNotEmpty) {
                  Get.back();
                  context.showCustomeAlert(state.successMsg, SnackBarType.success);
                } else if (state is EditCashierStates && state.errorMessage.isNotEmpty) {
                  context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                }
              },
              builder: (context, state) => (state is EditCashierStates && state.isLoading)
                  ? const LoadingWidget()
                  : (widget.cashier != null)
                      ? Center(
                          child: RoundedBtnWidget(
                            onTap: () {
                              context.read<CashierBloc>().add(EditCashierRequestEvent(
                                  cashierId: widget.cashier!.id,
                                  cashierName: _fullNameController.text.trim(),
                                  cashierRoleId: selectedCashierRole!.roleCode,
                                  cashierRoleName: selectedCashierRole!.roleName,
                                  isActive: widget.cashier!.status));
                            },
                            btnText: S.current.saveChanges,
                            height: 35,
                            width: 300,
                            btnTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        )
                      : Center(
                          child: RoundedBtnWidget(
                            onTap: () {
                              if (_fullNameController.text.trim().isNotEmpty && _passwordController.text.trim().isNotEmpty) {
                                context.read<CashierBloc>().add(AddCashierRequestEvent(
                                      cashierName: _fullNameController.text.trim(),
                                      cashierPassword: _passwordController.text.trim(),
                                      cashierRoleId: selectedCashierRole!.roleCode,
                                    ));
                              } else {
                                context.showCustomeAlert(S.current.plzEnterAllData, SnackBarType.alert);
                              }
                            },
                            btnText: S.current.addCashier,
                            height: 35,
                            width: 300,
                            btnTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
            ),

          ],
        ),
      ),
    );
  }
}
