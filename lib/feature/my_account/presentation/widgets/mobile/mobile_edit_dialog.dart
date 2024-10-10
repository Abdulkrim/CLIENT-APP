import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/blocs/my_account_bloc.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

class MobileEditDialog extends StatelessWidget {
  final String dialogTitle;
  final String selectedFieldKey;
  final String selectedFieldValue;

  MobileEditDialog({
    Key? key,
    required this.dialogTitle,
    required this.selectedFieldKey,
    required this.selectedFieldValue,
  }) : super(key: key);

  late final TextEditingController _inputTextController = TextEditingController(text: selectedFieldValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Update your $dialogTitle',
              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            context.sizedBoxHeightExtraSmall,
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ItemHintTextFieldWidget(
                    textEditingController: _inputTextController,
                    hintText: dialogTitle,
                  ),
                  context.sizedBoxHeightExtraSmall,
                  Row(
                    children: [
                      Expanded(
                          child: RoundedBtnWidget(
                        onTap: () => Get.back(),
                        btnText: "Cancel",
                        width: Get.width * 0.3,
                        height: 30,
                        btnTextColor: Colors.black,
                        bgColor: Colors.transparent,
                        boxBorder: Border.all(color: Colors.black),
                      )),
                      Expanded(
                          child: RoundedBtnWidget(
                        onTap: () {
                          context.read<MyAccountBloc>().add(UpdateAccountInfoEvent(
                              fieldKey: selectedFieldKey, fieldValue: _inputTextController.text.trim()));
                        },
                        btnText: "Update",
                        width: Get.width * 0.3,
                        height: 30,
                      )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
