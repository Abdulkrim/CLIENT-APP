import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/presentation/blocs/cashiers/cashier_reports_cubit.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/date_range_picker_widget.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../../../../widgets/shimmer.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../data/models/entity/cashiers_reports.dart';
import '../../widgets/desktop/cashiers/desktop_cashiers_report_table_widget.dart';

class DesktopCashierReportsScreen extends StatefulWidget {
  const DesktopCashierReportsScreen({super.key});

  @override
  State<DesktopCashierReportsScreen> createState() => _DesktopCashierReportsScreenState();
}

class _DesktopCashierReportsScreenState extends State<DesktopCashierReportsScreen> with DownloadUtils {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<CashierReportsCubit>().getCashiers(getMore: true);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.watch<MenuDrawerCubit>().selectedPageContent.text,
                    style: context.textTheme.titleLarge,
                  ),
                  context.sizedBoxWidthMicro,
                  IconButton(
                      onPressed: () {
                        context.read<CashierReportsCubit>().getCashiers();
                      },
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.black,
                      )),
                ],
              ),
              BlocConsumer<CashierReportsCubit, CashierReportsState>(
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
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: DateRangePickerWidget(
              height: 50,
              width: 450,
              initialFromDate: context.select<CashierReportsCubit, String>((value) => value.fromDate),
              initialToDate: context.select<CashierReportsCubit, String>((value) => value.toDate),
              onDateRangeChanged: (String fromDate, String toDate) {
                context.read<CashierReportsCubit>().getCashiers(rFromDate: fromDate, rToDate: toDate);
              },
            ),
          ),
          context.sizedBoxHeightExtraSmall,
          Expanded(
            child: BlocBuilder<CashierReportsCubit, CashierReportsState>(
              builder: (context, state) {
                if (state is GetCashiersLoadingState) {
                  return ShimmerWidget(width: Get.width, height: Get.height);
                }

                return ScrollableWidget(
                  scrollController: _scrollController,
                  child: Column(
                    children: [
                      DesktopCashiersReportTableWidget(
                          cashiers: context.select<CashierReportsCubit, List<CashierItemReport>>(
                        (value) => value.cashiersPagination.listItems,
                      )),
                      Visibility(
                          visible: context.select<CashierReportsCubit, bool>(
                                  (value) => value.cashiersPagination.hasMore) &&
                              state is! GetCashiersFailedState,
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
