import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../transaction/presentation/blocs/transaction_bloc.dart';
import '../../../transaction/presentation/widgets/transaction_details_list_widget.dart';

class TransactionDetailsDialog extends StatelessWidget {
  const TransactionDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        title: S.current.transactionDetails,
        width: !context.isPhone ? 450: null,
        height:  !context.isPhone ? 400: null,
        child: ScrollableWidget(
          scrollViewPadding: const EdgeInsets.all(20),
          child: BlocBuilder<TransactionBloc, TransactionState>(
              buildWhen: (previous, current) =>
                  current is GetTransactionDetailSuccessState || current is GetTransactionDetailsLoadingState,
              builder: (context, state) => (state is GetTransactionDetailSuccessState)
                  ? TransactionProductsListWidget(
                      details: state.transactionDetails,
                      showWorker: false,
                      onProductSelection: (selectedPIds) {},
                      isScrollable: false,
                    )
                  : const LoadingWidget()),
        ));
  }
}
