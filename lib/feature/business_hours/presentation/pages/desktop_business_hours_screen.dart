import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/widgets/desktop/defaults_time_shift_list_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../injection.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../blocs/cubit/branch_shift_cubit.dart';
import '../widgets/add_exception_shift_dialog.dart';

class DesktopBusinessHoursScreen extends StatefulWidget {
  const DesktopBusinessHoursScreen({super.key});

  @override
  State<DesktopBusinessHoursScreen> createState() =>
      _DesktopBusinessHoursScreenState();
}

class _DesktopBusinessHoursScreenState extends State<DesktopBusinessHoursScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  WorkType _selectedWorkType = WorkType.serviceProvision;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    context
        .read<BranchShiftCubit>()
        .getBranchShifts(_selectedWorkType.workTypeCode);
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState &&
          state.merchantInfo.hasData) {
        context
            .read<BranchShiftCubit>()
            .getBranchShifts(_selectedWorkType.workTypeCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.watch<MenuDrawerCubit>().selectedPageContent.text,
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          context.sizedBoxHeightExtraSmall,
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 630),
                        child: Column(
                          children: [
                            TabBar(
                                controller: _tabController,
                                onTap: (value) {
                                  _selectedWorkType = switch (value) {
                                    0 => WorkType.serviceProvision,
                                    1 => WorkType.delivery,
                                    2 => WorkType.pickup,
                                    _ => WorkType.booking,
                                  };

                              context
                                  .read<BranchShiftCubit>()
                                  .getBranchShifts(_selectedWorkType.workTypeCode);
                            },
                            tabs: [
                              Tab(text: S.current.defaultBusinessHoursType),
                              Tab(text: S.current.deliveryBusinessHoursType),
                              Tab(text: S.current.pickupBusinessHoursType),
                              Tab(text: S.current.bookingBusinessHoursType),
                            ]),
                        context.sizedBoxHeightExtraSmall,
                        Expanded(
                            child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            DefaultsTimeShiftListWidget(workType: WorkType.serviceProvision),
                            DefaultsTimeShiftListWidget(workType: WorkType.delivery),
                            DefaultsTimeShiftListWidget(workType: WorkType.pickup),
                            DefaultsTimeShiftListWidget(workType: WorkType.booking),
                          ],
                        ))
                      ],
                    ),
                  ),
                )),
                Align(
                    alignment: Alignment.topRight,
                    child: RoundedBtnWidget(
                      onTap: () {
                        Get.dialog(BlocProvider.value(
                          value: BlocProvider.of<BranchShiftCubit>(context),
                          child: AddExceptionShiftDialog(
                            workType: _selectedWorkType,
                          ),
                        ));
                      },
                      btnText: S.current.addException,
                      height: 35,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
