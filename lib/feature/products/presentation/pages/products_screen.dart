import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';

import '../../../../utils/screenUtils/responsive.dart';
import '../blocs/products/products_bloc.dart';
import '../widgets/desktop/desktop_products.dart';
import '../widgets/mobile/products_screen_mobile.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  final bool showSetupGuide = false;

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: ResponsiveLayout(
        desktopLayout: DesktopProducts(),
        webLayout: DesktopProducts(),
        mobileLayout: DesktopProducts(),
        tabletLayout: DesktopProducts(),
      ),
    );
  }
}
