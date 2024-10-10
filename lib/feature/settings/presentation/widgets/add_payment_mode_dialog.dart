import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/settings/presentation/blocs/settings_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_checkbox.dart';

import '../../../../widgets/rounded_text_input.dart';

class AddPaymentModeDialog extends StatefulWidget {
  const AddPaymentModeDialog({super.key});

  @override
  State<AddPaymentModeDialog> createState() => _AddPaymentModeDialogState();
}

class _AddPaymentModeDialogState extends State<AddPaymentModeDialog> {
  final _nameController = TextEditingController();

  bool canHaveRefrence = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        height: 290,
        width: 300,
        title: S.current.addPaymentType,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(S.current.typeName,
                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              context.sizedBoxHeightMicro,
              RoundedTextInputWidget(
                hintText: S.current.addPaymentType,
                textEditController: _nameController,
                isRequired: true,
              ),
              context.sizedBoxHeightExtraSmall,
              RoundedCheckBoxWidget(
                onChnageCheck: (check) => setState(() => canHaveRefrence = check),
                text: S.current.paymentReferenceNumber,
              ),
              context.sizedBoxHeightExtraSmall,
              BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {
                  if (state is AddPaymentModeState && state.isSuccess) {
                    Get.back();
                    context.showCustomeAlert(S.current.paymentModeAddedSuccessfully, SnackBarType.success);
                  } else if (state is AddPaymentModeState && state.error != null) {
                    context.showCustomeAlert(state.error, SnackBarType.error);
                  }
                },
                builder: (context, state) => (state is AddPaymentModeState && state.isLoading)
                    ? const LoadingWidget()
                    : RoundedBtnWidget(
                        onTap: () {
                          if (_nameController.text.trim().isNotEmpty) {
                            context
                                .read<SettingsBloc>()
                                .add(AddPaymentModeEvent(_nameController.text.trim(), canHaveRefrence));
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
