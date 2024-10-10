import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

class ExploreItemWidget extends StatelessWidget {
  const ExploreItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.btnText,
    required this.onBtnTap,
  });

  final String title;
  final String description;
  final String btnText;
  final Function() onBtnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.headerColor),
        ),
        context.sizedBoxHeightUltraSmall,
        Text(
          description,
        maxLines: 2,
          style: context.textTheme.titleSmall?.copyWith(color: Colors.grey),
        ),
        context.sizedBoxHeightExtraSmall,
        RoundedBtnWidget(
          btnMargin: const EdgeInsets.all(0),
          onTap: onBtnTap,
          btnText: btnText,
          btnPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          bgColor: Colors.transparent,
          boxBorder: Border.all(color: Colors.black),
          btnTextColor: Colors.black,
        ),
      ],
    );
  }
}
