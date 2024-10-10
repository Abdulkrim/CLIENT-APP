import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import 'desktop_cashier_reports_screen.dart';
import 'mobile_cashier_reports_screen.dart';

class CashiserReportsScreen extends StatelessWidget {
  const CashiserReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      desktopLayout: DesktopCashierReportsScreen(),
      webLayout: DesktopCashierReportsScreen(),
      mobileLayout: MobileCashierReportsScreen(),
      tabletLayout: DesktopCashierReportsScreen(),
    );
  }
}
