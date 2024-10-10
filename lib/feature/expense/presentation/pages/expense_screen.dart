import 'package:flutter/material.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';
import '../../../../utils/screenUtils/responsive.dart';
import '../widgets/desktop/expenses_desktop_widget.dart';
import '../widgets/mobile/expense_mobile_widget.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GeneralDropdownChecker(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ResponsiveLayout(
          desktopLayout: ExpensesDesktopWidget(),
          webLayout: ExpensesDesktopWidget(),
          mobileLayout: ExpensesMobileWidget(),
          tabletLayout: ExpensesDesktopWidget(),
        ),
      ),
    );
  }
}
