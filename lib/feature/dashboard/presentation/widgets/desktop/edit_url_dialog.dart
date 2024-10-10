import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

class EditURLDialog extends StatelessWidget {
  const EditURLDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 350,
          height: 250,
          child: Container(
            decoration:
                const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  padding: const EdgeInsets.all(10.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                        S.current.editSubDomain,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ItemHintTextFieldWidget(
                          textEditingController: TextEditingController(),
                          hintText: S.current.enterSubDomain,
                        ),
                        context.sizedBoxHeightExtraSmall,
                        Row(
                          children: [
                            Expanded(
                              child: RoundedBtnWidget(
                                onTap: () => Get.back(),
                                btnText: S.current.cancel,
                                btnPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                                bgColor: AppColors.white,
                                boxBorder: Border.all(color: AppColors.black),
                                btnTextColor: AppColors.black,
                              ),
                            ),
                            Expanded(
                              child: RoundedBtnWidget(
                                onTap: () {},
                                btnText: "Update Link",
                                btnPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
