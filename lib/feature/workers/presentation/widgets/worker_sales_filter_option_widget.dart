import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/workers/presentation/blocs/workers_cubit.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/date_range_picker_widget.dart';

import '../../../../widgets/rounded_dropdown_list.dart';
import '../../../cashiers/data/models/entity/cashier_sort_type.dart';

class WorkerSalesFilterOptionWidget extends StatelessWidget {
  const WorkerSalesFilterOptionWidget({
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
              initialFromDate: context.select<WorkersCubit, String>((value) => value.fromDate),
              initialToDate: context.select<WorkersCubit, String>((value) => value.toDate),
              onDateRangeChanged: (String fromDate, String toDate) {
                context
                    .read<WorkersCubit>()
                    .getAllWorkerSales(requestedFromDate: fromDate, requestedtoDate: toDate);
              },
            ),
          ),
        ),
        Expanded(
          child: RoundedDropDownList(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              selectedValue:
                  context.select<WorkersCubit, CashierSortTypes>((value) => value.selectedSortType),
              onChange: (p0) {
                context.read<WorkersCubit>().changeSortType(p0);
              },
              items: context
                  .read<WorkersCubit>()
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
