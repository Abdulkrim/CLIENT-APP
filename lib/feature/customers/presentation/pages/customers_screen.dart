import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/customers/presentation/widgets/desktop/customer_desktop_widget.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../widgets/mobile/customer_mobile_widget.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({Key? key}) : super(key: key);
  final bool showSetupGuide = false;

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
     child:  ResponsiveLayout(
       desktopLayout: CustomerDesktopWidget(),
       webLayout: CustomerDesktopWidget(),
       mobileLayout: CustomerMobileWidget(),
       tabletLayout: CustomerDesktopWidget(),
     ),
    );
  }
}
