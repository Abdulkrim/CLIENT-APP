import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StartDatePickerWidget extends StatelessWidget {
  const StartDatePickerWidget({
    Key? key,
    required this.onFilterClick,
    required TextEditingController fromDateController,
    required TextEditingController toDateController,
  })  : _fromDateController = fromDateController,
        _toDateController = toDateController,
        super(key: key);

  final Function onFilterClick;
  final TextEditingController _fromDateController;
  final TextEditingController _toDateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 310,
          width: 400,
          child: SfDateRangePicker(
            headerStyle: const DateRangePickerHeaderStyle(backgroundColor: Colors.transparent),
            showTodayButton: true,
            backgroundColor: Colors.transparent,
            showActionButtons: true,
            confirmText: S.current.filter,
            maxDate: DateTime.now(),
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              _fromDateController.clear();
              _toDateController.clear();
              if ((args.value as PickerDateRange).startDate != null &&
                  (args.value as PickerDateRange).endDate != null) {
                _toDateController.text =
                    "${(args.value as PickerDateRange).endDate!.year}/${(args.value as PickerDateRange).endDate!.month}/${(args.value as PickerDateRange).endDate!.day}";
              }
              _fromDateController.text = ((args.value as PickerDateRange).startDate != null)
                  ? "${(args.value as PickerDateRange).startDate!.year}/${(args.value as PickerDateRange).startDate!.month}/${(args.value as PickerDateRange).startDate!.day}"
                  : "";
            },
            selectionMode: DateRangePickerSelectionMode.range,
            onCancel: () => Get.back(),
            onSubmit: (p0) {
              if (_toDateController.text.isEmpty) {
                _toDateController.text = _fromDateController.text;
              }
              onFilterClick();
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
