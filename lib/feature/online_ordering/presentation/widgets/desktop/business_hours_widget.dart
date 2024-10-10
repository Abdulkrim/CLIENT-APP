import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/blocs/cubit/branch_shift_cubit.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/widgets/add_exception_shift_dialog.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/widgets/desktop/defaults_time_shift_list_widget.dart';

import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';

class OnlineOrderBusinessHoursWidget extends StatefulWidget {
  const OnlineOrderBusinessHoursWidget({super.key});

  @override
  State<OnlineOrderBusinessHoursWidget> createState() => _BusinessHoursWidgetState();
}

class _BusinessHoursWidgetState extends State<OnlineOrderBusinessHoursWidget> with SingleTickerProviderStateMixin {
  final WorkType _selectedWorkType = WorkType.serviceProvision;

  @override
  void initState() {
    super.initState();

    context.read<BranchShiftCubit>().getBranchShifts(_selectedWorkType.workTypeCode);
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
        context.read<BranchShiftCubit>().getBranchShifts(_selectedWorkType.workTypeCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerSetting(
        maxWidth: 570,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.businessHours,
                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.headerColor),
                ),

                ///exception button
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightPrimaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: context.colorScheme.primaryColor), borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Get.dialog(BlocProvider.value(
                        value: BlocProvider.of<BranchShiftCubit>(context),
                        child: const AddExceptionShiftDialog(
                          workType: WorkType.serviceProvision,
                        ),
                      ));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm_add_rounded,
                          color: context.colorScheme.primaryColor,
                          size: 22,
                        ),
                        SizedBox(width: 3),
                        Text(
                          S.current.addException,
                          style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            context.sizedBoxHeightExtraSmall,
            const DefaultsTimeShiftListWidget(workType: WorkType.serviceProvision),
            context.sizedBoxHeightSmall,
          ],
        ));
  }
}
