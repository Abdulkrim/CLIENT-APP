import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/feature/workers/presentation/blocs/workers_cubit.dart';
import 'package:merchant_dashboard/feature/workers/presentation/widgets/mobile/mobile_worker_list_widget.dart';
import 'package:merchant_dashboard/feature/workers/presentation/widgets/mobile/mobile_worker_sales_list_widget.dart';
import 'package:merchant_dashboard/feature/workers/presentation/worker_details_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../theme/theme_data.dart';

class WorkerMobileWidget extends StatefulWidget {
  const WorkerMobileWidget({super.key});

  @override
  State<WorkerMobileWidget> createState() => _WorkerMobileWidgetState();
}

class _WorkerMobileWidgetState extends State<WorkerMobileWidget> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  child: TabBar(controller: _tabController, tabs:   [
                    Tab(
                      text:S.current.workers,
                    ),
                    Tab(
                      text: S.current.sellers,
                    ),
                  ])),
              IconButton(
                  onPressed: () {
                    Get.dialog(
                      BlocProvider.value(
                        value: BlocProvider.of<WorkersCubit>(context),
                        child: const WorkerDetailsWidget(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.person_add_alt_1_rounded,
                    color: AppColors.black,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<WorkersCubit>().getAllWorkerSales(getMore: false);
                    context.read<WorkersCubit>().getAllWorkers(getMore: false);
                  },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: AppColors.black,
                    size: 25,
                  )),
            ],
          ),
          context.sizedBoxHeightSmall,
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MobileWorkerListWidget(
                      workers: context.select<WorkersCubit, List<WorkerItem>>(
                              (WorkersCubit bloc) => bloc.workerPagination.listItems),
                      hasMore: context.select<WorkersCubit, bool>(
                              (WorkersCubit bloc) => bloc.workerPagination.hasMore)),
                  MobileWorkerSalesListWidget(
                      sales: context.select<WorkersCubit, List<WorkerItem>>(
                              (WorkersCubit bloc) => bloc.workerSalesPagination.listItems),
                      hasMore: context.select<WorkersCubit, bool>(
                              (WorkersCubit bloc) => bloc.workerSalesPagination.hasMore)),
                ],
              ))
        ],
      ),
    );
  }
}
