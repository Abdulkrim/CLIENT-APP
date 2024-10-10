import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../../../widgets/rounded_dropdown_list.dart';
import '../../data/models/entity/cashier_sort_type.dart';
import '../blocs/cashier_bloc.dart';

class SellerFilterOptionsWidget extends StatelessWidget {
  const SellerFilterOptionsWidget({
    super.key,
    required this.sortWidth,
    required this.dateWidth,
  });

  final double dateWidth;
  final double sortWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: DateRangePickerWidget(
              height: 48,
              width: Get.width * dateWidth,
              initialFromDate: context.select<CashierBloc, String>((value) => value.fromDate),
              initialToDate: context.select<CashierBloc, String>((value) => value.toDate),
              onDateRangeChanged: (String fromDate, String toDate) {
                context.read<CashierBloc>().add(GetAllCashiersSalesEvent(fromDate: fromDate, toDate: toDate));
              },
            ),
          ),
        ),
        Expanded(
          child: RoundedDropDownList(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              selectedValue: context.select<CashierBloc, CashierSortTypes>((value) => value.selectedSortType),
              onChange: (p0) {
                context.read<CashierBloc>().add(ChangeSalesCashierOrder(p0));
              },
              items: context
                  .read<CashierBloc>()
                  .sortType
                  .map<DropdownMenuItem<CashierSortTypes>>(
                      (CashierSortTypes value) => DropdownMenuItem<CashierSortTypes>(
                            value: value,
                            child: Text(
                              value.displayedText,
                              textAlign: TextAlign.start,
                              style: context.textTheme.bodyMedium,
                              overflow: TextOverflow.clip,
                            ),
                          ))
                  .toList()),
        ),
      ],
    );
  }
}
