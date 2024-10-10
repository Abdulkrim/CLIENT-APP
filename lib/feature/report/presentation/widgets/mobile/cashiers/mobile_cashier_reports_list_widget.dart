import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/cashiers_reports.dart';

import '../../../../../../theme/theme_data.dart';


class MobileCashierReportsListWidge extends StatefulWidget {
  const MobileCashierReportsListWidge({
    Key? key,
    required this.cashiers,
    required this.hasMore,
    required this.getCashiers,
  }) : super(key: key);

  final Function(bool getMore) getCashiers;
  final List<CashierItemReport> cashiers;
  final bool hasMore;

  @override
  State<MobileCashierReportsListWidge> createState() => _MobileCashierReportsListWidgeState();
}

class _MobileCashierReportsListWidgeState extends State<MobileCashierReportsListWidge> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.getCashiers(true);
      }
    });
  }

  int selectedItemId = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.getCashiers(false);
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        primary: false,
        itemCount: (widget.hasMore && widget.cashiers.isNotEmpty)
            ? widget.cashiers.length + 1
            : widget.cashiers.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => (index < widget.cashiers.length)
            ? _MobileCashierItemWidget(cashier: widget.cashiers[index])
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class _MobileCashierItemWidget extends StatelessWidget {
  final CashierItemReport cashier;

  const _MobileCashierItemWidget({required this.cashier});

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            cashier.cashierName,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            cashier.totalSales.toString(),
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            cashier.tax.toString(),
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
