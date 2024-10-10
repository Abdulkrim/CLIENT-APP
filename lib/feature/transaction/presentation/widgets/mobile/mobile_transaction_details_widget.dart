import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../data/models/entity/transaction_details.dart';
import '../transaction_details_list_widget.dart';

class MobileTransactionDetailsWidget extends StatelessWidget {
  final Transaction transaction;
  List<int> selectedDetailsIds = [];
  final List<TransactionDetails> details;

  MobileTransactionDetailsWidget({Key? key, required this.transaction, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionProductsListWidget(
          details: details,
          showWorker: transaction.worker.trim().isEmpty,
          onProductSelection: (selectedPIds) {
            selectedDetailsIds = selectedPIds;
          },
          isScrollable: false,
        ),
        Text(
         S.current.total + '= ' "${transaction.total.toStringAsFixed(2)}",
          textAlign: TextAlign.right,
          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        context.sizedBoxHeightExtraSmall,
      ],
    );
  }
}
