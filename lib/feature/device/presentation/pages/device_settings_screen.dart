import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../widgets/device_settings_widget.dart';

class DeviceSettingsScreen extends StatelessWidget {
  const DeviceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child:   DeviceSettingsWidget()
    );
  }
}
