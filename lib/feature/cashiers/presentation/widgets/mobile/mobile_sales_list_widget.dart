import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/blocs/cashier_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/profile_generator_image_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import '../../../../../theme/theme_data.dart';
import '../seller_filter_options_widget.dart';

class MobileSalesListWidget extends StatefulWidget {
  const MobileSalesListWidget({
    Key? key,
    required this.sales,
    required this.hasMore,
  }) : super(key: key);

  final List<Cashier> sales;
  final bool hasMore;

  @override
  State<MobileSalesListWidget> createState() => _MobileSalesListWidgetState();
}

class _MobileSalesListWidgetState extends State<MobileSalesListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<CashierBloc>().add(const GetAllCashiersSalesEvent(getMore: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SellerFilterOptionsWidget(
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
                ? MobileSalesItemWidget(cashier: widget.sales[index])
                : const CupertinoActivityIndicator(),
          ),
        ),
      ],
    );
  }
}

class MobileSalesItemWidget extends StatelessWidget {
  final Cashier cashier;

  const MobileSalesItemWidget({Key? key, required this.cashier}) : super(key: key);

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
            itemLabel: cashier.name,
            itemColorIndex: 3,
          ),
          context.sizedBoxHeightExtraSmall,
          Expanded(
              child: Text(cashier.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
          context.sizedBoxHeightExtraSmall,
          Row(children: [
            Text(S.current.role),
            Expanded(
                child: Text(
              cashier.cashierRole,
              textAlign: TextAlign.right,
            ))
          ]),
          context.sizedBoxHeightMicro,
          Row(children: [
            Text(S.current.sales),
            Expanded(
                child: Text(
              cashier.totalSales.toString(),
              textAlign: TextAlign.right,
            ))
          ]),
        ],
      ),
    );
  }
}
