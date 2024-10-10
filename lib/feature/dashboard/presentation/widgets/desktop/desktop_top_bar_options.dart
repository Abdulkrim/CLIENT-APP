import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../widgets/date_range_filter/widgets/start_date_picker_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../blocs/dashboard_bloc.dart';

class DesktopTopBarOptionsWidget extends StatelessWidget {
  DesktopTopBarOptionsWidget({super.key});

  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.customerSearchRoute),
          icon: const Icon(
            Icons.search_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        RoundedBtnWidget(
          onTap: () {
            context.read<DashboardBloc>().add(const GetTodayDataEvent());
          },
          btnText: S.current.today,
          width: 150,
          borderRadios: 40,
          height: 40,
          btnTextStyle: context.textTheme.titleSmall,
          btnTextColor:
              (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.today) ? Colors.white : Colors.black,
          bgColor: (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.today)
              ? context.colorScheme.primaryColor
              : Colors.transparent,
          boxBorder: Border.all(color: context.colorScheme.primaryColor),
        ),
        RoundedBtnWidget(
          onTap: () {
            context.read<DashboardBloc>().add(const GetWeekDataEvent());
          },
          btnText: S.current.week,
          width: 150,
          borderRadios: 40,
          height: 40,
          btnTextStyle: context.textTheme.titleSmall,
          btnTextColor:
              (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.week) ? Colors.white : Colors.black,
          bgColor: (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.week)
              ? context.colorScheme.primaryColor
              : Colors.transparent,
          boxBorder: Border.all(color: context.colorScheme.primaryColor),
        ),
        RoundedBtnWidget(
          onTap: () {
            context.read<DashboardBloc>().add(const GetMonthDataEvent());
          },
          btnText: S.current.month,
          width: 150,
          borderRadios: 40,
          height: 40,
          btnTextStyle: context.textTheme.titleSmall,
          btnTextColor:
              (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.month) ? Colors.white : Colors.black,
          bgColor: (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.month)
              ? context.colorScheme.primaryColor
              : Colors.transparent,
          boxBorder: Border.all(color: context.colorScheme.primaryColor),
        ),
        RoundedBtnWidget(
          onTap: () async {
            await Get.defaultDialog(
              title: '',
              content: StartDatePickerWidget(
                onFilterClick: () {
                  context.read<DashboardBloc>().add(GetRangeDataEvent(
                        _fromDateController.text.trim(),
                        _toDateController.text.trim(),
                      ));
                },
                fromDateController: _fromDateController,
                toDateController: _toDateController,
              ),
            );
          },
          btnText: (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.dateRange)
              ? context.select<DashboardBloc, String>((value) => value.selectedSalesTime)
              : S.current.dateRange,
          btnPadding: const EdgeInsets.symmetric(horizontal: 24),
          borderRadios: 40,
          height: 40,
          btnTextStyle: context.textTheme.titleSmall,
          btnTextColor:
              (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.dateRange) ? Colors.white : Colors.black,
          bgColor: (context.select<DashboardBloc, TimeLines>((DashboardBloc value) => value.selectedTimeLine) == TimeLines.dateRange)
              ? context.colorScheme.primaryColor
              : Colors.transparent,
          boxBorder: Border.all(color: context.colorScheme.primaryColor),
        ),
      ],
    );
  }
}
