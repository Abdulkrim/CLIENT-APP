import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/network_image_rounded_widget.dart';

import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/scrollable_widget.dart';

class DeleteMerchantLogoDialog extends StatelessWidget {
  const DeleteMerchantLogoDialog({
    super.key,
    required this.logoName,
    required this.imageUrl,
    required this.onDeleteTap,
  });

  final String logoName;
  final String imageUrl;
  final Function() onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
            width: 350,
            height: 300,
            child: Container(
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  Expanded(
                      child: ScrollableWidget(
                    scrollViewPadding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        NetworkImageRounded(
                          height: 90,
                          padding: const EdgeInsets.only(right: 40, left: 40, bottom: 32, top: 24),
                          url: imageUrl,
                          radius: BorderRadius.circular(8),
                        ),
                        Text(
                          S.current.removeConfirm(logoName),
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        context.sizedBoxHeightExtraSmall,
                        Row(
                          children: [
                            Expanded(
                                child: RoundedBtnWidget(
                              onTap: () => Get.back(),
                              height: 40,
                              bgColor: Colors.white,
                              btnTextColor: Colors.black,
                              boxBorder: Border.all(color: Colors.grey),
                              btnText: S.current.no,
                            )),
                            Expanded(
                                child: RoundedBtnWidget(
                              onTap: () {
                                Get.back();
                                onDeleteTap();
                              },
                              height: 40,
                              btnText: S.current.remove,
                            )),
                          ],
                        )
                      ],
                    ),
                  ))
                ]))),
      ),
    );
  }
}
