import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../theme/theme_data.dart';

class MobileSubscriptionPlanWidget extends StatelessWidget {
  const MobileSubscriptionPlanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        MobileSubscriptionPlanItemWidget(),
        MobileSubscriptionPlanItemWidget(),
        MobileSubscriptionPlanItemWidget(),
        MobileSubscriptionPlanItemWidget(),
        MobileSubscriptionPlanItemWidget(),
      ],
    );
  }
}

class MobileSubscriptionPlanItemWidget extends StatelessWidget {
  const MobileSubscriptionPlanItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.lightGray,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AED 89.99 / Month",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium,
                ),
                context.sizedBoxHeightMicro,
                RoundedBtnWidget(
                  onTap: () {},
                  btnText: "Subscribe",
                  width: 100,
                  borderRadios: 40,
                  height: 40,
                  btnTextStyle: context.textTheme.titleSmall,
                  btnTextColor: Colors.black,
                  bgColor: Colors.transparent,
                  boxBorder: Border.all(color: context.colorScheme.primaryColor),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            left: 0,
            child: SizedBox(
              width: 100,
              height: 20,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    Assets.iconsPlanBadge,
                    width: 80,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Current Plan",
                      style: context.textTheme.labelMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
