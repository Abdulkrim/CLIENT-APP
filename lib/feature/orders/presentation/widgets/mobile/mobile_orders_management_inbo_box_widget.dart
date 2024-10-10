import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class MobileOrdersManagementInfoBoxWidget extends StatelessWidget {
  final String iconName;
  final String boxTitle;
  final String boxValue;

  const MobileOrdersManagementInfoBoxWidget(
      {Key? key, required this.iconName, required this.boxTitle, required this.boxValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 80),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconName,
            height: 35,
          ),
          context.sizedBoxWidthExtraSmall,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(boxValue,
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Text(boxTitle, style: context.textTheme.labelSmall),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
