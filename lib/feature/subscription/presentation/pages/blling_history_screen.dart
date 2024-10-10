import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/billing_history.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/billing_history/cubit/billing_history_cubit.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';

import '../../../../widgets/scrollable_widget.dart';
import '../widgets/desktop/billing_history/desktop_billing_history_table_widget.dart';

class BillingHistoryScreen extends StatefulWidget {
  const BillingHistoryScreen({super.key});

  @override
  State<BillingHistoryScreen> createState() => _BillingHistoryScreenState();
}

class _BillingHistoryScreenState extends State<BillingHistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<BillingHistoryCubit>().getBillingHistories(getMore: true);
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                S.current.yourBillingHistory,
                style: context.textTheme.titleMedium,
              ),
              context.sizedBoxWidthMicro,
              IconButton(
                  onPressed: () => context.read<BillingHistoryCubit>().getBillingHistories(),
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.black,
                  )),
            ],
          ),
          /*  Row(
            mainAxisSize: MainAxisSize.min,
            children: [ 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: RoundedSeparateDateRangeWidget(
                  height: 50,
                  width: 450,
                  initialFromDate: context.select<BillingHistoryCubit, String>((value) => value.fromDate),
                  initialToDate: context.select<BillingHistoryCubit, String>((value) => value.toDate),
                  onDateRangeChanged: (String fromDate, String toDate) {
                    context
                        .read<BillingHistoryCubit>()
                        .getBillingHistories(getMore: true, sFromDate: fromDate, sToDate: toDate);
                  },
                ),
              ),
            ],
          ), */
          context.sizedBoxHeightExtraSmall,
          Expanded(
            child: BlocBuilder<BillingHistoryCubit, BillingHistoryState>(
              builder: (context, state) {
                if (state is GetBillingHistoryState && state.isLoading) {
                  return const LoadingWidget();
                }

                return ScrollableWidget(
                  scrollController: _scrollController,
                  child: Column(
                    children: [
                      DesktopBillingHistoryTableWidget(
                          billings: context.select<BillingHistoryCubit, List<BillingHistoryItem>>(
                        (value) => value.billingPagination.listItems,
                      )),
                      Visibility(
                          visible: context.select<BillingHistoryCubit, bool>(
                                  (value) => value.billingPagination.hasMore) &&
                              (state.errorMessage.isNotEmpty),
                          child: const CupertinoActivityIndicator()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
