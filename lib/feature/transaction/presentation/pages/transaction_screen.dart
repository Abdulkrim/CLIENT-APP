import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/pages/transaction_desktop_widget.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/pages/transaction_mobile_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/general_dropdown_checker.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) async {
        switch (state) {
          case WrongDateFilterRangeEnteredState():
            context.showCustomeAlert(
                'Your selected first date ${state.fromDate} is bigger than selected second date ${state.toDate}');
          case ClaimTransactionStates():
            context.showCustomeAlert(state.error != null ? state.error! : S.current.transactionClaimedSuccessfully,
                state.error != null ? SnackBarType.error : SnackBarType.success);
          case GetDownloadLinkStates() when state.link.isNotEmpty:
            (kIsWeb)
                ? await launchUrl(Uri.parse(state.link), webOnlyWindowName: "_blank")
                : await launchUrl(Uri.parse(state.link), mode: LaunchMode.externalApplication);
          case GetDownloadLinkStates() when state.errorMsg.isNotEmpty:
            context.showCustomeAlert(state.errorMsg, SnackBarType.error);
        }
      },
      child: const GeneralDropdownChecker(
        child:   Padding(
          padding: EdgeInsets.all(20),
          child: ResponsiveLayout(
            desktopLayout: TransactionDesktopWidget(),
            webLayout: TransactionDesktopWidget(),
            mobileLayout: TransactionMobileWidget(),
            tabletLayout: TransactionMobileWidget(),
          ),
        ),
      ),
    );
  }
}
