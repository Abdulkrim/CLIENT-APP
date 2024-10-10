import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/cutsom_top_tabbar.dart';
import 'package:merchant_dashboard/widgets/custom_tabbar/tab_item.dart';

import '../../../../../widgets/app_status_toggle_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../data/models/entities/top_sale_item.dart';
import '../../blocs/dashboard_bloc.dart';
import 'mobile_pie_chart_section_widget.dart';

class TopOrderProductsPieChartWidget extends StatefulWidget {
  const TopOrderProductsPieChartWidget({super.key});

  @override
  State<StatefulWidget> createState() => TopProductsPieChartWidgetState();
}

class TopProductsPieChartWidgetState extends State {
  int touchedIndex = -1;

  bool isTopProductsSelected = true;

  bool hasTopProducts = false;
  bool hasSubCats = false;

  @override
  Widget build(BuildContext context) {
    List<TopSaleItem> topSales = context.select<DashboardBloc, List<TopSaleItem>>((value) {
      hasTopProducts = value.topOrderItems.isNotEmpty;
      hasSubCats = value.topOrderSubCategories.isNotEmpty;
      return (isTopProductsSelected) ? value.topOrderItems : value.topOrderSubCategories;
    });
    final String selectedTime = context.select<DashboardBloc, String>((value) => value.selectedSalesTime);

    return SizedBox(
      height: 350,
      width: Get.width,
      child: Visibility(
        visible: hasSubCats || hasTopProducts,
        child: Stack(
          children: [
            Column(
              children: [
                Text("${S.current.topOrderProducts} $selectedTime"),
                context.sizedBoxHeightMicro,
                CustomTopTabbar(tabs: [
                  TabItem(S.current.products, (index) => setState(() => isTopProductsSelected = true)),
                  TabItem(S.current.subcategory, (index)=> setState(() => isTopProductsSelected = false)),
                ]),
                context.sizedBoxHeightExtraSmall,
                Row(
                  children: [
                    Text(
                      S.current.basedOnPrice,
                      style: context.textTheme.titleSmall,
                    ),
                    AppSwitchToggle(
                      disableThumbColor: context.colorScheme.primaryColorDark,
                      disableTrackColor: context.colorScheme.primaryColorLight,
                      currentStatus: context.select((DashboardBloc bloc) => bloc.topOrdersBasedOnQuantity),
                      onStatusChanged: (status) {
                        context
                            .read<DashboardBloc>()
                            .add(ChangeTopOrderProductsBaseEvent(!context.read<DashboardBloc>().topOrdersBasedOnQuantity));
                      },
                      scale: .7,
                    ),
                    Text(
                      S.current.basedOnQuantity,
                      style: context.textTheme.titleSmall,
                    ),
                  ],
                ),
                context.sizedBoxHeightExtraSmall,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (topSales.isNotEmpty ? topSales : [])
                              .asMap()
                              .map((i, element) => MapEntry(
                                  i,
                                  ChartIndicator(
                                    color: AppColors.pieChartColors[i],
                                    text: element.itemNameEN,
                                    size: touchedIndex == i ? 18 : 12,
                                  )))
                              .values
                              .toList(),
                        ),
                      ),
                      context.sizedBoxHeightMicro,
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            startDegreeOffset: 180,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 1,
                            centerSpaceRadius: 0,
                            sections: showingSections((topSales.isNotEmpty ? topSales : [])),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              buildWhen: (previous, current) =>
                  current is GetTopSalesLoadingState || current is GetTopSalesFailedState || current is GetTopSalesSuccessState,
              builder: (context, state) {
                return Visibility(
                    visible: state is GetTopSalesLoadingState,
                    child: const Center(
                      child: LoadingWidget(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<TopSaleItem> items) {
    double totalAmount = 0;
    for (var element in items) {
      totalAmount += element.percentage;
    }

    return items
        .asMap()
        .map((i, element) => MapEntry(
            i,
            PieChartSectionData(
              color: AppColors.pieChartColors[i],
              value: double.parse(element.percentage.toString()),
              title: '${element.percentage.toStringAsFixed(1)}%',
              titleStyle: context.textTheme.titleSmall?.copyWith(color: Colors.white),
              radius: (element.percentage < 20 ? 70 : (70 + element.percentage > 100 ? 100 : 70 + element.percentage)).toDouble(),
              titlePositionPercentageOffset: 0.55,
              borderSide: i == touchedIndex
                  ? const BorderSide(color: Colors.white, width: 2)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            )))
        .values
        .toList();
  }
}
