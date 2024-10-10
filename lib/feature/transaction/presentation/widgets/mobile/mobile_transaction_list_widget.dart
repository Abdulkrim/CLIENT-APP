import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/widgets/mobile/mobile_transaction_details_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/loading_widget.dart';

class MobileTransactionListWidget extends StatefulWidget {
  const MobileTransactionListWidget({
    Key? key,
    required this.transactions,
    required this.hasMore,
    required this.getTransactions,
  }) : super(key: key);

  final Function(bool getMore) getTransactions;
  final List<Transaction> transactions;
  final bool hasMore;

  @override
  State<MobileTransactionListWidget> createState() => _MobileTransactionListWidgetState();
}

class _MobileTransactionListWidgetState extends State<MobileTransactionListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        widget.getTransactions(true);
      }
    });
  }

  int selectedItemId = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.getTransactions(false);
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        primary: false,
        itemCount:
            (widget.hasMore && widget.transactions.isNotEmpty) ? widget.transactions.length + 1 : widget.transactions.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => (index < widget.transactions.length)
            ? _MobileTransactionItemWidget(
                transaction: widget.transactions[index],
                onViewDetailsTap: () {
                  setState(() => selectedItemId = selectedItemId = widget.transactions[index].transactionNo);
                  context.read<TransactionBloc>().add(GetTransactionDetailsEvent(widget.transactions[index].transactionNo));
                },
                selectedIemId: selectedItemId,
                closeDetailsTap: () => setState(() => selectedItemId = -1),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class _MobileTransactionItemWidget extends StatelessWidget with DownloadUtils {
  final Transaction transaction;
  final Function() onViewDetailsTap;
  final Function() closeDetailsTap;
  final int selectedIemId;

  const _MobileTransactionItemWidget(
      {required this.transaction, required this.onViewDetailsTap, required this.closeDetailsTap, required this.selectedIemId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.lightGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${S.current.cashier}- ${transaction.userName}",
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Text(
                transaction.date,
                textAlign: TextAlign.right,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          ...[transaction.param1Object, transaction.param2Object, transaction.param3Object]
              .map(
                (e) => Visibility(
                  visible: e.isEnabled,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "${e.paramHeader} - ${e.paramValue}",
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
              )
              .toList(),
          context.sizedBoxHeightMicro,
          Row(
            children: [
              Expanded(
                child: Text(
                  "${S.current.transactionNo} - ${transaction.transactionNo}",
                  textAlign: TextAlign.left,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Text(
                "${S.current.transactionOfflineId} - ${transaction.offlineTransactionId}",
                textAlign: TextAlign.left,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            children: [
              Expanded(
                child: Text(
                  "${S.current.voucher} - ${transaction.voucher}",
                  textAlign: TextAlign.left,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Visibility(
                visible: transaction.worker.trim().isNotEmpty,
                child: Expanded(
                  child: Text(
                    "${S.current.worker} ${transaction.worker}",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${S.current.payment} ${transaction.payment}",
                  textAlign: TextAlign.right,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            children: [
              Expanded(
                  child: Text(
                "${S.current.deliveryFee} = ${transaction.deliveryFinalPrice}",
                textAlign: TextAlign.left,
                style: context.textTheme.bodyMedium,
              )),
              Expanded(
                  child: Text(
                "${S.current.deliveryDiscount} = ${transaction.deliveryDiscountPrice.toStringAsFixed(2)}",
                textAlign: TextAlign.right,
                style: context.textTheme.bodyMedium,
              )),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            children: [
              Expanded(
                  child: Text(
                "${S.current.discount} = ${transaction.discountAmount}",
                textAlign: TextAlign.left,
                style: context.textTheme.bodyMedium,
              )),
              Expanded(
                  child: Text(
                "${S.current.price} = ${transaction.price.toStringAsFixed(2)}",
                textAlign: TextAlign.right,
                style: context.textTheme.bodyMedium,
              )),
            ],
          ),
          context.sizedBoxHeightMicro,
          Row(
            children: [
              Expanded(
                  child: Text(
                "${S.current.tax} = ${transaction.tax.toStringAsFixed(2)}",
                textAlign: TextAlign.left,
                style: context.textTheme.bodyMedium,
              )),
              Visibility(
                visible: !transaction.isClaimed,
                child: TextButton(
                  onPressed: () =>
                      context.read<TransactionBloc>().add(ClaimTransactionRequestEvent(transaction.transactionNo.toInt())),
                  child: Text(S.current.claim,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline)),
                ),
              ),
              TextButton(
                onPressed: () {
                  openLink(url: transaction.transactionUrl);
                },
                child: Text(S.current.download,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.blueAccent, decoration: TextDecoration.underline)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  TextButton(
                      onPressed: onViewDetailsTap,
                      child: Text(
                        S.current.viewDetails,
                        style: context.textTheme.titleSmall?.copyWith(decoration: TextDecoration.underline),
                      )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: transaction.transactionNo == selectedIemId,
                      child: IconButton(
                        onPressed: closeDetailsTap,
                        icon: const Icon(Icons.close_fullscreen_rounded),
                      ),
                    ),
                  ))
                ],
              ),
              context.sizedBoxHeightMicro,
              Visibility(
                visible: transaction.transactionNo == selectedIemId,
                child: BlocBuilder<TransactionBloc, TransactionState>(
                    buildWhen: (previous, current) =>
                        current is GetTransactionDetailSuccessState || current is GetTransactionDetailsLoadingState,
                    builder: (context, state) => (state is GetTransactionDetailSuccessState)
                        ? MobileTransactionDetailsWidget(
                            transaction: transaction,
                            details: state.transactionDetails,
                          )
                        : const LoadingWidget()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
