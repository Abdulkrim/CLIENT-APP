import 'package:flutter/material.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../../../../utils/screenUtils/responsive.dart';
import '../widgets/desktop/desktop_main_categories.dart';
import '../widgets/mobile/mobile_main_categories.dart';

class MainCategoriesScreen extends StatelessWidget {
  const MainCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: DesktopMainCategories(),
        webLayout: DesktopMainCategories(),
        mobileLayout: MobileMainCategories(),
        tabletLayout: DesktopMainCategories(),
      ),
    );
  }
}
