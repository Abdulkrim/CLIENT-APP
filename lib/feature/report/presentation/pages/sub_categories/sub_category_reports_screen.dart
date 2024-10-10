import 'package:flutter/material.dart';

import '../../../../../utils/screenUtils/responsive.dart';
import 'desktop_sub_catgory_reports_screen.dart';
import 'mobile_sub_category_reports_screen.dart';

class SubCategoryReportScreen extends StatelessWidget {
  const SubCategoryReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      desktopLayout: DesktopSubCategoryReportsScreen(),
      webLayout: DesktopSubCategoryReportsScreen(),
      mobileLayout: MobileSubCategoryReportsScreen(),
      tabletLayout: DesktopSubCategoryReportsScreen(),
    );
  }
}
