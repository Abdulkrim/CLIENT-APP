import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RoundedSingleDatePickerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isRequired;
  final String? initalDate;
  final DateTime? maxDate;
  late final TextEditingController dateTextContoller = TextEditingController(text: initalDate ?? '');

  final Function(DateTime selectedDate) onDateSelected;

  RoundedSingleDatePickerWidget({
    super.key,
    this.width,
    this.height,
    this.initalDate,
    this.maxDate,
    this.isRequired = false,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
          onTap: () {
            Get.defaultDialog(
              title: '',
              titlePadding: const EdgeInsets.all(0),
              content: SizedBox(
                height: 310,
                width: 400,
                child: SfDateRangePicker(
                  headerStyle: const DateRangePickerHeaderStyle(backgroundColor: Colors.transparent),
                  showTodayButton: true,
                  backgroundColor: Colors.transparent,
                  showActionButtons: true,
                  confirmText: S.current.select,
                  maxDate: maxDate ?? DateTime.now(),
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {},
                  selectionMode: DateRangePickerSelectionMode.single,
                  onCancel: () => Get.back(),
                  onSubmit: (p0) {
                    dateTextContoller.text = '${(p0 as DateTime).day}/${p0.month}/${p0.year}';
                    onDateSelected(p0);
                    Get.back();
                  },
                ),
              ),
            );
          },
          child: RoundedTextInputWidget(
            hintText: '10/10/2023',
            isEnable: false,
            isRequired: isRequired,
            textEditController: dateTextContoller,
            suffixIcon: const Icon(
              Icons.calendar_month,
              size: 15,
            ),
          )),
    );
  }
}
