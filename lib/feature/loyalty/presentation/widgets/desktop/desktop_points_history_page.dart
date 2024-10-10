import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/loyalty/presentation/blocs/loyalty_point/loyalty_point_history_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/cutsom_top_tabbar.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/tab_item.dart';

import '../../../../../generated/l10n.dart';
import '../point_history_item_widget.dart';

enum PointType { all, earned, spent }

class DesktopPointsHistoryPage extends StatefulWidget {
  const DesktopPointsHistoryPage({super.key, required this.onBackTap});

  final Function() onBackTap;

  @override
  State<DesktopPointsHistoryPage> createState() => _DesktopPointsHistoryPageState();
}

class _DesktopPointsHistoryPageState extends State<DesktopPointsHistoryPage> {
  PointType _selectedPointType = PointType.all;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: widget.onBackTap,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            context.sizedBoxWidthMicro,
            Text(
              S.current.viewPoints,
              style: context.textTheme.titleLarge,
            ),
          ],
        ),
        context.sizedBoxHeightMicro,
        Row(
          children: [
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.iconsPointsEarned),
                context.sizedBoxWidthExtraSmall,
                Expanded(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                      text: '250 ${S.current.points}\n',
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '250 ${S.current.pointsDescription}',
                      style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                ]))),
              ],
            )),
            SizedBox(
                width: 300,
                child: CustomTopTabbar(
                  tabs: [
                    TabItem(S.current.all, (index) => setState(() => _selectedPointType = PointType.all)),
                    TabItem(
                        S.current.earned, (index) => setState(() => _selectedPointType = PointType.earned)),
                    TabItem(S.current.spent, (index) => setState(() => _selectedPointType = PointType.spent))
                  ],
                  hasShadow: true,
                  tabBackgroundColor: Colors.white,
                  tabBorderRadius: BorderRadius.circular(12),
                  selectedColor: Colors.black,
                )),
            context.sizedBoxWidthMicro,
          ],
        ),
        context.sizedBoxHeightSmall,
        Divider(color: AppColors.transparentGrayColor, thickness: .5, height: .5),
        context.sizedBoxHeightExtraSmall,
        Expanded(
          child: ListView(
            children: context
                .select((LoyaltyPointHistoryCubit bloc) => bloc.pointsPagination.listItems)
                .where((element) => (_selectedPointType == PointType.earned)
                    ? element.originalPoint >= 0
                    : (_selectedPointType == PointType.spent)
                        ? element.originalPoint < 0
                        : true)
                .map((e) => PointHistoryItemWidget(point: e))
                .toList(),
          ),
        )
      ],
    );
  }
}
