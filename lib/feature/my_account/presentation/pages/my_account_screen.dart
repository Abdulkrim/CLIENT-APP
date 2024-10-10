import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/widgets/desktop/my_account_desktop_widget.dart';
import 'package:merchant_dashboard/feature/my_account/presentation/widgets/mobile/my_account_mobile_widget.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        desktopLayout: MyAccountDesktopWidget(),
        webLayout: MyAccountDesktopWidget(),
        mobileLayout: MyAccountMobileWidget(),
        tabletLayout: MyAccountMobileWidget());
  }
}
