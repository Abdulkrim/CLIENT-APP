import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import 'desktop_categorized_reports_screen.dart';

class CategorizedReportsScreen extends StatelessWidget {
  const CategorizedReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      desktopLayout: DesktopCategorizedReportsScreen(),
      webLayout: DesktopCategorizedReportsScreen(),
      mobileLayout:  DesktopCategorizedReportsScreen(),
      tabletLayout:  DesktopCategorizedReportsScreen(),
    );
  }
}
