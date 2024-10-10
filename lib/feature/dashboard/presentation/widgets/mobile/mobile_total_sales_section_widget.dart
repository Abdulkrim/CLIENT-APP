import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/orders_statistics.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/sales_statistics.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:segmented_progress_bar/segmented_progress_bar.dart';

import '../../blocs/dashboard_bloc.dart';

class MobileTotalSalesSectionWidget extends StatelessWidget {
  const MobileTotalSalesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesStatistics? salesStatistics =
        context.select<DashboardBloc, SalesStatistics?>((value) => value.salesStatistics);
    final OrdersStatistics? ordersStatistics =
        context.select<DashboardBloc, OrdersStatistics?>((value) => value.ordersStatistics);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.current.totalSales}\n${salesStatistics?.totalPrice.toString().getSeparatedNumber ?? '-'}',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${S.current.totalOrders}\n${ordersStatistics?.sumPrices.toString().getSeparatedNumber ?? '-'}',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Visibility(
              visible: (salesStatistics?.paymentStats ?? []).isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: SegmentedProgressBar(
                    segments: salesStatistics?.paymentStats
                            .asMap()
                            .map(
                              (i, element) => MapEntry(
                                i,
                                ProgressSegment(
                                  value: double.parse(element.sumPrice.toString()),
                                  color: AppColors.segmentedProgressBarColors[i],
                                  labelPosition: i == 0 ? LabelPosition.start : LabelPosition.end,
                                  labelTextStyle: context.textTheme.titleSmall!,
                                  label:
                                      '${element.sumPrice.toString().getSeparatedNumber}\n ${element.paymentType}',
                                ),
                              ),
                            )
                            .values
                            .toList() ??
                        []),
              ),
            )
          ],
        ),
        BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (previous, current) =>
              current is GetSalesStatisticsLoadingState ||
              current is GetSalesStatisticsFailedState ||
              current is GetSalesStatisticsSuccessState,
          builder: (context, state) {
            return Visibility(
                visible: state is GetSalesStatisticsLoadingState,
                child: const Center(
                  child: LoadingWidget(),
                ));
          },
        ),
      ],
    );
  }
}
