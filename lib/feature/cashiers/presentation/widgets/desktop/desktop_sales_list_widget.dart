import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/blocs/cashier_bloc.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/desktop/desktop_sales_table_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../seller_filter_options_widget.dart';

class DesktopSalesListWidget extends StatefulWidget {
  const DesktopSalesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopSalesListWidget> createState() => _DesktopSalesListWidgetState();
}

class _DesktopSalesListWidgetState extends State<DesktopSalesListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<CashierBloc>().add(const GetAllCashiersSalesEvent(getMore: true));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.sizedBoxHeightMicro,
        const SellerFilterOptionsWidget(
          sortWidth: .15,
          dateWidth: .3,
        ),
        context.sizedBoxHeightExtraSmall,
        Expanded(child: BlocBuilder<CashierBloc, CashierState>(
          builder: (context, state) {
            if (state is SalesCashiersListLoadingState) {
              return ShimmerWidget(width: Get.width, height: Get.height);
            }
            if (state is WrongDateFilterRangeEnteredState) return const SizedBox();
            return ScrollableWidget(
              scrollController: _scrollController,
              child: Column(
                children: [
                  DesktopSalesTableWidget(
                    cashiers: context
                        .select<CashierBloc, List<Cashier>>((value) => value.salesPagination.listItems),
                  ),
                  Visibility(
                      visible: context.select<CashierBloc, bool>((value) => value.salesPagination.hasMore),
                      child: const CupertinoActivityIndicator()),
                ],
              ),
            );
          },
        )),
      ],
    );
  }
}
