import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/subscription_plan.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import '../widgets/desktop/desktop_select_plan_widget.dart';

class SelectPlanScreen extends StatelessWidget {
  const SelectPlanScreen({super.key, required this.onBackButtonTap, required this.onPlanSelected});

  final Function() onBackButtonTap;
  final Function(SubscriptionPlan selectedPlan) onPlanSelected;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopLayout: DesktopSelectPlanWidget(
        onBackButtonTap: onBackButtonTap,
        onPlanSelected: onPlanSelected,
      ),
      webLayout: DesktopSelectPlanWidget(
        onBackButtonTap: onBackButtonTap,
        onPlanSelected: onPlanSelected,
      ),
      mobileLayout: DesktopSelectPlanWidget(
        onBackButtonTap: onBackButtonTap,
        onPlanSelected: onPlanSelected,
      ),
      tabletLayout: DesktopSelectPlanWidget(
        onBackButtonTap: onBackButtonTap,
        onPlanSelected: onPlanSelected,
      ),
    );
  }
}
