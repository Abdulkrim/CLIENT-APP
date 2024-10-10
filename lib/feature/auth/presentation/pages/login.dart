import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/auth/presentation/widgets/mobile/mobile_login.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import '../widgets/desktop/desktop_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, this.isSignUpDefault = false}) : super(key: key);

  final bool isSignUpDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveLayout(
      desktopLayout: DeskTopLoginScreen(isSignUpDefault: isSignUpDefault),
      webLayout: DeskTopLoginScreen(isSignUpDefault: isSignUpDefault),
      mobileLayout: MobileLoginScreen(isSignUpDefault: isSignUpDefault),
      tabletLayout: MobileLoginScreen(isSignUpDefault: isSignUpDefault),
    ));
  }
}
