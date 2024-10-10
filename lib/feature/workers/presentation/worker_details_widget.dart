import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/feature/workers/presentation/blocs/workers_cubit.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';

import '../../../widgets/app_status_toggle_widget.dart';
import '../../../widgets/item_hint_textfield_widget.dart';
import '../../../widgets/rounded_btn.dart';

class WorkerDetailsWidget extends StatefulWidget {
  const WorkerDetailsWidget({super.key, this.worker});

  final WorkerItem? worker;

  @override
  State<WorkerDetailsWidget> createState() => _WorkerDetailsWidgetState();
}

class _WorkerDetailsWidgetState extends State<WorkerDetailsWidget> {
  late final _fullNameController = TextEditingController(text: widget.worker?.fullName ?? '');
  late bool workerStatus = widget.worker?.isActive ?? false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      title: (widget.worker == null) ? S.current.addWorker : S.current.editWorker,
      height: 330,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ItemHintTextFieldWidget(textEditingController: _fullNameController, hintText:S.current.fullName),
            context.sizedBoxHeightExtraSmall,
            Visibility(
              visible: widget.worker != null,
              child: AppSwitchToggle(
                label: workerStatus ? S.current.active : S.current.inActive,
                currentStatus: workerStatus,
                onStatusChanged: (status) => setState(() => workerStatus = status),
              ),
            ),
            context.sizedBoxHeightExtraSmall,
            BlocConsumer<WorkersCubit, WorkersState>(
              listener: (context, state) {
                if (state is WorkerUpdateStates && state.successMessage != null) {
                  Get.back();
                  context.showCustomeAlert(state.successMessage!, SnackBarType.success);
                } else if (state is WorkerUpdateStates && state.errorMessage != null) {
                  context.showCustomeAlert(state.errorMessage!, SnackBarType.error);
                }
              },
              builder: (context, state) => (state is WorkerUpdateStates && state.isLoading)
                  ? const LoadingWidget()
                  : (widget.worker != null)
                      ? Center(
                          child: RoundedBtnWidget(
                            onTap: () {
                              context.read<WorkersCubit>().updateWorkerInfo(
                                  workerId: widget.worker!.id,
                                  workerName: _fullNameController.text.trim(),
                                  isActive: workerStatus);
                            },
                            btnText: S.current.saveChanges,
                            height: 35,
                            width: 300,
                            btnTextStyle:
                                Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        )
                      : Center(
                          child: RoundedBtnWidget(
                            onTap: () {
                              if (_fullNameController.text.trim().isNotEmpty) {
                                context
                                    .read<WorkersCubit>()
                                    .addWorker(workerName: _fullNameController.text.trim());
                              } else {
                                context.showCustomeAlert(S.current.plzEnterAllData, SnackBarType.alert);
                              }
                            },
                            btnText: S.current.addWorker,
                            height: 35,
                            width: 300,
                            btnTextStyle:
                                Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
