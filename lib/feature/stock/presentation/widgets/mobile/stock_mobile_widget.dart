import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stocks.dart';
import 'package:merchant_dashboard/feature/stock/presentation/blocs/stock_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/search_box_widget.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/mobile/mobile_sort_order_filter_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/app_ink_well_widget.dart';
import '../../../../../widgets/item_rich_text_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/network_image_rounded_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../decrease_stock_dialog.dart';
import '../increase_stock_dialog.dart';
import '../stock_details_dialog.dart';
import '../stock_statisttics_item_widget.dart';

class StockMobileWidget extends StatefulWidget {
  const StockMobileWidget({Key? key}) : super(key: key);

  @override
  State<StockMobileWidget> createState() => _StockMobileWidgetState();
}

class _StockMobileWidgetState extends State<StockMobileWidget>
    with DownloadUtils {
  final ScrollController _scrollController = ScrollController();
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // For when user go back and then open this page
    context.read<StockBloc>().manageLastSearch();

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
    List<StockInfo> stocks = context.select<StockBloc, List<StockInfo>>(
        (value) => value.stocksPagination.listItems);
    bool hasMore = (context
        .select<StockBloc, bool>((value) => value.stocksPagination.hasMore));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.watch<MenuDrawerCubit>().selectedPageContent.text,
              style: context.textTheme.titleLarge,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        isDismissible: false,
                        BlocProvider.value(
                            value: BlocProvider.of<StockBloc>(context),
                            child: const MobileSortOrderFilterWidget()));
                  },
                  padding: const EdgeInsets.all(16),
                  icon: SvgPicture.asset(Assets.iconsSort, height: 20),
                ),
                BlocConsumer<StockBloc, StockState>(
                    listener: (context, state) {
                      if (state is GetStockExcelReportLink && state.isSuccess) {
                        openLink(
                            url:
                                context.read<StockBloc>().exportStockExcelLink);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is GetStockExcelReportLink,
                    builder: (context, state) =>
                        (state is GetStockExcelReportLink && state.isLoading)
                            ? const LoadingWidget()
                            : RoundedBtnWidget(
                                onTap: () {
                                  context
                                      .read<StockBloc>()
                                      .add(const GetExportExcelLink());
                                },
                                btnText: S.current.downloadStockReport,
                                btnPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                              )),
              ],
            ),
          ],
        ),
        context.sizedBoxHeightMicro,
        SizedBox(
          width: Get.width * 0.9,
          height: 40,
          child: SearchBoxWidget(
            searchTextController: _searchTextController,
            showBarcodeScanner: true,
            onSearchTapped: (String? text) => context
                .read<StockBloc>()
                .add(GetAllStockRequestEvent(searchText: (text ?? ''))),
          ),
        ),
        context.sizedBoxHeightSmall,
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              context.read<StockBloc>().add(const GetAllStockRequestEvent());
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StockStatistticsItemWidget(
                    iconBGcolor: const Color(0xFFCFE7FF),
                    textColor: const Color(0xFF0066CC),
                    iconName: Assets.iconsEmptyBox,
                    boxValue: context.select<StockBloc, String>(
                        (value) => value.stockStatistics?.totalItems ?? '-'),
                    boxTitle: S.current.totalItems,
                  ),
                  StockStatistticsItemWidget(
                    iconBGcolor: const Color(0xFFFFEBB2),
                    textColor: const Color(0xFFFFBC02),
                    iconName: Assets.iconsFullBox,
                    boxValue: context.select<StockBloc, String>(
                        (value) => value.stockStatistics?.totalQuantity ?? '-'),
                    boxTitle: S.current.totalQuantity,
                  ),
                  StockStatistticsItemWidget(
                    iconBGcolor: const Color(0xFFD6F4D6),
                    textColor: const Color(0xFF35C635),
                    iconName: Assets.iconsMoneyBag,
                    boxValue: context.select<StockBloc, String>(
                        (value) => value.stockStatistics?.totalValue ?? '-'),
                    boxTitle: S.current.totalProductValue,
                  ),
                  context.sizedBoxHeightSmall,
                  BlocBuilder<StockBloc, StockState>(
                      builder: (context, state) =>
                          (state is AllStocksLoadingState)
                              ? const LoadingWidget()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: hasMore
                                      ? stocks.length + 1
                                      : stocks.length,
                                  itemBuilder: (context, index) =>
                                      (index < stocks.length)
                                          ? MobileStockListItemWidget(
                                              stock: stocks[index])
                                          : const CupertinoActivityIndicator(),
                                )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// todo add button download stack detail
class MobileStockListItemWidget extends StatelessWidget {
  final StockInfo stock;

  const MobileStockListItemWidget({
    Key? key,
    required this.stock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final res = await Get.dialog(BlocProvider.value(
          value: BlocProvider.of<StockBloc>(context),
          child: StockDetailsDialog(
            stock: stock,
          ),
        ));

        if (res == true)
          context
              .read<StockBloc>()
              .add(const GetAllStockRequestEvent(isRefreshing: true));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NetworkImageRounded(
              width: Get.width * 0.25,
              height: 200,
              url: stock.image,
              radius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            context.sizedBoxWidthExtraSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  context.sizedBoxHeightExtraSmall,
                  Row(
                    children: [
                      RoundedBtnWidget(
                        onTap: () {
                          Get.to(BlocProvider.value(
                            value: BlocProvider.of<StockBloc>(context),
                            child: IncreaseStockDialog(
                              stock: stock,
                            ),
                          ));
                        },
                        btnText: S.current.increase,
                        btnPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                      RoundedBtnWidget(
                        onTap: () {
                          Get.to(BlocProvider.value(
                            value: BlocProvider.of<StockBloc>(context),
                            child: DecreaseStockDialog(
                              stockId: stock.itemStock!.id,
                              currentStockQuantity: stock.quantity,
                            ),
                          ));
                        },
                        btnText: S.current.decrease,
                        bgColor: Colors.white,
                        btnTextColor: context.colorScheme.primaryColor,
                        boxBorder:
                            Border.all(color: context.colorScheme.primaryColor),
                        btnPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                      Expanded(
                        child: BlocBuilder<StockBloc, StockState>(
                            buildWhen: (previous, current) =>
                                current is GetStockItemExcelReportLink,
                            builder: (context, state) =>
                                (state is GetStockItemExcelReportLink && state.isLoading)
                                    ? const LoadingWidget()
                                    : RoundedBtnWidget(
                                        onTap: () {
                                          context.read<StockBloc>().add(
                                              GetExportExcelLinkItem(
                                                  itemStockId:
                                                      stock.itemStock!.id));
                                        },
                                        btnText: "",
                                        btnPadding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 4),
                                        btnIcon: const Icon(
                                          Icons.download,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            context.sizedBoxWidthExtraSmall,
          ],
        ),
      ),
    );
  }
}
