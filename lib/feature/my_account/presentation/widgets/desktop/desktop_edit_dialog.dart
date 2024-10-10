import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/blocs/my_account_bloc.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

class DesktopEditDialog extends StatelessWidget {
  final String dialogTitle;
  final String selectedFieldKey;
  final String selectedFieldValue;

  DesktopEditDialog({
    Key? key,
    required this.dialogTitle,
    required this.selectedFieldKey,
    required this.selectedFieldValue,
  }) : super(key: key);

  late final TextEditingController _inputTextController = TextEditingController(text: selectedFieldValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 350,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Update your $dialogTitle',
                        style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ))
                  ],
                ),
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
                            context.read<MyAccountBloc>().add(UpdateAccountInfoEvent(fieldKey: selectedFieldKey, fieldValue: _inputTextController.text.trim()));
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
      ),
    );
  }
}
