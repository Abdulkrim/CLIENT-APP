import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/desktop/desktop_sales_list_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:get/get.dart';

import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../blocs/cashier_bloc.dart';
import 'desktop_cashiers_widget.dart';

class CashierDesktopWidget extends StatefulWidget {
  const CashierDesktopWidget({Key? key}) : super(key: key);

  @override
  State<CashierDesktopWidget> createState() => _CashierDesktopWidgetState();
}

class _CashierDesktopWidgetState extends State<CashierDesktopWidget> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                context.watch<MenuDrawerCubit>().selectedPageContent.text,
                style: context.textTheme.titleLarge,
              ),
            ),
            context.sizedBoxWidthMicro,
            IconButton(
                onPressed: () {
                  context.read<CashierBloc>().add(const GetAllCashiersEvent(getMore: false));
                  context.read<CashierBloc>().add(const GetAllCashiersSalesEvent(getMore: false));
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                )),
          ],
        ),
        context.sizedBoxHeightSmall,
        const Divider(
          height: 0.5,
          thickness: 0.5,
          color: Colors.grey,
        ),
        Row(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: context.colorScheme.primaryColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: context.colorScheme.primaryColor,
              isScrollable: true,
              tabs:   [
                Tab(text: S.current.operator),
                Tab(text: S.current.sellers),
              ],
            ),
          ],
        ),
        const Divider(
          height: 0.5,
          thickness: 0.5,
          color: Colors.grey,
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TabBarView(
                  controller: _tabController,
                  children: const [DesktopCashiersWidget(), DesktopSalesListWidget()]),
            ))
      ],
    );
  }
}
