import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/products_reports.dart';

import '../../../../../../theme/theme_data.dart';


class MobileProductReportsListWidge extends StatefulWidget {
  const MobileProductReportsListWidge({
    Key? key,
    required this.products,
    required this.hasMore,
    required this.getProducts,
  }) : super(key: key);

  final Function(bool getMore) getProducts;
  final List<ProductItemReport> products;
  final bool hasMore;

  @override
  State<MobileProductReportsListWidge> createState() => _MobileProductReportsListWidgeState();
}

class _MobileProductReportsListWidgeState extends State<MobileProductReportsListWidge> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.getProducts(true);
      }
    });
  }

  int selectedItemId = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.getProducts(false);
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        primary: false,
        itemCount: (widget.hasMore && widget.products.isNotEmpty)
            ? widget.products.length + 1
            : widget.products.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => (index < widget.products.length)
            ? _MobileProductItemWidget(product: widget.products[index])
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class _MobileProductItemWidget extends StatelessWidget {
  final ProductItemReport product;

  const _MobileProductItemWidget({required this.product});

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
            product.itemName,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            product.subcategory.toString(),
            style: context.textTheme.bodyMedium,
          ),
          Text(
            product.total.toString(),
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            product.tax.toString(),
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
