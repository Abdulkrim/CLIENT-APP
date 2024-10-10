import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/cutsom_top_tabbar.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/tab_item.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/app_ink_well_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../../orders/data/models/entity/TopLastOrders.dart';
import '../../../../transaction/data/models/entity/transaction.dart';
import '../../blocs/dashboard_bloc.dart';

class MobileOrdersTransactionsTabWidget extends StatefulWidget {
  const MobileOrdersTransactionsTabWidget({super.key});

  @override
  State<MobileOrdersTransactionsTabWidget> createState() => _MobileOrdersTransactionsTabWidgetState();
}

enum TypeOfReport { transactions, orders }

class _MobileOrdersTransactionsTabWidgetState extends State<MobileOrdersTransactionsTabWidget> {
  TypeOfReport _selectedTypeOfReport = TypeOfReport.transactions;

  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions = context.select<DashboardBloc, List<Transaction>>((value) => value.transactions);

    List<TopLastOrdersModel> topLastOrders =
        context.select<DashboardBloc, List<TopLastOrdersModel>>((value) => value.ordersTransactions);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        context.sizedBoxHeightMicro,
        Visibility(
          visible: (transactions.isNotEmpty || topLastOrders.isNotEmpty),
          child: CustomTopTabbar(tabs: [
            TabItem(S.current.transactions, (index) => setState(() => _selectedTypeOfReport = TypeOfReport.transactions)),
            TabItem(S.current.orders, (index) => setState(() => _selectedTypeOfReport = TypeOfReport.orders)),
          ]),
        ),
        context.sizedBoxHeightExtraSmall,
        Stack(
          children: [
            _selectedTypeOfReport == TypeOfReport.transactions
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) => _TransactionItemWidget(
                      title: '${S.current.transactionNo}: ',
                      date: transactions[index].date,
                      transactionNo: transactions[index].transactionNo.toString(),
                      amount: transactions[index].total,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topLastOrders.length,
                    itemBuilder: (context, index) => _TransactionItemWidget(
                      title: '${S.current.orderNo}: ',
                      date: topLastOrders[index].orderDate ?? '',
                      transactionNo: topLastOrders[index].id.toString(),
                      amount: topLastOrders[index].totalFinalPrice ?? 0.0,
                    ),
                  ),
            BlocBuilder<DashboardBloc, DashboardState>(
              buildWhen: (previous, current) =>
                  current is GetReportsLoadingState || current is GetReportsFailedState || current is GetReportsSuccessState,
              builder: (context, state) => Visibility(
                  visible: state is GetReportsLoadingState,
                  child: const Center(
                    child: LoadingWidget(),
                  )),
            )
          ],
        ),
        context.sizedBoxHeightSmall,
      ],
    );
  }
}

class _TransactionItemWidget extends StatelessWidget with ProfileBGColorGenerator {
  const _TransactionItemWidget({required this.date, required this.transactionNo, required this.amount, required this.title});

  final String title;
  final String date;
  final String transactionNo;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(date, style: Theme.of(context).textTheme.titleMedium),
                context.sizedBoxHeightMicro,
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: title,
                    style: context.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: transactionNo,
                    style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  )
                ])),
                context.sizedBoxHeightMicro,
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: '${S.current.total}: ',
                    style: context.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text:
                        '${amount.toString().getSeparatedNumber} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                    style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  )
                ])),
                context.sizedBoxHeightMicro,
                Divider(
                  color: AppColors.gray,
                  thickness: .5,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
