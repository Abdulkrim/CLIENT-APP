import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/sales_per_timeline.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';

import '../../blocs/dashboard_bloc.dart';
import 'mobile_pie_chart_section_widget.dart';

class MobileSalesBarChartWidget extends StatelessWidget with DateTimeUtils {
  const MobileSalesBarChartWidget({super.key, this.chartRatio = .8});

  final double chartRatio;

  @override
  Widget build(BuildContext context) {
    final List<SalesPerTimeline> sales =
        context.select<DashboardBloc, List<SalesPerTimeline>>((value) => value.salesPerTime);

    final String selectedTime = context.select<DashboardBloc, String>((value) => value.selectedSalesTime);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x0f000000),
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: (sales.isEmpty)
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: AspectRatio(
                aspectRatio: chartRatio,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            '${S.current.salesPer} $selectedTime',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        context.sizedBoxHeightExtraSmall,
                        Expanded(
                          child: BarChart(
                            BarChartData(
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.white,
                                  tooltipMargin: 0,
                                  getTooltipItem: (
                                    BarChartGroupData group,
                                    int groupIndex,
                                    BarChartRodData rod,
                                    int rodIndex,
                                  ) {
                                    return BarTooltipItem(
                                        rod.toY.toString(),
                                        context.textTheme.titleMedium!
                                            .copyWith(fontWeight: FontWeight.bold, color: Colors.black));
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) => SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 16, //margin top
                                      child: Text(
                                        switch ((selectedTime.toLowerCase(), sales.first)) {
                                          (String selectedTime, SalesPerTimeline sale)
                                              when selectedTime == 'today' ||
                                                  sale.interval.toLowerCase() == 'hour' =>
                                            value.toInt().toString(),
                                          (String selectedTime, SalesPerTimeline sale)
                                              when selectedTime == 'week' ||
                                                  sale.interval.toLowerCase() == 'day' =>
                                            getShortDayName(value.toInt()),
                                          _ => value.toInt().toString(),
                                        },
                                        style: context.textTheme.titleMedium,
                                      ),
                                    ),
                                    reservedSize: 42,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 50,
                                      interval: _getBarChartInterval(sales),
                                      getTitlesWidget: (value, meta) {
                                        return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          space: 0,
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              alignment: Alignment.centerLeft,
                                              child: Text(meta.formattedValue,
                                                  style: context.textTheme.bodyMedium,
                                                  textAlign: TextAlign.left)),
                                        );
                                      }),
                                ),
                              ),
                              barGroups: sales
                                  .map((e) => BarChartGroupData(
                                        barsSpace: 4,
                                        x: e.horizontalAxisValue,
                                        barRods: [
                                          BarChartRodData(
                                            toY: e.sumPrice.roundToDouble(),
                                            color: AppColors.segmentedProgressBarColors.first,
                                          ),
                                          BarChartRodData(
                                            toY: double.parse(e.secondSumPrice.toString()),
                                            color: AppColors.segmentedProgressBarColors.last,
                                          ),
                                        ],
                                      ))
                                  .toList(),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              gridData: const FlGridData(show: true),
                            ),
                            swapAnimationDuration: const Duration(milliseconds: 200),
                            swapAnimationCurve: Curves.bounceIn,
                          ),
                        ),
                        context.sizedBoxHeightExtraSmall,
                        Row(
                          children: [
                            Expanded(
                                child: ChartIndicator(
                              color: AppColors.segmentedProgressBarColors.first,
                              text: sales.firstOrNull?.firstPriceType ?? '',
                              size: 10,
                            )),
                            Expanded(
                                child: ChartIndicator(
                              color: AppColors.segmentedProgressBarColors.last,
                              text: sales.firstOrNull?.secondPriceType ?? '',
                              size: 10,
                            )),
                          ],
                        ),
                        context.sizedBoxHeightExtraSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'X Axis:  ',
                                  style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: switch ((selectedTime.toLowerCase(), sales.first)) {
                                    (String selectedTime, SalesPerTimeline sale)
                                        when selectedTime == 'today' ||
                                            sale.interval.toLowerCase() == 'hour' =>
                                      'The hours of a day',
                                    (String selectedTime, SalesPerTimeline sale)
                                        when selectedTime == 'week' || sale.interval.toLowerCase() == 'day' =>
                                      'The names of the days of the week',
                                    _ => 'The numbers of months',
                                  },
                                  style: context.textTheme.bodyMedium),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Y Axis:  ',
                                  style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: 'Amounts of orders and transactions',
                                  style: context.textTheme.bodyMedium),
                            ])),
                          ],
                        ),
                      ],
                    ),
                    BlocBuilder<DashboardBloc, DashboardState>(
                      buildWhen: (previous, current) =>
                          current is GetSalesFailedState ||
                          current is GetSalesLoadingState ||
                          current is GetSalesSuccessState,
                      builder: (context, state) {
                        return Visibility(
                            visible: state is GetSalesLoadingState,
                            child: const Center(
                              child: LoadingWidget(),
                            ));
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }

  double _getBarChartInterval(List<SalesPerTimeline> sales) {
    if (sales.isNotEmpty) {
      double maxPrice = double.negativeInfinity;
      double minPrice = double.infinity;

      for (var sale in sales) {
        if (sale.sumPrice > maxPrice) {
          maxPrice = sale.sumPrice.roundToDouble();
        }
        if (sale.sumPrice < minPrice) {
          minPrice = sale.sumPrice.roundToDouble();
        }

        if (sale.secondSumPrice > maxPrice) {
          maxPrice = sale.secondSumPrice.roundToDouble();
        }
        if (sale.secondSumPrice < minPrice) {
          minPrice = sale.secondSumPrice.roundToDouble();
        }
      }

      double range = (maxPrice - minPrice);
      double calculatedInterval = (sales.length > 1) ? range / 5 : range;

      final interval = ((calculatedInterval > 1) ? calculatedInterval : maxPrice / 5).abs();
      return (interval != 0) ? interval : 1;
    }
    return 1;
  }
}
