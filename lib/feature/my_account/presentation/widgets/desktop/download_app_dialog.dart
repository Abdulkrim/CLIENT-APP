import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';
import '../../../../../generated/assets.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/scrollable_widget.dart';

class DownloadAppDialog extends StatelessWidget {
  const DownloadAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 500,
          constraints: const BoxConstraints(maxHeight: 530),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: context.colorScheme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Download our Apps",
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: AppColors.white,
                      ))
                ],
              ),
            ),
            context.sizedBoxHeightExtraSmall,
            Expanded(
                child: ScrollableWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(Assets.bgSignupStep1, width: 500, height: 150, fit: BoxFit.cover),
                  context.sizedBoxHeightSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Please Select an app below",
                          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        context.sizedBoxHeightExtraSmall,
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Based on your Business we recommend you oto Download ",
                              style: context.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                            ),
                            TextSpan(
                              text: "Smart Epay",
                              style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.primaryColor),
                            ),
                          ]),
                        ),
                        context.sizedBoxHeightExtraSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RoundedBtnWidget(
                              onTap: () {},
                              btnText: 'Smart Epay',
                              bgColor: Colors.white,
                              boxBorder: Border.all(color: AppColors.transparentGrayColor),
                              btnPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              btnTextColor: context.colorScheme.primaryColor,
                            ),
                            RoundedBtnWidget(
                              onTap: () {},
                              btnText: 'Catalogak & KDS',
                              bgColor: Colors.white,
                              boxBorder: Border.all(color: AppColors.transparentGrayColor),
                              btnPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              btnTextColor: context.colorScheme.primaryColor,
                            ),
                            RoundedBtnWidget(
                              onTap: () {},
                              btnText: 'Download All',
                              bgColor: Colors.white,
                              boxBorder: Border.all(color: AppColors.transparentGrayColor),
                              btnPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              btnTextColor: context.colorScheme.primaryColor,
                            ),
                          ],
                        ),
                        context.sizedBoxHeightSmall,
                        Text(
                          'Enter email or phone number',
                          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        context.sizedBoxHeightMicro,
                        SizedBox(
                          height: 50,
                          child: Stack(
                            children: [
                              const RoundedTextInputWidget(
                                hintText: '',
                                contentPadding: EdgeInsets.only(left: 16, right: 140),
                              ),
                              Positioned(
                                top: 3,
                                right: 10,
                                child: RoundedBtnWidget(
                                  onTap: () {},
                                  btnText: "Get Started",
                                  btnPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        context.sizedBoxHeightMicro,
                        Text(
                          'Please enter with phone number your country code. Example : +971',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            context.sizedBoxHeightExtraSmall,
          ]),
        ),
      ),
    );
  }
}
