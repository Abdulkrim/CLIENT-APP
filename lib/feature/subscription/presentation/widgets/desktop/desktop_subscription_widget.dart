import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/pages/select_plan_screen.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../pages/subscripion_package_details_screen.dart';
import 'user_subscription_details_widget.dart';

class DesktopSubscriptionWidget extends StatefulWidget {
  const DesktopSubscriptionWidget({super.key});

  @override
  State<DesktopSubscriptionWidget> createState() => _DesktopSubscriptionWidgetState();
}

class _DesktopSubscriptionWidgetState extends State<DesktopSubscriptionWidget> with TickerProviderStateMixin {
  late final TabController _tabController;

  late final PageController _pageViewController;

  @override
  void initState() {
    super.initState();

    context.read<SelectPlanCubit>()
      .getCurrentBranchPlanDetails();

    _tabController = TabController(length: 2, vsync: this);
    _pageViewController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
          controller: _pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
                context.sizedBoxHeightSmall,
                TabBar(
                    padding: const EdgeInsets.all(0),
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        text: S.current.subscriptionPlane,
                      ),
                      /*Tab(
                              text: S.current.yourBillingHistory,
                            ),*/
                    ]),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        UserSubscriptionDetailsWidget(
                          onSelectPlanTap: () => _pageViewController.jumpToPage(1),
                        ),
                        // const BillingHistoryScreen(),
                      ]),
                ),
              ],
            ),
            SelectPlanScreen(
              onBackButtonTap: () => _pageViewController.jumpToPage(0),
              onPlanSelected: (selectedPlan) {
                context.read<SelectPlanCubit>().getSubscriptionPackageDetails(selectedPlan);
                _pageViewController.jumpToPage(2);
              },
            ),
            SubscriptionPackageDetatilsScreen(
              onBackButtonTap: () => _pageViewController.jumpToPage(1),
              goPlanDetailsPage: () => _pageViewController.jumpToPage(0),
            ),
          ]),
    );
  }
}
