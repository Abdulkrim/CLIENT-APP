import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/desktop/stock_desktop_widget.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/mobile/stock_mobile_widget.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ResponsiveLayout(
            desktopLayout: StockDesktopWidget(),
            webLayout: StockDesktopWidget(),
            mobileLayout: StockMobileWidget(),
            tabletLayout: StockDesktopWidget()),
      ),
    );
  }
}
