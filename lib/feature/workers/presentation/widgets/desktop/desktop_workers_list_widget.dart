import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/feature/workers/presentation/blocs/workers_cubit.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/app_status_toggle_widget.dart';
import '../../../../../widgets/profile_generator_image_widget.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../worker_details_widget.dart';

class DesktopWorkersListWidget extends StatefulWidget {
  final List<WorkerItem> workers;

  const DesktopWorkersListWidget({super.key, required this.workers});

  @override
  State<DesktopWorkersListWidget> createState() => _DesktopWorkersListWidgetState();
}

class _DesktopWorkersListWidgetState extends State<DesktopWorkersListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
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
    return ScrollableWidget(
      scrollController: _scrollController,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth / 220).floor();

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8, mainAxisSpacing: 8
                ),
                itemCount: widget.workers.length,
                itemBuilder: (context, index) => _DesktopWorkerItemWidget(worker: widget.workers[index]),
              );
            }
          ),
          Visibility(
              visible: context.select<WorkersCubit, bool>((value) => value.workerPagination.hasMore),
              child: const CupertinoActivityIndicator()),
        ],
      ),
    );
  }
}

class _DesktopWorkerItemWidget extends StatefulWidget {
  final WorkerItem worker;

  const _DesktopWorkerItemWidget({Key? key, required this.worker}) : super(key: key);

  @override
  State<_DesktopWorkerItemWidget> createState() => _DesktopWorkerItemWidgetState();
}

class _DesktopWorkerItemWidgetState extends State<_DesktopWorkerItemWidget> {
  late bool workerStatus = widget.worker.isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        Get.dialog(BlocProvider.value(
          value: BlocProvider.of<WorkersCubit>(context),
          child: WorkerDetailsWidget(
            worker: widget.worker,
          ),
        ));
      },
      child: Container(    width: 250,
        height: 250,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.lightGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                workerStatus ? S.current.active : S.current.inActive,
                style: context.textTheme.titleSmall,
              ),
            ),
            context.sizedBoxHeightExtraSmall,
            ProfileGeneratorImageWidget(itemLabel: widget.worker.fullName, itemColorIndex: 2),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(widget.worker.fullName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
            AppSwitchToggle(
              label: '',
              currentStatus: workerStatus,
              onStatusChanged: (status) {
                context
                    .read<WorkersCubit>()
                    .updateWorkerInfo(workerId: widget.worker.id, isActive: status, workerName: widget.worker.fullName);
                setState(() {
                  workerStatus = status;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
