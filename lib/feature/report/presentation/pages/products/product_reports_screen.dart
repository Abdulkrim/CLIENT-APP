import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/report/presentation/pages/products/desktop_product_reports_screen.dart';

import '../../../../../utils/screenUtils/responsive.dart';
import 'mobile_product_reports_screen.dart';

class ProductReportsScreen extends StatelessWidget {
  const ProductReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopLayout: DesktopProductReportsScreen(),
      webLayout: DesktopProductReportsScreen(),
      mobileLayout: const MobileProductReportsScreen(),
      tabletLayout: DesktopProductReportsScreen(),
    );
  }
}
