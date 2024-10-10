import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/feature/workers/presentation/worker_details_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/shimmer.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../blocs/workers_cubit.dart';
import 'desktop_sales_workers_widget.dart';
import 'desktop_workers_list_widget.dart';

class WorkerDesktopWidget extends StatefulWidget {
  const WorkerDesktopWidget({super.key});

  @override
  State<WorkerDesktopWidget> createState() => _WorkerDesktopWidgetState();
}

class _WorkerDesktopWidgetState extends State<WorkerDesktopWidget> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                context.watch<MenuDrawerCubit>().selectedPageContent.text,
                style: context.textTheme.titleLarge,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.read<WorkersCubit>().getAllWorkers(getMore: false);
                  context.read<WorkersCubit>().getAllWorkerSales(getMore: false);
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                )),
          ],
        ),
        context.sizedBoxHeightSmall,
        const Divider(
          height: 0.5,
          thickness: 0.5,
          color: Colors.grey,
        ),
        Row(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: context.colorScheme.primaryColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: context.colorScheme.primaryColor,
              isScrollable: true,
              tabs:   [
                Tab(text: S.current.workers),
                Tab(text: S.current.sellers),
              ],
            ),
          ],
        ),
        const Divider(
          height: 0.5,
          thickness: 0.5,
          color: Colors.grey,
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TabBarView(controller: _tabController, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: RoundedBtnWidget(
                        onTap: () {
                          if (getIt<MainScreenBloc>().isUserBranch) {
                            Get.dialog(BlocProvider.value(
                              value: BlocProvider.of<WorkersCubit>(context),
                              child: const WorkerDetailsWidget(),
                            ));
                          } else {
                            context.showCustomeAlert(S.current.plzSelectBranch);
                          }
                        },
                        btnIcon: SvgPicture.asset(Assets.iconsUserIcon, color: Colors.white),
                        btnText: S.current.addWorker,
                        width: 150,
                        height: 35,
                        btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    context.sizedBoxHeightMicro,
                    Expanded(
                      child: BlocBuilder<WorkersCubit, WorkersState>(
                        builder: (context, state) {
                          if (state is WorkersListLoading) {
                            return ShimmerWidget(width: Get.width, height: Get.height);
                          }
                          return DesktopWorkersListWidget(
                            workers: context.select<WorkersCubit, List<WorkerItem>>(
                                    (value) => value.workerPagination.listItems),
                          );
                        },
                      ),
                    )
                  ],
                ),
                const DesktopSalesWorkerWidget(),
              ]),
            ))
      ],
    );
  }
}
