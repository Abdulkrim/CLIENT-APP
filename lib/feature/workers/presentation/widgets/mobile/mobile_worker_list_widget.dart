import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/feature/workers/presentation/blocs/workers_cubit.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/app_ink_well_widget.dart';
import '../../../../../widgets/app_status_toggle_widget.dart';
import '../../../../../widgets/profile_generator_image_widget.dart';
import '../../worker_details_widget.dart';

class MobileWorkerListWidget extends StatefulWidget {
  final List<WorkerItem> workers;
  final bool hasMore;

  const MobileWorkerListWidget({
    super.key,
    required this.workers,
    required this.hasMore,
  });

  @override
  State<MobileWorkerListWidget> createState() => _MobileWorkerListWidgetState();
}

class _MobileWorkerListWidgetState extends State<MobileWorkerListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<WorkersCubit>().getAllWorkers(getMore: true);
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
    return ListView.builder(
      controller: _scrollController,
      primary: false,
      itemCount: (widget.hasMore) ? widget.workers.length + 1 : widget.workers.length,
      itemBuilder: (context, index) => (index < widget.workers.length)
          ? MobileWorkerItemWidget(worker: widget.workers[index])
          : const CupertinoActivityIndicator(),
    );
  }
}

class MobileWorkerItemWidget extends StatefulWidget {
  final WorkerItem worker;

  const MobileWorkerItemWidget({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  State<MobileWorkerItemWidget> createState() => _MobileWorkerItemWidgetState();
}

class _MobileWorkerItemWidgetState extends State<MobileWorkerItemWidget> {
  late bool workerStatus = widget.worker.isActive;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () {
        Get.dialog(
          BlocProvider.value(
            value: BlocProvider.of<WorkersCubit>(context),
            child: WorkerDetailsWidget(
              worker: widget.worker,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.lightGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            ProfileGeneratorImageWidget(itemLabel: widget.worker.fullName, itemColorIndex: 2),
            context.sizedBoxWidthSmall,
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(widget.worker.fullName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold))),
                  ],
                ),
                context.sizedBoxHeightMicro,
                AppSwitchToggle(
                  currentStatus: workerStatus,
                  onStatusChanged: (status) {
                    context.read<WorkersCubit>().updateWorkerInfo(
                          workerId: widget.worker.id,
                          isActive: status,
                          workerName: widget.worker.fullName,
                        );
                    setState(() {
                      workerStatus = status;
                    });
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
