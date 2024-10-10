import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/area_management/data/data_source/area_management_remote_datasource.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

class RadioButtonWidget<T extends Object> extends StatelessWidget {
  final T value;
  final T  groupValue;
  final Function(T?) onChange;
  final String name;
  const RadioButtonWidget({super.key,
    required this.name,
    required this.value,required this.groupValue ,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.headerColor),
          borderRadius:
          BorderRadius.circular(8)),
      padding:
      const EdgeInsetsDirectional.symmetric(horizontal: 5,vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            activeColor:
            context.colorScheme.primaryColor,
            value: value,
            groupValue: groupValue,
            onChanged: (value) => onChange(value),

          ),
          Text(
            name,
            style:
            context.textTheme.titleSmall?.copyWith(color: AppColors.headerColor,fontSize: 16),
          )
        ],
      ),
    );
  }
}
