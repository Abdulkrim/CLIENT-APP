import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/workers/data/models/entity/worker_list_info.dart';
import 'package:merchant_dashboard/feature/workers/presentation/blocs/workers_cubit.dart';
import 'package:merchant_dashboard/feature/workers/presentation/widgets/worker_sales_filter_option_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/profile_generator_image_widget.dart';

class MobileWorkerSalesListWidget extends StatefulWidget {
  const MobileWorkerSalesListWidget({
    Key? key,
    required this.sales,
    required this.hasMore,
  }) : super(key: key);

  final List<WorkerItem> sales;
  final bool hasMore;

  @override
  State<MobileWorkerSalesListWidget> createState() => _MobileSalesListWidgetState();
}

class _MobileSalesListWidgetState extends State<MobileWorkerSalesListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<WorkersCubit>().getAllWorkerSales(getMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WorkerSalesFilterOptionWidget(
          sortWidth: .3,
          dateWidth: 1,
        ),
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: (widget.hasMore) ? widget.sales.length + 1 : widget.sales.length,
            itemBuilder: (context, index) => (index < widget.sales.length)
                ? MobileSalesItemWidget(worker: widget.sales[index])
                : const CupertinoActivityIndicator(),
          ),
        ),
      ],
    );
  }
}

class MobileSalesItemWidget extends StatelessWidget {
  final WorkerItem worker;

  const MobileSalesItemWidget({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.lightGray,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileGeneratorImageWidget(
            itemLabel: worker.fullName,
            itemColorIndex: 2,
          ),
          context.sizedBoxHeightExtraSmall,
          Expanded(
              child: Text(worker.fullName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
          context.sizedBoxHeightMicro,
          Row(children: [
            Text(S.current.sales),
            Expanded(
                child: Text(
              worker.total.toString(),
              textAlign: TextAlign.right,
            ))
          ]),
        ],
      ),
    );
  }
}
