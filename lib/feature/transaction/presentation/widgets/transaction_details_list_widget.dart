import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../data/models/entity/transaction_details.dart';

class TransactionProductsListWidget extends StatefulWidget {
  final List<TransactionDetails> details;
  final Function(List<int>) onProductSelection;
  final bool showWorker;
  final bool isScrollable;

  const TransactionProductsListWidget({
    Key? key,
    required this.details,
    required this.onProductSelection,
    required this.isScrollable,
    required this.showWorker,
  }) : super(key: key);

  @override
  State<TransactionProductsListWidget> createState() => _TransactionProductsListWidgetState();
}

class _TransactionProductsListWidgetState extends State<TransactionProductsListWidget> {
  final List<int> selectedPIds = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: (!widget.isScrollable),
      physics: (!widget.isScrollable) ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
      children: widget.details
          .map((e) => Column(
                children: [
                  context.sizedBoxHeightMicro,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${e.productType} - ${e.productName}",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("Quantity - ${e.quantity}", textAlign: TextAlign.end, style: context.textTheme.titleSmall),
                    ],
                  ),
                  context.sizedBoxHeightMicro,
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Category - ${e.category}",
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                        Text("Price - ${e.price}", textAlign: TextAlign.end, style: context.textTheme.titleSmall),
                      ],
                    ),
                  ),
                  context.sizedBoxHeightMicro,
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Sub Category - ${e.subCategory}",
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                        Visibility(
                          visible: true,
                          child: Text("Total - ${e.total}", textAlign: TextAlign.end, style: context.textTheme.titleSmall),
                        ),
                      ],
                    ),
                  ),
                  context.sizedBoxHeightMicro,
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Visibility(
                        visible: widget.showWorker && e.worker.trim().isNotEmpty,
                        child: Text(
                          "Worker - ${e.worker}",
                          style: context.textTheme.titleSmall,
                        ),
                      )),
                  context.sizedBoxHeightExtraSmall,
                ],
              ))
          .toList(),
    );
  }
}
