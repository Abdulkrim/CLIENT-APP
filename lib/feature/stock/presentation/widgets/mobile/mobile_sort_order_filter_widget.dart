import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stock_sort_type.dart';
import 'package:merchant_dashboard/feature/stock/presentation/blocs/stock_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:get/get.dart';

class MobileSortOrderFilterWidget extends StatelessWidget {
  const MobileSortOrderFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.sizedBoxHeightExtraSmall,
          Text(
            S.current.sortBy,
            style: context.textTheme.bodyMedium,
          ),
          Expanded(
              child: ListView(
            children: context
                .read<StockBloc>()
                .sortType
                .map((e) => RadioListTile(
                      title: Text(
                        e.displayedText,
                        style: context.textTheme.labelMedium,
                      ),
                      value: e,
                      subtitle: const Text(""),
                      groupValue: context.select<StockBloc, StockSortTypes>((value) => value.selectedSortType),
                      onChanged: (StockSortTypes? newValue) {
                        context.read<StockBloc>().add(GetAllStockRequestEvent(selectedStockSortType: newValue!));

                        Get.back();
                      },
                    ))
                .toList(),
          )),
        ],
      ),
    );
  }
}
