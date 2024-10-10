import 'package:flutter/material.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../../../../utils/screenUtils/responsive.dart';
import '../widgets/desktop/desktop_online_ordering_screen.dart';

class OnlineOrderingScreen extends StatelessWidget {

  const OnlineOrderingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const   GeneralDropdownChecker(
      child: DesktopOnlineOrderingScreen()
    );
  }
}
