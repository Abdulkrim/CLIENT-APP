import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/desktop/cashier_desktop_widget.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/mobile/cashier_mobile_widget.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

class CashiersScreen extends StatelessWidget {
  const CashiersScreen({Key? key}) : super(key: key);
  final bool showSetupGuide = false;
  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: CashierDesktopWidget(),
        webLayout: CashierDesktopWidget(),
        mobileLayout: CashierMobileWidget(),
        tabletLayout: CashierDesktopWidget(),
      ),
    );
  }
}
