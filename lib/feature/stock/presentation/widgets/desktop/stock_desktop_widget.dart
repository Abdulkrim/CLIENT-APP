import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stock_sort_type.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stocks.dart';
import 'package:merchant_dashboard/feature/stock/presentation/blocs/stock_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/search_box_widget.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/desktop/desktop_stock_list_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../../generated/assets.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../stock_statisttics_item_widget.dart';

class StockDesktopWidget extends StatefulWidget {
  const StockDesktopWidget({Key? key}) : super(key: key);

  @override
  State<StockDesktopWidget> createState() => _StockDesktopWidgetState();
}

class _StockDesktopWidgetState extends State<StockDesktopWidget> with DownloadUtils {
  @override
  void initState() {
    super.initState();

    // For when user go back and then open this page
    context.read<StockBloc>().manageLastSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
                context.sizedBoxWidthMicro,
                IconButton(
                    onPressed: () {
                      context.read<StockBloc>()
                        ..add(const GetAllStockRequestEvent())
                        ..add(const GetStockStatistics());
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.black,
                    )),
              ],
            ),
            Row(
              children: [
                context.sizedBoxWidthExtraSmall,
                SizedBox(
                  width: 270,
                  height: 40,
                  child: SearchBoxWidget(
                    onSearchTapped: (String? text) => context
                        .read<StockBloc>()
                        .add(GetAllStockRequestEvent(searchText: (text ?? ''))),
                  ),
                ),
                context.sizedBoxWidthExtraSmall,
                BlocConsumer<StockBloc, StockState>(
                    listener: (context, state) {
                      if (state is GetStockExcelReportLink && state.isSuccess) {
                        openLink(url: context.read<StockBloc>().exportStockExcelLink);
                      }
                    },
                    buildWhen: (previous, current) => current is GetStockExcelReportLink,
                    builder: (context, state) => (state is GetStockExcelReportLink && state.isLoading)
                        ? const LoadingWidget()
                        : RoundedBtnWidget(
                            onTap: () {
                              context.read<StockBloc>().add(const GetExportExcelLink());
                            },
                            btnText: S.current.downloadStockReport,
                            btnPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          )),
                context.sizedBoxWidthExtraSmall,
                Visibility(
                  visible: hideForThisV,
                  child: RoundedDropDownList(
                      selectedValue:
                          context.select<StockBloc, StockSortTypes>((value) => value.selectedSortType),
                      onChange: (p0) {
                        context
                            .read<StockBloc>()
                            .add(GetAllStockRequestEvent(selectedStockSortType: p0!));
                      },
                      items: context
                          .read<StockBloc>()
                          .sortType
                          .map<DropdownMenuItem<StockSortTypes>>(
                              (StockSortTypes value) => DropdownMenuItem<StockSortTypes>(
                                    value: value,
                                    child: Text(
                                      value.displayedText,
                                      style: context.textTheme.titleSmall,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ))
                          .toList()),
                )
              ],
            ),
          ],
        ),
        context.sizedBoxHeightSmall,
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            StockStatistticsItemWidget(
              iconBGcolor: const Color(0xFFCFE7FF),
              textColor: const Color(0xFF0066CC),
              iconName: Assets.iconsEmptyBox,
              boxValue: context
                  .select<StockBloc, String>((value) => value.stockStatistics?.totalItems ?? '-'),
              boxTitle: S.current.totalItems,
            ),
            StockStatistticsItemWidget(
                iconBGcolor: const Color(0xFFFFEBB2),
                textColor: const Color(0xFFFFBC02),
                iconName: Assets.iconsFullBox,
                boxValue: context
                    .select<StockBloc, String>((value) => value.stockStatistics?.totalQuantity ?? '-'),
                boxTitle: S.current.totalQuantity),
            StockStatistticsItemWidget(
              iconBGcolor: const Color(0xFFD6F4D6),
              textColor: const Color(0xFF35C635),
              iconName: Assets.iconsMoneyBag,
              boxValue: context
                  .select<StockBloc, String>((value) => value.stockStatistics?.totalValue ?? '-'),
              boxTitle: S.current.totalProductValue,
            ),
          ],
        ),
        context.sizedBoxHeightSmall,
        Expanded(child: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            if (state is AllStocksLoadingState) {
              return ShimmerWidget(width: Get.width, height: Get.height);
            }
            return DesktopStockListWidget(
                stocks: context
                    .select<StockBloc, List<StockInfo>>((value) => value.stocksPagination.listItems));
          },
        )),
      ],
    );
  }
}
