import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/customers/presentation/widgets/desktop/desktop_search_customer_screen.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import '../widgets/mobile/mobile_search_customer_screen.dart';

class SearchCustomerScreen extends StatelessWidget {
  const SearchCustomerScreen({super.key, this.phoneNumber});

  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        desktopLayout: DesktopSearchCustomerScreen(phoneNumber: phoneNumber),
        webLayout: DesktopSearchCustomerScreen(phoneNumber: phoneNumber),
        mobileLayout: MobileSearchCustomerScreen(phoneNumber: phoneNumber),
        tabletLayout: MobileSearchCustomerScreen(phoneNumber: phoneNumber));
  }
}
