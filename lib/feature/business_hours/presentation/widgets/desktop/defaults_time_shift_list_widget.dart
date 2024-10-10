import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/entity/branch_time_shifts.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/blocs/cubit/branch_shift_cubit.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/scrollable_widget.dart';
import 'desktop_day_item_widget.dart';

class DefaultsTimeShiftListWidget extends StatelessWidget
    with DateTimeUtilities {
  const DefaultsTimeShiftListWidget({super.key, required this.workType});

  final WorkType workType;

  @override
  Widget build(BuildContext context) {
    final BranchTimeShifts? shift =
        context.watch<BranchShiftCubit>().branchShifts;

    return ScrollableWidget(
      child: BlocBuilder<BranchShiftCubit, BranchShiftState>(
        builder: (context, state) => (state is GetBranchShiftState  &&
                state.isLoading)
            ? const LoadingWidget()
            : shift == null
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.lightGray)),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: shift.workingHours.length,
                            itemBuilder: (context, index) =>
                                DesktopDayTimeItemWidget(
                              workTime: shift.workingHours[index],
                            ),
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              color: AppColors.lightGray,
                            ),
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: BlocConsumer<BranchShiftCubit, BranchShiftState>(
                      //     listener: (context, state) {
                      //       if (state is ManageBranchShiftState && state.isSuccess) {
                      //         context.showCustomeAlert(S.current.businessHoursUpdatedSuccessfully);
                      //       } else if (state is ManageBranchShiftState && state.errorMsg != null) {
                      //         context.showCustomeAlert(state.errorMsg);
                      //       }
                      //     },
                      //     builder: (context, state) => (state is ManageBranchShiftState && state.isLoading)
                      //         ? const LoadingWidget()
                      //         : RoundedBtnWidget(
                      //       btnText: S.current.save,
                      //       onTap: () {
                      //         for (var element in shift.workingHours) {
                      //           final emptyHours = element.hours.firstWhereOrNull((element) =>
                      //           (element.from == null || element.from!.isEmpty) ||
                      //               (element.to == null || element.to!.isEmpty));
                      //
                      //           if (emptyHours != null) {
                      //             context.showCustomeAlert(S.current.emptyHoursError);
                      //             return;
                      //           }
                      //
                      //           if (element.hours.firstWhereOrNull((element) =>
                      //           !is12HourFormat(element.from!) || !is12HourFormat(element.to!)) !=
                      //               null) {
                      //             context.showCustomeAlert(S.current.timeFormatError);
                      //             return;
                      //           }
                      //
                      //           if (element.hours.firstWhereOrNull(
                      //                   (element) => element.fromType == null || element.toType == null) !=
                      //               null) {
                      //             context.showCustomeAlert(S.current.timeTypeFormat);
                      //             return;
                      //           }
                      //         }
                      //
                      //         context.read<BranchShiftCubit>().manageWorkTypeShiftTimes(
                      //             workType: workType.workTypeCode, shifts: shift.workingHours);
                      //       },
                      //       btnPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
      ),
    );
  }
}
