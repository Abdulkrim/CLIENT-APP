import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../widgets/desktop/desktop_subscription_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ResponsiveLayout(
          desktopLayout: DesktopSubscriptionWidget(),
          webLayout: DesktopSubscriptionWidget(),
          mobileLayout: DesktopSubscriptionWidget(),
          tabletLayout: DesktopSubscriptionWidget(),
        ),
      ),
    );
  }
}
