import 'package:flutter/material.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import '../widgets/desktop/desktop_signup_setup_guide_screen.dart';

class SignupSetupGuideScreen extends StatelessWidget {
  const SignupSetupGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  ResponsiveLayout(
        desktopLayout: DesktopSignupSetupGuideScreen(),
        webLayout: DesktopSignupSetupGuideScreen(),
        mobileLayout: DesktopSignupSetupGuideScreen(),
        tabletLayout: DesktopSignupSetupGuideScreen(),
      ),
    );
  }
}
