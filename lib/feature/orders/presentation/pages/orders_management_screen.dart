import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/desktop/orders_management_desktop_widget.dart';
import 'package:merchant_dashboard/feature/orders/presentation/widgets/mobile/orders_management_mobile_widget.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';


class OrdersManagementScreen extends StatelessWidget {
  const OrdersManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
          child: ResponsiveLayout(
            desktopLayout: OrdersManagementDesktopWidget(),
            webLayout: OrdersManagementDesktopWidget(),
            mobileLayout: OrdersManagementMobileWidget(),
            tabletLayout: OrdersManagementDesktopWidget()
              ),
        );
  }
}
