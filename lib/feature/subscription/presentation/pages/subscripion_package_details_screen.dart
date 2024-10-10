import 'package:flutter/material.dart';

import '../../../../utils/screenUtils/responsive.dart';
import '../widgets/desktop/subscription_package_details/desktop_subscription_package_details_widget.dart';

class SubscriptionPackageDetatilsScreen extends StatelessWidget {
  const SubscriptionPackageDetatilsScreen(
      {super.key, required this.onBackButtonTap, required this.goPlanDetailsPage});

  final Function() onBackButtonTap;
  final Function() goPlanDetailsPage;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopLayout: DesktopSubscriptionPackageDetailsWidget(
        onBackButtonTap: onBackButtonTap,
        goPlanDetailsPage: goPlanDetailsPage,
      ),
      webLayout: DesktopSubscriptionPackageDetailsWidget(
        onBackButtonTap: onBackButtonTap,
        goPlanDetailsPage: goPlanDetailsPage,
      ),
      mobileLayout: DesktopSubscriptionPackageDetailsWidget(
        onBackButtonTap: onBackButtonTap,
        goPlanDetailsPage: goPlanDetailsPage,
      ),
      tabletLayout: DesktopSubscriptionPackageDetailsWidget(
        onBackButtonTap: onBackButtonTap,
        goPlanDetailsPage: goPlanDetailsPage,
      ),
    );
  }
}
