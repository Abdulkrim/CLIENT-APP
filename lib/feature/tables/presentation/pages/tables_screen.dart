import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../widgets/desktop/desktop_tables_management.dart';
import '../widgets/mobile/mobile_tables_management.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return    const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: DesktopTablesManagement(),
        webLayout: DesktopTablesManagement(),
        mobileLayout: MobileTablesManagement(),
        tabletLayout: DesktopTablesManagement(),
      ),
    );
  }
}
