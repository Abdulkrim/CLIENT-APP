import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/sub_categories_reports.dart';

import '../../../../../../theme/theme_data.dart';


class MobileSubCategoryReportsListWidge extends StatefulWidget {
  const MobileSubCategoryReportsListWidge({
    Key? key,
    required this.subCategories,
    required this.hasMore,
    required this.getSubCategories,
  }) : super(key: key);

  final Function(bool getMore) getSubCategories;
  final List<SubCategoryItemReport> subCategories;
  final bool hasMore;

  @override
  State<MobileSubCategoryReportsListWidge> createState() => _MobileSubCategoryReportsListWidgeState();
}

class _MobileSubCategoryReportsListWidgeState extends State<MobileSubCategoryReportsListWidge> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.getSubCategories(true);
      }
    });
  }

  int selectedItemId = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.getSubCategories(false);
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        primary: false,
        itemCount: (widget.hasMore && widget.subCategories.isNotEmpty)
            ? widget.subCategories.length + 1
            : widget.subCategories.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => (index < widget.subCategories.length)
            ? _MobileSubCategoryItemWidget(subCategories: widget.subCategories[index])
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class _MobileSubCategoryItemWidget extends StatelessWidget {
  final SubCategoryItemReport subCategories;

  const _MobileSubCategoryItemWidget({required this.subCategories});

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
            subCategories.subName,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            subCategories.categoryName,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            subCategories.total.toString(),
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium,
          ),
          Text(
            subCategories.tax.toString(),
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
