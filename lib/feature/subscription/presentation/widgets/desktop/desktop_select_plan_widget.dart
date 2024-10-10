import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/subscription_plan.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/enums/subscription_periods.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../../widgets/custom_tabbar/cutsom_top_tabbar.dart';
import '../../../../../widgets/custom_tabbar/tab_item.dart';

class DesktopSelectPlanWidget extends StatefulWidget {
  const DesktopSelectPlanWidget({super.key, required this.onBackButtonTap, required this.onPlanSelected});

  final Function() onBackButtonTap;
  final Function(SubscriptionPlan selectedPlan) onPlanSelected;

  @override
  State<DesktopSelectPlanWidget> createState() => _DesktopSelectPlanWidgetState();
}


class _DesktopSelectPlanWidgetState extends State<DesktopSelectPlanWidget> {
  @override
  void initState() {
    super.initState();
context.read<SelectPlanCubit>()
    ..getAllPlans()
    ..getSharedFeatures();
  }



  @override
  Widget build(BuildContext context) {
    final subscriptionPlans = context.select((SelectPlanCubit bloc) => bloc.subscriptionPlans);
    final sharedFeatures = context.select((SelectPlanCubit bloc) => bloc.sharedFeatures);

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
                S.current.selectPlan,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
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
                            setState(() {});
                          }),
                          TabItem(S.current.yearly, (index) {
                            context.read<SelectPlanCubit>().selectedSubscriptionPeriod =
                                SubscriptionPeriods.yearly;
                            setState(() {});
                          }),
                        ]),
                  ),
                ),
              )
            ],
          ),
          Text(
            'Cancel before October 16 and you will not be charged. You can change your plan att any time.',
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          context.sizedBoxHeightSmall,
          Expanded(
            child: BlocBuilder<SelectPlanCubit, SelectPlanState>(
              builder: (context, state) {
                return (state is GetAllPlansState || state is GetSharedFeaturesState) && state.isLoading
                    ? const LoadingWidget()
                    : ScrollableWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Wrap(
                              children: subscriptionPlans
                                  .map((e) => _PlanItemWidget(
                                        subscriptionPlan: e,
                                        isMonthly:
                                            context.read<SelectPlanCubit>().selectedSubscriptionPeriod ==
                                                SubscriptionPeriods.monthly,
                                        onPlanSelected: () => widget.onPlanSelected(e),
                                      ))
                                  .toList(),
                            ),
                            context.sizedBoxHeightSmall,
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0f000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    S.current.allPlaneIncluded,
                                    style:
                                        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  context.sizedBoxHeightExtraSmall,
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 3,
                                    childAspectRatio: 4,
                                    children: sharedFeatures
                                        .map(
                                          (e) => Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                CupertinoIcons.checkmark_alt_circle,
                                                color: Colors.green,
                                              ),
                                              context.sizedBoxWidthMicro,
                                              Expanded(
                                                child: Text(
                                                  e.featureNameWithCulture,
                                                  style: context.textTheme.bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _PlanItemWidget extends StatelessWidget {
  const _PlanItemWidget(
      {required this.subscriptionPlan, required this.isMonthly, required this.onPlanSelected});

  final SubscriptionPlan subscriptionPlan;
  final bool isMonthly;
  final Function() onPlanSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f000000),
            offset: Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subscriptionPlan.packageName,
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Visibility(
                      visible: subscriptionPlan.flag.isNotEmpty,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 6),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: context.colorScheme.primaryColor,
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(subscriptionPlan.flag , style: context.textTheme.bodySmall?.copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: (isMonthly && subscriptionPlan.packagePricingWithCulture.hasDiscountMonthly) ||
                            (!isMonthly && subscriptionPlan.packagePricingWithCulture.hasDiscountYearly),
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: S.current.basePrice,
                                  style: context.textTheme.bodySmall?.copyWith(color: AppColors.gray)),
                              TextSpan(
                                  text:
                                  '${isMonthly ? subscriptionPlan.packagePricingWithCulture.monthlyBasePrice.toString() : subscriptionPlan.packagePricingWithCulture.yearlyBasePrice.toString()} ${subscriptionPlan.packagePricingWithCulture.currency.name}',
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColors.gray)),
                            ])),
                      ),
                      context.sizedBoxHeightMicro,
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: isMonthly
                                    ? subscriptionPlan.packagePricingWithCulture.monthlyPriceWithDiscount.toString()
                                    : subscriptionPlan.packagePricingWithCulture.yearlyPriceWithDiscount.toString(),
                                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' ${subscriptionPlan.packagePricingWithCulture.currency.name}',
                                style: context.textTheme.bodySmall),
                            TextSpan(
                                text: '/${isMonthly ? S.current.month : S.current.year}',
                                style: context.textTheme.bodySmall),
                          ])),
                    ],
                  ),
                ),
                context.sizedBoxHeightExtraSmall,
                RoundedBtnWidget(
                  hoverColor: Colors.red,
                  onTap: onPlanSelected,
                  btnText: S.current.choosePlan(subscriptionPlan.packageName),
                  bgColor: AppColors.black,
                  height: 40,
                ),
              ],
            ),
          ),
            Divider(
            color: AppColors.gray2,
            thickness: .4,
            height: .4,
          ),
          context.sizedBoxHeightExtraSmall,
          Visibility( visible: subscriptionPlan.includedPackages.isNotEmpty ,child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
            color: context.colorScheme.primaryColor,
            child: Row(children: [
              Lottie.asset(Assets.animsArrivalPackage , width: 50),
              context.sizedBoxWidthMicro,
              Expanded(child: Text('${subscriptionPlan.includedPackageNames} Package Included' , style: context.textTheme.bodySmall?.copyWith(color: Colors.white)))
            ],),
          )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
              Text(
                S.current.features,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              context.sizedBoxHeightMicro,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: subscriptionPlan.featureGroups
                    .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.network(
                        e.iconUrl,
                        color: Colors.black,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: '${e.featureGroup} ',
                                style: context.textTheme.bodyMedium,
                              ),
                              ...e.features
                                  .asMap()
                                  .map(
                                    (key, value) => MapEntry(
                                    key,
                                    TextSpan(
                                        text:
                                        '${key == 0 ? '( ' : ''}${value.featureName}${e.features.length == 1 ? ' )' : key == (e.features.length - 1) ? ')' : ',  '}',
                                        style: context.textTheme.bodyMedium)),
                              )
                                  .values
                                  .toList()
                            ]),
                          )),
                    ],
                  ),
                ))
                    .toList(),
              )
            ],),
          ),
        ],
      ),
    );
  }
}
