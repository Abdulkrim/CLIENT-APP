import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant_dashboard/feature/dashboard/presentation/widgets/desktop/desktop_top_bar_options.dart';
import 'package:merchant_dashboard/feature/dashboard/presentation/widgets/mobile/mobile_order_pie_chart_section_widget.dart';
import 'package:merchant_dashboard/feature/dashboard/presentation/widgets/mobile/mobile_orders_transactions_tab_widget.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/routes/app_routes.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../auth/presentation/pages/login.dart';
import '../../../expense/presentation/widgets/expense_list_box_widget.dart';
import '../blocs/dashboard_bloc.dart';
import '../widgets/mobile/mobile_floating_buttons_widget.dart';
import '../widgets/mobile/mobile_pie_chart_section_widget.dart';
import '../widgets/mobile/mobile_total_sales_section_widget.dart';
import '../widgets/mobile/mobile_reports_section_widget.dart';
import '../widgets/mobile/mobile_sales_bar_chart_section.dart';
import '../widgets/mobile/mobile_worker_sales_section_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final bool showSetupGuide = context.select((DashboardBloc bloc) => bloc.showGuide);

    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: DesktopBody(),
        webLayout: DesktopBody(),
        mobileLayout: MobileBody(),
        tabletLayout: MobileBody(),
      ),
    );
  }
}

class DesktopBody extends StatelessWidget {
  const DesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(

      scrollViewPadding: const EdgeInsets.all(20.0),
      child: BlocListener<MenuDrawerCubit, MenuDrawerState>(
        listener: (context, state) {
          if (state is UserSubscriptionStatusesState) {
            if (state.msg != null) {
              context.showCustomeAlert(state.msg, SnackBarType.error);
            }
            if (state.shouldLogout) Get.offAll(() => const LoginScreen());
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.watch<MenuDrawerCubit>().selectedPageContent.text,
                      style: context.textTheme.titleLarge,
                    ),
                    context.sizedBoxWidthMicro,
                    IconButton(
                        onPressed: () {
                          context.read<DashboardBloc>().add(const GetTodayDataEvent());
                        },
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.black,
                        )),
                  ],
                ),
                BlocBuilder<SelectPlanCubit, SelectPlanState>(
                  builder: (context, state) {
                    return context.read<SelectPlanCubit>().planDetails != null
                        ? AppInkWell(
                            onTap: () => context.read<MenuDrawerCubit>().forceRedirectToSubscriptionPage(),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12, bottom: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.lightGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Lottie.asset(Assets.animsTimer, height: 30),
                                  context.sizedBoxWidthMicro,
                                  Text(
                                    '${context.read<SelectPlanCubit>().planDetails?.packageName} Expires in ${context.read<SelectPlanCubit>().planDetails?.daysRemaining} Days',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  context.sizedBoxWidthMicro,
                                  const SizedBox(
                                      height: 20,
                                      child: VerticalDivider(
                                        thickness: 1,
                                        color: Colors.black,
                                      )),
                                  context.sizedBoxWidthMicro,
                                  Text(
                                    'Select Plan',
                                    style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primaryColor),
                                  ),
                                  context.sizedBoxWidthMicro,
                                  const Icon(Icons.arrow_forward, size: 15),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                )
              ],
            ),
            DesktopTopBarOptionsWidget(),
            context.sizedBoxHeightExtraSmall,
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0f000000),
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      const Expanded(child: MobileTotalSalesSectionWidget()),
                      context.sizedBoxWidthSmall,
                      const Expanded(flex: 2, child: MobileSalesBarChartWidget(chartRatio: 1.7)),
                    ],
                  ),
                ),
                context.sizedBoxHeightDefault,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: MobileReportsSectionWidget()),
                    context.sizedBoxWidthMicro,
                    const Expanded(child: MobileWorkerSalesSectionWidget()),
                    context.sizedBoxWidthMicro,
                    const Expanded(flex: 2, child: MobileOrdersTransactionsTabWidget()),
                  ],
                ),
                context.sizedBoxHeightExtraSmall,
                Row(
                  children: [
                    const Expanded(child: TopSalesProductsPieChartWidget()),
                    context.sizedBoxWidthExtraSmall,
                    const Expanded(child: TopOrderProductsPieChartWidget()),
                  ],
                ),
                context.sizedBoxHeightExtraSmall,
                const ExpenseListBoxWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MobileBody extends StatelessWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<DashboardBloc>().add(const GetTodayDataEvent());
            return Future.delayed(const Duration(seconds: 2));
          },
          child: ScrollableWidget(
            scrollViewPadding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.watch<MenuDrawerCubit>().selectedPageContent.text,
                      style: context.textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () => Get.toNamed(AppRoutes.customerSearchRoute),
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    context.sizedBoxHeightExtraSmall,
                    const MobileTotalSalesSectionWidget(),
                    context.sizedBoxHeightLarge,
                    const MobileSalesBarChartWidget(),
                    context.sizedBoxHeightExtraSmall,
                    const MobileReportsSectionWidget(),
                    context.sizedBoxHeightExtraSmall,
                    const MobileWorkerSalesSectionWidget(),
                    context.sizedBoxHeightExtraSmall,
                    const MobileOrdersTransactionsTabWidget(),
                    context.sizedBoxHeightSmall,
                    const TopSalesProductsPieChartWidget(),
                    context.sizedBoxHeightSmall,
                    const TopOrderProductsPieChartWidget(),
                    context.sizedBoxHeightSmall,
                    const ExpenseListBoxWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const MobileFloatingButtons());
  }
}
