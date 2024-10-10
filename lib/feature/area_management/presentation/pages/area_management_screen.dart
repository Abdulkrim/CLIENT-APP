import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import '../../../../widgets/general_dropdown_checker.dart';
import 'desktop_area_management_screen.dart';

class AreaManagementScreen extends StatelessWidget {
  const AreaManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
          desktopLayout: DesktopAreaManagementScreen(),
          webLayout: DesktopAreaManagementScreen(),
          mobileLayout: DesktopAreaManagementScreen(),
          tabletLayout: DesktopAreaManagementScreen()),
    );
  }
}
