import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stocks.dart';
import 'package:merchant_dashboard/feature/stock/presentation/blocs/stock_bloc.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/decrease_stock_dialog.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/increase_stock_dialog.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/item_rich_text_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/network_image_rounded_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/loading_widget.dart';
import '../stock_details_dialog.dart';

class DesktopStockListWidget extends StatefulWidget {
  final List<StockInfo> stocks;
  final int gridItemCount;

  const DesktopStockListWidget(
      {Key? key, required this.stocks, this.gridItemCount = 4})
      : super(key: key);

  @override
  State<DesktopStockListWidget> createState() => _DesktopStockListWidgetState();
}

class _DesktopStockListWidgetState extends State<DesktopStockListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context
            .read<StockBloc>()
            .add(const GetAllStockRequestEvent(getMore: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      scrollController: _scrollController,
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.gridItemCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: .9),
            itemCount: widget.stocks.length,
            itemBuilder: (context, index) =>
                DesktopStockListItemWidget(stock: widget.stocks[index]),
          ),
          Visibility(
              visible: context.select<StockBloc, bool>(
                  (value) => value.stocksPagination.hasMore),
              child: const CupertinoActivityIndicator()),
        ],
      ),
    );
  }
}

class DesktopStockListItemWidget extends StatelessWidget {
  final StockInfo stock;

  const DesktopStockListItemWidget({
    Key? key,
    required this.stock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () async {
        final res = await Get.dialog(BlocProvider.value(
          value: BlocProvider.of<StockBloc>(context),
          child: StockDetailsDialog(
            stock: stock,
          ),
        ));

        if (res == true) {
          context.read<StockBloc>().add(const GetAllStockRequestEvent(isRefreshing: true));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: BlocBuilder<StockBloc, StockState>(
                  buildWhen: (previous, current) =>
                      current is GetStockItemExcelReportLink,
                  builder: (context, state) =>
                      (state is GetStockItemExcelReportLink && state.isLoading)
                          ? const SizedBox(
                              height: 30, width: 30, child: LoadingWidget())
                          : RoundedBtnWidget(
                              onTap: () {
                                context.read<StockBloc>().add(
                                    GetExportExcelLinkItem(
                                        itemStockId: stock.itemStock!.id));
                              },
                              btnText: "",
                              btnPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              btnIcon: const Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 18,
                              ),
                            )),
            ),
            Expanded(
              child: NetworkImageRounded(
                url: stock.image,
                width: double.infinity,
              ),
            ),
            context.sizedBoxHeightExtraSmall,
            ItemRichTextWidget(
              rText: S.current.category,
              lText: stock.subCategoryNameEn,
            ),
            context.sizedBoxHeightExtraSmall,
            ItemRichTextWidget(
              rText: S.current.name,
              lText: stock.itemNameEN,
            ),
            context.sizedBoxHeightExtraSmall,
            Text(
              '${stock.quantity}${' ${S.current.items}'}',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            context.sizedBoxHeightExtraSmall,
            Row(
              children: [
                RoundedBtnWidget(
                  onTap: () {
                    Get.dialog(BlocProvider.value(
                      value: BlocProvider.of<StockBloc>(context),
                      child: IncreaseStockDialog(
                        stock: stock,
                        width: 450,
                        height: 500,
                      ),
                    ));
                  },
                  btnText: S.current.increase,
                  btnPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                RoundedBtnWidget(
                  onTap: () {
                    Get.dialog(BlocProvider.value(
                      value: BlocProvider.of<StockBloc>(context),
                      child: DecreaseStockDialog(
                        stockId: stock.itemStock!.id,
                        currentStockQuantity: stock.quantity,
                        width: 450,
                        height: 500,
                      ),
                    ));
                  },
                  btnText: S.current.decrease,
                  bgColor: Colors.white,
                  btnTextColor: context.colorScheme.primaryColor,
                  boxBorder:
                      Border.all(color: context.colorScheme.primaryColor),
                  btnPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
