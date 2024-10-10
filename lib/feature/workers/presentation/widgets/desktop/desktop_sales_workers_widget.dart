import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/feature/workers/presentation/blocs/workers_cubit.dart';
import 'package:merchant_dashboard/feature/workers/presentation/widgets/desktop/desktop_worker_sales_table_widget.dart';
import 'package:merchant_dashboard/feature/workers/presentation/widgets/worker_sales_filter_option_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../widgets/scrollable_widget.dart';
import '../../../../../widgets/shimmer.dart';

class DesktopSalesWorkerWidget extends StatefulWidget {
  const DesktopSalesWorkerWidget({super.key});

  @override
  State<DesktopSalesWorkerWidget> createState() => _DesktopSalesWorkerState();
}

class _DesktopSalesWorkerState extends State<DesktopSalesWorkerWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<WorkersCubit>().getAllWorkerSales(getMore: true);
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
    return Column(
      children: [
        context.sizedBoxHeightMicro,
        const WorkerSalesFilterOptionWidget(
          sortWidth: .15,
          dateWidth: .3,
        ),
        context.sizedBoxHeightExtraSmall,
        Expanded(child: BlocBuilder<WorkersCubit, WorkersState>(
          builder: (context, state) {
            if (state is GetSalesWorkerLoadingState) {
              return ShimmerWidget(width: Get.width, height: Get.height);
            }
            if (context
                .select<WorkersCubit, List<WorkerItem>>((value) => value.workerSalesPagination.listItems)
                .isNotEmpty) {
              return ScrollableWidget(
                scrollController: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DesktopWorkerSalesTableWidget(
                      workers: context.select<WorkersCubit, List<WorkerItem>>(
                          (value) => value.workerSalesPagination.listItems),
                    ),
                    Visibility(
                        visible: context
                            .select<WorkersCubit, bool>((value) => value.workerSalesPagination.hasMore),
                        child: const CupertinoActivityIndicator()),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        )),
      ],
    );
  }
}
