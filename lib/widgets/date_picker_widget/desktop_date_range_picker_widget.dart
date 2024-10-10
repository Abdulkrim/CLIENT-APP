import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../theme/theme_data.dart';
import '../date_range_filter/widgets/end_date_picker_widget.dart';
import '../date_range_filter/widgets/start_date_picker_widget.dart';

class DesktopDateRangePickerWidget extends StatelessWidget {


  final String initialFromDate;
  final String initialToDate;

  final double? width;
  final double? height;

  final Function(String fromDate, String toDate) onDateRangeChanged;

  late final TextEditingController _fromDateController = TextEditingController(text: initialFromDate);
  late final TextEditingController _toDateController = TextEditingController(text: initialToDate);

  DesktopDateRangePickerWidget({
    Key? key,
    this.width,
    this.height,
    required this.initialFromDate,
    required this.initialToDate,
    required this.onDateRangeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.lightGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Visibility(
          visible: (height ?? 0) > 0,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      title: '',
                      content: StartDatePickerWidget(
                        onFilterClick: () {
                          onDateRangeChanged(_fromDateController.text.trim(), _toDateController.text.trim());
                        },
                        fromDateController: _fromDateController,
                        toDateController: _toDateController,
                      ),
                    );
                  },
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _fromDateController,
                    textAlignVertical: TextAlignVertical.top,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'October 2022',
                      hintStyle: context.textTheme.labelMedium?.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: context.textTheme.labelMedium?.copyWith(color: AppColors.black),
                  ),
                ),
              ),
              context.sizedBoxWidthMicro,
              const Text("|"),
              context.sizedBoxWidthMicro,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                        title: '',
                        content: EndDatePickerWidget(
                          onFilterClick: () {
                            onDateRangeChanged(_fromDateController.text.trim(), _toDateController.text.trim());
                          },
                          fromDateController: _fromDateController,
                          toDateController: _toDateController,
                        ));
                  },
                  child: TextFormField(
                    onTap: () {},
                    controller: _toDateController,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'October 2022',
                      hintStyle: context.textTheme.labelMedium?.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: context.textTheme.labelMedium?.copyWith(color: AppColors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
