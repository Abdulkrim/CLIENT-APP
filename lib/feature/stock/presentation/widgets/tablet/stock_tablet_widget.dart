import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stocks.dart';
import 'package:merchant_dashboard/feature/stock/presentation/blocs/stock_bloc.dart';
import 'package:merchant_dashboard/widgets/search_box_widget.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/desktop/desktop_stock_list_widget.dart';
import 'package:merchant_dashboard/feature/stock/presentation/widgets/mobile/mobile_sort_order_filter_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';

class StockTabletWidget extends StatelessWidget {
  const StockTabletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
              ),
              SizedBox(
                width: 270,
                height: 40,
                child: SearchBoxWidget(
                  onSearchTapped: (String? text) =>
                      context.read<StockBloc>().add(GetAllStockRequestEvent(searchText: (text ?? ''))),
                ),
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
                          // isScrollControlled: true,
                          const MobileSortOrderFilterWidget());
                    },
                    padding: const EdgeInsets.all(16),
                    icon: SvgPicture.asset(Assets.iconsSort, height: 20),
                  )
                ],
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
                  gridItemCount: 3,
                  stocks: context
                      .select<StockBloc, List<StockInfo>>((value) => value.stocksPagination.listItems));
            },
          )),
        ],
      ),
    );
  }
}
