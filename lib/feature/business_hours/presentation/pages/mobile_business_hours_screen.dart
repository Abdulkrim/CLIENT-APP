import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';
import 'package:merchant_dashboard/feature/business_hours/presentation/widgets/desktop/defaults_time_shift_list_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../injection.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../blocs/cubit/branch_shift_cubit.dart';
import '../widgets/add_exception_shift_dialog.dart';

class MobileBusinessHoursScreen extends StatefulWidget {
  const MobileBusinessHoursScreen({super.key});

  @override
  State<MobileBusinessHoursScreen> createState() => _MobileBusinessHoursScreenState();
}

class _MobileBusinessHoursScreenState extends State<MobileBusinessHoursScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  WorkType _selectedWorkType = WorkType.serviceProvision;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    context.read<BranchShiftCubit>().getBranchShifts(_selectedWorkType.workTypeCode);
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
        context.read<BranchShiftCubit>().getBranchShifts(_selectedWorkType.workTypeCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
              ),
              RoundedBtnWidget(
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
              )
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Expanded(
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

                      context.read<BranchShiftCubit>().getBranchShifts(_selectedWorkType.workTypeCode);
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
          )
        ],
      ),
    );
  }
}
