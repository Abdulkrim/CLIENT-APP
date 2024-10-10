import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../theme/theme_data.dart';

class MobileBillingHistoryWidget extends StatelessWidget {
  const MobileBillingHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        MobileBillingHistoryItem(),
        MobileBillingHistoryItem(),
        MobileBillingHistoryItem(),
        MobileBillingHistoryItem(),
        MobileBillingHistoryItem(),
        MobileBillingHistoryItem(),
      ],
    );
  }
}

class MobileBillingHistoryItem extends StatelessWidget {
  const MobileBillingHistoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.lightGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice No',
                textAlign: TextAlign.start,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightMicro,
              Expanded(
                child: Text(
                  '56ADC5825DEW',
                  textAlign: TextAlign.right,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscription date',
                textAlign: TextAlign.start,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightMicro,
              Expanded(
                child: Text(
                  '11/10/2022',
                  textAlign: TextAlign.right,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment',
                textAlign: TextAlign.start,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightMicro,
              const Icon(
                Icons.credit_card_sharp,
                color: Colors.red,
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Business Name',
                textAlign: TextAlign.start,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightMicro,
              Expanded(
                child: Text(
                  'KFC',
                  textAlign: TextAlign.right,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscription Plan',
                textAlign: TextAlign.start,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightMicro,
              Expanded(
                child: Text(
                  'AED 900 / Year',
                  textAlign: TextAlign.right,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscription Renews',
                textAlign: TextAlign.start,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightMicro,
              Expanded(
                child: Text(
                  '15/11/2022',
                  textAlign: TextAlign.right,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                textAlign: TextAlign.start,
                style: context.textTheme.titleSmall,
              ),
              context.sizedBoxHeightMicro,
              Expanded(
                child: Text(
                  'Pending',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.primaryColor),
                ),
              ),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Row(
            children: [
              Expanded(
                child: RoundedBtnWidget(
                  onTap: () {},
                  btnText: "Pay",
                  btnIcon: SvgPicture.asset(Assets.iconsUserIcon, color: Colors.white),
                  width: Get.width,
                  height: 30,
                  borderRadios: 40,
                  btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              context.sizedBoxWidthSmall,
              const Icon(
                Icons.cloud_download_rounded,
                color: Colors.black,
              )
            ],
          )
        ],
      ),
    );
  }
}
