import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/desktop/desktop_sub_categories.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/mobile/mobile_sub_categories.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../../../../utils/screenUtils/responsive.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: DesktopSubCategories(),
        webLayout: DesktopSubCategories(),
        mobileLayout: MobileSubCategories(),
        tabletLayout: DesktopSubCategories(),
      ),
    );
  }
}
