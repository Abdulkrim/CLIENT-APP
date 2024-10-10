import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/workers/presentation/widgets/mobile/worker_mobile_widget.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../../../../utils/screenUtils/responsive.dart';
import '../widgets/desktop/worker_desktop_widget.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: WorkerDesktopWidget(),
        webLayout: WorkerDesktopWidget(),
        mobileLayout: WorkerMobileWidget(),
        tabletLayout: WorkerDesktopWidget(),
      ),
    );
  }
}
