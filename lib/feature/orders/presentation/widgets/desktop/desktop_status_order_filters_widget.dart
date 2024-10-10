import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/orders/presentation/blocs/order_management_bloc.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';

import '../../../../../widgets/rounded_dropdown_list.dart';
import '../../../data/models/entity/order_status_filter.dart';

class DesktopStatusOrderFiltersWidget extends StatefulWidget {
  const DesktopStatusOrderFiltersWidget({Key? key}) : super(key: key);

  @override
  State<DesktopStatusOrderFiltersWidget> createState() => _DesktopStatusOrderFiltersWidgetState();
}

class _DesktopStatusOrderFiltersWidgetState extends State<DesktopStatusOrderFiltersWidget> {

  OrderStatusFilter? selectedOrderStatusIdFilter = const OrderStatusFilter.firstItem();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, 

      child: RoundedDropDownList(
          maxWidth: 200,
          isExpanded: true,
          selectedValue: selectedOrderStatusIdFilter,
          onChange: (status) {
            context.read<OrderManagementBloc>().add(GetAllOrderRequestEvent(selectedStatusIdFilter: status?.id));
          },
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          items: context
              .watch<OrderManagementBloc>()
              .orderStatusesFilter
              .map<DropdownMenuItem<OrderStatusFilter>>(
                (OrderStatusFilter value) => DropdownMenuItem<OrderStatusFilter>(
                  value: value,
                  child: Text(
                    value.name,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                  ),
                ),
              )
              .toList()),
    );
  }
}