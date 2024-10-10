// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:merchant_dashboard/utils/extensions/extensions.dart';
//
// import '../../../../generated/l10n.dart';
// import '../../../../injection.dart';
// import '../../../../widgets/rounded_btn.dart';
// import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
// import '../../data/models/responese/branch_time_shifts_response.dart';
// import '../blocs/cubit/branch_shift_cubit.dart';
// import 'add_exception_shift_dialog.dart';
// import 'desktop/defaults_time_shift_list_widget.dart';
//
// class BusinessHoursWidget extends StatefulWidget {
//   const BusinessHoursWidget({super.key});
//
//   @override
//   State<BusinessHoursWidget> createState() => _BusinessHoursWidgetState();
// }
//
// class _BusinessHoursWidgetState extends State<BusinessHoursWidget> with SingleTickerProviderStateMixin {
//   late final TabController _tabController;
//
//   final WorkType _selectedWorkType = WorkType.serviceProvision;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _tabController = TabController(length: 1, vsync: this);
//
//     context.read<BranchShiftCubit>().getBranchShifts(_selectedWorkType.workTypeCode);
//     getIt<MainScreenBloc>().stream.listen((state) {
//       if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
//         context.read<BranchShiftCubit>().getBranchShifts(_selectedWorkType.workTypeCode);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Align(
//             alignment: Alignment.topRight,
//             child: RoundedBtnWidget(
//               onTap: () {
//                 Get.dialog(BlocProvider.value(
//                   value: BlocProvider.of<BranchShiftCubit>(context),
//                   child: AddExceptionShiftDialog(
//                     workType: _selectedWorkType,
//                   ),
//                 ));
//               },
//               btnText: S.current.addException,
//               height: 35,
//             )),
//         SizedBox(
//           height: 600,
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 630),
//               child: Column(
//                 children: [
//                   /* TabBar(
//                       controller: _tabController,
//                       onTap: (value) {
//                         _selectedWorkType = switch (value) {
//                           0 => WorkType.serviceProvision,
//                           1 => WorkType.delivery,
//                           2 => WorkType.pickup,
//                           _ => WorkType.booking,
//                         };
//
//                         context
//                             .read<BranchShiftCubit>()
//                             .getBranchShifts(_selectedWorkType.workTypeCode);
//                       },
//                       tabs: [
//                         Tab(text: S.current.defaultBusinessHoursType),
//                         Tab(text: S.current.deliveryBusinessHoursType),
//                         Tab(text: S.current.pickupBusinessHoursType),
//                         Tab(text: S.current.bookingBusinessHoursType),
//                       ]),*/
//                   context.sizedBoxHeightExtraSmall,
//                   const Expanded(child: DefaultsTimeShiftListWidget(workType: WorkType.serviceProvision))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
