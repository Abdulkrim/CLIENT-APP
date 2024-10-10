import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import 'desktop_business_hours_screen.dart';
import 'mobile_business_hours_screen.dart';

class BusinessHoursScreen extends StatelessWidget {
  const BusinessHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: DesktopBusinessHoursScreen(),
        mobileLayout: MobileBusinessHoursScreen(),
        tabletLayout: DesktopBusinessHoursScreen(),
        webLayout: DesktopBusinessHoursScreen(),
      ),
    );
  }
}
