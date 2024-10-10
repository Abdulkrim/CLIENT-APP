import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/cashiers_reports.dart';
import 'package:merchant_dashboard/feature/report/presentation/blocs/cashiers/cashier_reports_cubit.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/shimmer.dart';
import '../../widgets/mobile/cashiers/mobile_cashier_reports_list_widget.dart';

class MobileCashierReportsScreen extends StatelessWidget with DownloadUtils {
  const MobileCashierReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.filter,
                style: context.textTheme.titleLarge,
              ),
              Row(
                children: [
                  DateRangePickerWidget(
                    initialFromDate: context.select<CashierReportsCubit, String>((value) => value.fromDate),
                    initialToDate: context.select<CashierReportsCubit, String>((value) => value.toDate),
                    onDateRangeChanged: (String fromDate, String toDate) {
                      context.read<CashierReportsCubit>().getCashiers(rFromDate: fromDate, rToDate: toDate);
                    },
                  )
                ],
              ),
            ],
          ),
          Center(
            child: BlocConsumer<CashierReportsCubit, CashierReportsState>(
              listener: (context, state) {
                if (state is GetDownloadLinkState && state.link != null) {
                  openLink(url: state.link!);
                }
              },
              builder: (context, state) {
                return (state is GetDownloadLinkLoadingState)
                    ? const LoadingWidget()
                    : RoundedBtnWidget(
                        onTap: () => context.read<CashierReportsCubit>().getCashiersReportsDownloadLink(),
                        height: 35,
                        btnText: S.current.downloadReportOfTrans,
                        btnIcon: const Icon(
                          Icons.downloading_rounded,
                          color: Colors.white,
                        ));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CashierReportsCubit, CashierReportsState>(
              builder: (context, state) {
                if (state is GetCashiersLoadingState) {
                  return ShimmerWidget(width: Get.width, height: Get.height);
                }
                return MobileCashierReportsListWidge(
                  getCashiers: (getMore) => context.read<CashierReportsCubit>().getCashiers(getMore: getMore),
                  cashiers: context.select<CashierReportsCubit, List<CashierItemReport>>(
                    (value) => value.cashiersPagination.listItems,
                  ),
                  hasMore: context.select<CashierReportsCubit, bool>((value) => value.cashiersPagination.hasMore),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
