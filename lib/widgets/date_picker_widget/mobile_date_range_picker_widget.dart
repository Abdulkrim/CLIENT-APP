import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../generated/l10n.dart';

class MobileDateRangePickerWidget extends StatefulWidget {
  const MobileDateRangePickerWidget(
      {super.key, required this.initialToDate, required this.initialFromDate, required this.onDateRangeChanged});

  final String initialFromDate;
  final String initialToDate;

  final Function(String fromDate, String toDate) onDateRangeChanged;

  @override
  State<MobileDateRangePickerWidget> createState() => _MobileDateRangePickerWidgetState();
}

class _MobileDateRangePickerWidgetState extends State<MobileDateRangePickerWidget> {
  late String _startDate = widget.initialFromDate;

  late String _endDate = widget.initialToDate;

  final DateRangePickerController _calendarController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.defaultDialog(
          title: '',
          content: Column(
            children: <Widget>[
              SizedBox(
                height: 310,
                width: 400,
                child: SfDateRangePicker(
                  headerStyle: const DateRangePickerHeaderStyle(backgroundColor: Colors.transparent),
                  showTodayButton: true,
                  backgroundColor: Colors.transparent,
                  showActionButtons: true,
                  controller: _calendarController,
                  confirmText: S.current.filter,
                  maxDate: DateTime.now(),
                  onCancel: () {
                    Get.back();
                  },
                  onSubmit: (p0) {
                    if (_startDate.isNotEmpty && _endDate.isNotEmpty) {

                      widget.onDateRangeChanged(_startDate , _endDate);
                      Get.back();
                    } else {
                      context.showCustomeAlert(S.current.selectDateRange, SnackBarType.alert);
                    }
                  },
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    _startDate = ((args.value as PickerDateRange).startDate != null)
                        ? "${(args.value as PickerDateRange).startDate!.year}/${(args.value as PickerDateRange).startDate!.month}/${(args.value as PickerDateRange).startDate!.day}"
                        : "";

                    _endDate = ((args.value as PickerDateRange).endDate != null)
                        ? "${(args.value as PickerDateRange).endDate!.year}/${(args.value as PickerDateRange).endDate!.month}/${(args.value as PickerDateRange).endDate!.day}"
                        : "";
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                ),
              ),
            ],
          ),
        );
      },
      child:  Text(
        "$_startDate To $_endDate",
        style: context.textTheme.titleSmall,
      )
    );
  }
}
