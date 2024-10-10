import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/desktop_date_range_picker_widget.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/mobile_date_range_picker_widget.dart';

class DateRangePickerWidget extends StatelessWidget {
  const DateRangePickerWidget({
    super.key,
    this.width,
    this.height,
    required this.initialFromDate,
    required this.initialToDate,
    required this.onDateRangeChanged,
  });

  final String initialFromDate;
  final String initialToDate;

  final double? width;
  final double? height;

  final Function(String fromDate, String toDate) onDateRangeChanged;

  @override
  Widget build(BuildContext context) {
    return context.isPhone
        ? MobileDateRangePickerWidget(
            initialFromDate: initialFromDate,
            initialToDate: initialToDate,
            onDateRangeChanged: onDateRangeChanged,
          )
        : DesktopDateRangePickerWidget(
            width: width,
            height: height,
            initialFromDate: initialFromDate,
            initialToDate: initialToDate,
            onDateRangeChanged: onDateRangeChanged,
          );
  }
}
