import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../data/models/entity/loyalty_point.dart';

class PointHistoryItemWidget extends StatelessWidget {
  const PointHistoryItemWidget({super.key, required this.point});

  final LoyaltyPointItem point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: AppStyles.boxShadow,
      ),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              SvgPicture.asset(
                point.isEarnedPoint ? Assets.iconsPointsEarned : Assets.iconsPointsSpent,
                width: 20,
              ),
              context.sizedBoxWidthExtraSmall,
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${point.pointType}\n',
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: point.dayDateFormatted,
                    style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              ]))
            ],
          )),
          Text(point.pointWithSign,
              style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900, color: point.isEarnedPoint ? Colors.green : Colors.red)),
        ],
      ),
    );
  }
}
