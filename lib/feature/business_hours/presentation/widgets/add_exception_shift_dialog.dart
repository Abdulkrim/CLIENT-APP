import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/app_status_toggle_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme/theme_data.dart';
import '../../../../widgets/date_range_filter/rounded_single_date_picker_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../data/models/responese/working_hours_response.dart';
import '../blocs/cubit/branch_shift_cubit.dart';

class AddExceptionShiftDialog extends StatefulWidget {
  const AddExceptionShiftDialog({super.key, required this.workType});

  final WorkType workType;

  @override
  State<AddExceptionShiftDialog> createState() => _AddExceptionShiftDialogState();
}

class _AddExceptionShiftDialogState extends State<AddExceptionShiftDialog> with DateTimeUtilities {
  final _reasonConroller = TextEditingController();
  final FocusNode node  = FocusNode();
  final _isClosed = false.obs;
  String _selectedStartTimeType = TimeType.am.timeType;
  String _selectedEndTimeType = TimeType.pm.timeType;

  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  DateTime? _fromDateTime;
  DateTime? _toDateTime;

  @override
  void initState() {
    super.initState();
    _startTimeController.addListener(_onFromTextChanged);
    _endTimeController.addListener(_onToTextChanged);
  }

  @override
  void dispose() {
    _startTimeController.removeListener(_onFromTextChanged);
    _startTimeController.dispose();
    _endTimeController.removeListener(_onToTextChanged);
    _endTimeController.dispose();

    super.dispose();
  }

  void _onFromTextChanged() {
    String text = _startTimeController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 2) {
      text = '${text.substring(0, 2)}:${text.substring(2)}';
    }

    _startTimeController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _onToTextChanged() {
    String text = _endTimeController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 2) {
      text = '${text.substring(0, 2)}:${text.substring(2)}';
    }

    _endTimeController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      title: 'Add exception during bussiness hours',
      height: 590,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Reason for chaning working hours to suit operational needs'),
              context.sizedBoxHeightExtraSmall,
              RoundedTextInputWidget(
                hintText: 'Entry Reason',
                textEditController: _reasonConroller,
                focusNode: node,
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Valid From*',
                        style: context.textTheme.titleSmall,
                      ),
                      RoundedSingleDatePickerWidget(
                        isRequired: true,
                        maxDate: DateTime(DateTime.now().year + 5),
                        initalDate: DateFormat('dd/MM/yy').format(_fromDateTime ?? DateTime.now()),
                        onDateSelected: (selectedDate) {
                          _fromDateTime = selectedDate;
                          // setState(() {});
                        },
                      ),
                    ],
                  )),
                  context.sizedBoxWidthExtraSmall,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Valid To*',
                        style: context.textTheme.titleSmall,
                      ),
                      RoundedSingleDatePickerWidget(
                        maxDate: DateTime(DateTime.now().year + 5),
                        isRequired: true,
                        onDateSelected: (selectedDate) => _toDateTime = selectedDate,
                        initalDate: DateFormat('dd/MM/yy').format(_toDateTime ?? DateTime.now()),
                      ),
                    ],
                  )),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    'The restaurant is closed these days',
                    style: context.textTheme.bodyMedium,
                  ),
                  trailing: Obx(
                    () => AppSwitchToggle(
                      onStatusChanged: (status) => _isClosed(status),
                      currentStatus: _isClosed.value,
                    ),
                  )),
              context.sizedBoxHeightExtraSmall,
              Obx(
                () => Visibility(
                  visible: !_isClosed.value,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Start of work*', style: context.textTheme.titleSmall),
                            Container(
                              width: 120,
                              height: 30,
                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.gray2, width: .5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: _startTimeController,
                                      style: context.textTheme.bodySmall,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                      ],
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(bottom: 16),
                                          border: InputBorder.none,
                                          hintText: '00:00',
                                          hintStyle:
                                              context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: .5,
                                    color: AppColors.gray2,
                                  ),
                                  Expanded(
                                      child: Center(
                                    child: DropdownButton(
                                        onChanged: (p0) => setState(() => _selectedStartTimeType = p0!),
                                        value: _selectedStartTimeType,
                                        alignment: Alignment.center,
                                        underline: const SizedBox(),
                                        items: TimeType.values
                                            .map((e) => DropdownMenuItem<String>(
                                                value: e.timeType,
                                                child: Text(
                                                  e.timeType,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(color: AppColors.black),
                                                )))
                                            .toList()),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      context.sizedBoxWidthExtraSmall,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('End of work*', style: context.textTheme.titleSmall),
                            Container(
                              width: 120,
                              height: 30,
                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.gray2, width: .5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: _endTimeController,
                                      style: context.textTheme.bodySmall,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                      ],
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(bottom: 16),
                                          border: InputBorder.none,
                                          hintText: '00:00',
                                          hintStyle:
                                              context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: .5,
                                    color: AppColors.gray2,
                                  ),
                                  Expanded(
                                      child: Center(
                                    child: DropdownButton(
                                        onChanged: (p0) => setState(() => _selectedEndTimeType = p0!),
                                        value: _selectedEndTimeType,
                                        alignment: Alignment.center,
                                        underline: const SizedBox(),
                                        items: TimeType.values
                                            .map((e) => DropdownMenuItem<String>(
                                                value: e.timeType,
                                                child: Text(
                                                  e.timeType,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(color: AppColors.black),
                                                )))
                                            .toList()),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              context.sizedBoxHeightDefault,
              Row(
                children: [
                  Expanded(
                      child: RoundedBtnWidget(
                    onTap: () => Get.back(),
                    height: 40,
                    bgColor: Colors.white,
                    btnTextColor: Colors.black,
                    boxBorder: Border.all(color: Colors.grey),
                    btnText: S.current.cancel,
                  )),
                  context.sizedBoxWidthMicro,
                  Expanded(
                    child: BlocConsumer<BranchShiftCubit, BranchShiftState>(
                        listener: (context, state) {
                          if (state is AddExceptionState && state.errorMsg != null) {
                            context.showCustomeAlert(state.errorMsg);
                          } else if (state is AddExceptionState && state.isSuccess) {
                            context.showCustomeAlert('Exception created successfully!');
                            Get.back();
                          }
                        },
                        builder: (context, state) => (state is AddExceptionState && state.isLoading)
                            ? const LoadingWidget()
                            : RoundedBtnWidget(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (!_isClosed.value &&
                                        (_startTimeController.text.trim().isEmpty ||
                                            _endTimeController.text.trim().isEmpty ||
                                            !is12HourFormat(_startTimeController.text) ||
                                            !is12HourFormat(_endTimeController.text))) {
                                      context.showCustomeAlert('Please enter times in 12-hour format');
                                      return;
                                    }

                                    context.read<BranchShiftCubit>().createExceptionShift(
                                        workType: widget.workType.workTypeCode,
                                        fromDate: _fromDateTime!,
                                        toDate: _toDateTime!,
                                        fromTimeType: _selectedStartTimeType,
                                        toTimetype: _selectedEndTimeType,
                                        fromTime: _startTimeController.text.trim(),
                                        toTime: _endTimeController.text.trim(),
                                        isClosed: _isClosed.value,
                                        reason: _reasonConroller.text.trim());
                                  }
                                },
                                height: 40,
                                btnText: S.current.saveChanges,
                              )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
