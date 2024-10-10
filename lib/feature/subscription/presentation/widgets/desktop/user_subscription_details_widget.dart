import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import 'package:intl/intl.dart';

class UserSubscriptionDetailsWidget extends StatelessWidget with DateTimeUtilities {
  const UserSubscriptionDetailsWidget({super.key, required this.onSelectPlanTap});

  final Function() onSelectPlanTap;

  @override
  Widget build(BuildContext context) {
    final planDetails = context.select((SelectPlanCubit bloc) => bloc.planDetails);
    final isExpired = context.select((SelectPlanCubit bloc) => bloc.isExpired);

    return Stack(
      children: [
        BlocListener<SelectPlanCubit, SelectPlanState>(
          listener: (context, state) {
            if (state is GetBranchDetailsState && state.errorMessage.isNotEmpty) {
              context.showCustomeAlert(state.errorMessage, SnackBarType.error);
            }
          },
          child: ScrollableWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.sizedBoxHeightSmall,
                Row(
                  children: [
                    Text(
                      S.current.currentPlanDetails,
                      style: context.textTheme.titleMedium,
                    ),
                    context.sizedBoxWidthMicro,
                    IconButton(
                        onPressed: () => context.read<SelectPlanCubit>().getCurrentBranchPlanDetails(),
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.black,
                        )),
                  ],
                ),
                context.sizedBoxHeightExtraSmall,
                Container(
                  width: 500,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
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
                      if (!isExpired) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.iconsBoxIcon,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    planDetails?.packageName ?? '',
                                    style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: planDetails?.packagePrice.toString(),
                                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' ${planDetails?.currency.name}',
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(color: context.colorScheme.primaryColor),
                              ),
                              TextSpan(
                                  text:
                                      ' /${getDateDifferenceInMonth(planDetails?.subscriptionDate, planDetails?.expirationDate)} ${S.current.month}',
                                  style: context.textTheme.bodyMedium),
                            ])),
                          ],
                        ),
                        context.sizedBoxHeightSmall,
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.iconsClockIcon,
                              width: 20,
                              color: Colors.black,
                            ),
                            context.sizedBoxWidthMicro,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  S.current.dayRemaining,
                                  style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${planDetails?.daysRemaining} ${' ${S.current.days}'}',
                                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  S.current.trialPeriodRemainingDays(getDateDifferenceInDay(
                                          planDetails?.subscriptionDate,
                                          DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now())) +
                                      1),
                                  style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ))
                          ],
                        ),
                        context.sizedBoxHeightSmall,
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.iconsClockRenewIcon,
                              width: 20,
                            ),
                            context.sizedBoxWidthMicro,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  S.current.nextPayment,
                                  style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${'${S.current.on} '}${convertDateFormat(planDetails?.expirationDate, requestedFormet: "dd MMMM y", hasTime: false)}',
                                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ],
                    /*  if (isExpired) Text(S.current.subscriptionExpired),
                      context.sizedBoxHeightSmall,
                      Row(
                        children: [ todo:
                          Visibility(
                            visible: !isExpired,
                            child: Expanded(
                                child: RoundedBtnWidget(
                              onTap: onSelectPlanTap,
                              btnText: S.current.selectPlan,
                              height: 40,
                              btnMargin: const EdgeInsets.symmetric(horizontal: 10),
                              btnIcon: SvgPicture.asset(
                                Assets.iconsArrowIcon,
                                color: Colors.white,
                                width: 20,
                              ),
                            )),
                          ),
                          Visibility(
                            visible: isExpired,
                            child: Expanded(
                                child: RoundedBtnWidget(
                              onTap: onSelectPlanTap,
                              btnText: S.current.renewPlan,
                              height: 40,
                              btnMargin: const EdgeInsets.symmetric(horizontal: 10),
                              btnIcon: SvgPicture.asset(
                                Assets.iconsRefreshIcon,
                                color: Colors.white,
                                width: 20,
                              ),
                              bgColor: Colors.black,
                            )),
                          ),
                          *//*   Expanded(
                              child: RoundedBtnWidget(
                            onTap: () {},
                            height: 40,
                            btnMargin: const EdgeInsets.symmetric(horizontal: 10),
                            btnText: 'Unsubscribe',
                            btnIcon: SvgPicture.asset(
                              Assets.closeIcon,
                              color: Colors.black,
                              width: 20,
                            ),
                            bgColor: Colors.white,
                            btnTextColor: Colors.black,
                            boxBorder: Border.all(color: Colors.black),
                          )), *//*
                        ],
                      )*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        BlocBuilder<SelectPlanCubit, SelectPlanState>(
          builder: (context, state) => Visibility(
              visible: state is GetBranchDetailsState && state.isLoading, child: const LoadingWidget()),
        )
      ],
    );
  }
}
