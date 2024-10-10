import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/expense/presentation/blocs/expense_cubit.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../widgets/rounded_text_input.dart';

class AddExpenseTypeDialog extends StatelessWidget {
  AddExpenseTypeDialog({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        height: 290,
        width: 350,
        title: S.current.addTypeOfExpense,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(S.current.typeName, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              context.sizedBoxHeightMicro,
              RoundedTextInputWidget(
                hintText: S.current.enterNameOfType,
                textEditController: _nameController,
                isRequired: true,
              ),
              context.sizedBoxHeightExtraSmall,
              BlocConsumer<ExpenseCubit, ExpenseState>(
                listener: (context, state) {
                  if (state is AddExpenseTypesState && state.successMessage.isNotEmpty) {
                    Get.back();
                    context.showCustomeAlert(state.successMessage, SnackBarType.success);
                  } else if (state is AddExpenseTypesState && state.errorMessage.isNotEmpty) {
                    context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                  }
                },
                builder: (context, state) => (state is AddExpenseTypesState && state.isLoading)
                    ? const LoadingWidget()
                    : RoundedBtnWidget(
                        onTap: () {
                          if (_nameController.text.trim().isNotEmpty) {
                            context.read<ExpenseCubit>().addExpenseType(_nameController.text.trim());
                          }
                        },
                        height: 35,
                        btnText: S.current.save,
                      ),
              )
            ],
          ),
        ));
  }
}
