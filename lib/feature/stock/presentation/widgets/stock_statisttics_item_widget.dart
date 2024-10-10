import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class StockStatistticsItemWidget extends StatelessWidget {
  const StockStatistticsItemWidget(
      {super.key,
      required this.iconName,
      required this.boxTitle,
      required this.boxValue,
      required this.iconBGcolor,
      required this.textColor});

  final Color iconBGcolor;
  final Color textColor;
  final String iconName;
  final String boxTitle;
  final String boxValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.all(8.0),
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: iconBGcolor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconName,
                    height: 20,
                  ),
                ),
              ),
              context.sizedBoxWidthMicro,
              Text(boxTitle, style: context.textTheme.titleSmall?.copyWith(color: textColor)),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(boxValue, style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
