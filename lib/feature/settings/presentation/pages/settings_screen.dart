import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../widgets/parameter_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child:  ParameterSettingsScreen()
    );
  }
}
