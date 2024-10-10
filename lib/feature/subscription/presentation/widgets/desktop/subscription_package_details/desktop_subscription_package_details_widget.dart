import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';

import '../../../../../../theme/theme_data.dart';
import '../../../../../../widgets/custom_tabbar/cutsom_top_tabbar.dart';
import '../../../../../../widgets/custom_tabbar/tab_item.dart';
import '../../../../data/models/enums/subscription_periods.dart';
import '../../../blocs/select_plan/cubit/select_plan_cubit.dart';
import 'feature_table_widget.dart';

class DesktopSubscriptionPackageDetailsWidget extends StatefulWidget {
  const DesktopSubscriptionPackageDetailsWidget(
      {super.key, required this.onBackButtonTap, required this.goPlanDetailsPage});

  final Function() onBackButtonTap;
  final Function() goPlanDetailsPage;

  @override
  State<DesktopSubscriptionPackageDetailsWidget> createState() =>
      _DesktopSubscriptionPackageDetailsWidgetState();
}

class _DesktopSubscriptionPackageDetailsWidgetState extends State<DesktopSubscriptionPackageDetailsWidget> {
  final double _rowHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: widget.onBackButtonTap,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  )),
              Text(
                S.current.checkoutSummary,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                context.sizedBoxHeightSmall,
                Row(
                  children: [
                    Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                      TextSpan(text: '${S.current.branchName}: ', style: context.textTheme.bodyMedium),
                      TextSpan(
                          text: context.watch<MainScreenBloc>().selectedMerchantBranch.merchantName,
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]))),
                    context.sizedBoxWidthExtraSmall,
                    Text(S.current.duration,
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    context.sizedBoxWidthMicro,
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: RoundedDropDownList(
                          isFilled: false,
                          margin: EdgeInsets.zero,
                          selectedValue: context.read<SelectPlanCubit>().selectedPeriodDuration,
                          isExpanded: true,
                          onChange: (p0) =>
                              setState(() => context.read<SelectPlanCubit>().selectedPeriodDuration = p0),
                          items: List.generate(
                              (context.read<SelectPlanCubit>().selectedSubscriptionPeriod ==
                                      SubscriptionPeriods.monthly)
                                  ? 12
                                  : 3,
                              (index) => DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text(
                                      '${index + 1} ${(context.read<SelectPlanCubit>().selectedSubscriptionPeriod == SubscriptionPeriods.monthly) ? 'Month' : 'Year'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: AppColors.black),
                                    ),
                                  ))),
                    ),
                    context.sizedBoxWidthExtraSmall,
                    SizedBox(
                      width: 200,
                      child: CustomTopTabbar(
                          height: 30,
                          tabBackgroundBorder: AppColors.black,
                          selectedColor: AppColors.black,
                          tabBackgroundColor: context.colorScheme.scaffoldBackgroundColor,
                          tabBorderRadius: BorderRadius.circular(8),
                          initialSelection:
                              context.read<SelectPlanCubit>().selectedSubscriptionPeriod.valueIndex,
                          tabs: [
                            TabItem(S.current.monthly, (index) {
                              context.read<SelectPlanCubit>().selectedSubscriptionPeriod =
                                  SubscriptionPeriods.monthly;
                              context.read<SelectPlanCubit>().selectedPeriodDuration = 1;
                              setState(() {});
                            }),
                            TabItem(S.current.yearly, (index) {
                              context.read<SelectPlanCubit>().selectedSubscriptionPeriod =
                                  SubscriptionPeriods.yearly;
                              context.read<SelectPlanCubit>().selectedPeriodDuration = 1;
                              setState(() {});
                            }),
                          ]),
                    ),
                  ],
                ),
                context.sizedBoxHeightExtraSmall,
                Text(
                  S.current.selectedPlan(context.read<SelectPlanCubit>().selectedPlan?.packageName ?? ''),
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                context.sizedBoxHeightDefault,
                FeaturesTableWidget(
                  rowHeight: _rowHeight,
                  goPlanDetailsPage: widget.goPlanDetailsPage,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
