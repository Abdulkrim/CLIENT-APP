import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/blocs/cashier_bloc.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/cashier_details_widget.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/mobile/mobile_cashier_list_widget.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/mobile/mobile_sales_list_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';


class CashierMobileWidget extends StatefulWidget {
  const CashierMobileWidget({Key? key}) : super(key: key);

  @override
  State<CashierMobileWidget> createState() => _CashierMobileWidgetState();
}

class _CashierMobileWidgetState extends State<CashierMobileWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TabBar(controller: _tabController, tabs: [
                  Tab(
                    text: S.current.cashier,
                  ),
                  Tab(
                    text: S.current.sales,
                  ),
                ]),
              ),
              IconButton(
                  onPressed: () {
                    Get.dialog(
                      BlocProvider.value(
                        value: BlocProvider.of<CashierBloc>(context),
                        child: const CashierDetailsWidget(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.person_add_alt_1_rounded,
                    color: AppColors.black,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    context
                        .read<CashierBloc>()
                        .add(const GetAllCashiersEvent(getMore: false));
                    context
                        .read<CashierBloc>()
                        .add(const GetAllCashiersSalesEvent(getMore: false));
                  },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: AppColors.black,
                    size: 25,
                  )),
            ],
          ),
          context.sizedBoxHeightSmall,
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              MobileCashierListWidget(
                cashiers: context.select<CashierBloc, List<Cashier>>(
                    (value) => value.cashierPagination.listItems),
                hasMore: context.select<CashierBloc, bool>(
                    (value) => value.cashierPagination.hasMore),
              ),
              MobileSalesListWidget(
                sales: context.select<CashierBloc, List<Cashier>>(
                    (value) => value.salesPagination.listItems),
                hasMore: context.select<CashierBloc, bool>(
                    (value) => value.salesPagination.hasMore),
              )
            ],
          ))
        ],
      ),
    );
  }
}
