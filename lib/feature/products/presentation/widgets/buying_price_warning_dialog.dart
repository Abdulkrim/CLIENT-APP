import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../theme/theme_data.dart';
import '../../../../widgets/rounded_btn.dart';

class BuyingPriceWarningDialog extends StatelessWidget {
  const BuyingPriceWarningDialog({super.key, required this.onOkayTap});
  final Function onOkayTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 350,
          height: 210,
          child: Container(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  padding: const EdgeInsets.all(10.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                        S.current.warning,
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
                          Text(S.current.buyingPriceHigherThanPrice),
                        context.sizedBoxHeightExtraSmall,
                        Row(
                          children: [
                            Expanded(
                              child: RoundedBtnWidget(
                                onTap: () {
                                  Get.back();
                                  onOkayTap();
                                },
                                btnText: S.current.yes,
                                btnPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                                bgColor: AppColors.white,
                                boxBorder: Border.all(color: AppColors.black),
                                btnTextColor: AppColors.black,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RoundedBtnWidget(
                                onTap: () => Get.back(),
                                btnText: S.current.no,
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
