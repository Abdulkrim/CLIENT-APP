import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EndDatePickerWidget extends StatelessWidget {
  const EndDatePickerWidget({
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
              if ((args.value as PickerDateRange).startDate != null &&
                  (args.value as PickerDateRange).endDate != null) {
                _fromDateController.text =
                    "${(args.value as PickerDateRange).startDate!.year}/${(args.value as PickerDateRange).startDate!.month}/${(args.value as PickerDateRange).startDate!.day}";

                _toDateController.text =
                    "${(args.value as PickerDateRange).endDate!.year}/${(args.value as PickerDateRange).endDate!.month}/${(args.value as PickerDateRange).endDate!.day}";
              } else {
                _toDateController.text = ((args.value as PickerDateRange).startDate != null)
                    ? "${(args.value as PickerDateRange).startDate!.year}/${(args.value as PickerDateRange).startDate!.month}/${(args.value as PickerDateRange).startDate!.day}"
                    : "";
              }
            },
            selectionMode: DateRangePickerSelectionMode.range,
            onCancel: () => Get.back(),
            onSubmit: (p0) {
              onFilterClick();
              Get.back();
            },
          ),
        ),
        /*  Row(
          children: [
            ElevatedButton(
              onPressed: () {
                onFilterClick();
                Get.back();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
              child: Center(
                  child: Text(
                "Filter",
                style: context.textTheme.bodySmall?.copyWith(color: Colors.white),
              )),
            ),
          ],
        ) */
      ],
    );
  }
}
