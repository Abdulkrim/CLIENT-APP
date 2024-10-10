import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/widgets/mobile/mobile_transaction_filter_widget.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/widgets/mobile/mobile_transaction_list_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/date_picker_widget/date_range_picker_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../../../../widgets/rounded_btn.dart';

class TransactionMobileWidget extends StatelessWidget {
  const TransactionMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.filter,
              style: context.textTheme.titleLarge,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        isDismissible: false,
                        BlocProvider.value(
                          value: BlocProvider.of<TransactionBloc>(context),
                          child: const MobileTransactionFilterWidget(),
                        ));
                  },
                  icon: SvgPicture.asset(
                    Assets.iconsFilter,
                    height: 25,
                  ),
                ),
                DateRangePickerWidget(
                  initialFromDate: context.select<TransactionBloc, String>((value) => value.fromDate),
                  initialToDate: context.select<TransactionBloc, String>((value) => value.toDate),
                  onDateRangeChanged: (String fromDate, String toDate) {
                    context.read<TransactionBloc>().add(GetAllTransactionsEvent(fromDate: fromDate, toDate: toDate));
                  },
                )
              ],
            ),
          ],
        ),
        Center(
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              return (state is GetDownloadLinkLoadingState)
                  ? const LoadingWidget()
                  : RoundedBtnWidget(
                      onTap: () => context.read<TransactionBloc>().add(const GetDownloadLink()),
                      height: 35,
                      btnText: S.current.downloadReportOfTrans,
                      btnIcon: const Icon(
                        Icons.downloading_rounded,
                        color: Colors.white,
                      ));
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is GetAllTransactionsLoadingState) {
                return ShimmerWidget(width: Get.width, height: Get.height);
              }
              if (state is WrongDateFilterRangeEnteredState) return const SizedBox();
              return MobileTransactionListWidget(
                getTransactions: (getMore) => context.read<TransactionBloc>().add(GetAllTransactionsEvent(getMore: getMore)),
                transactions: context.select<TransactionBloc, List<Transaction>>(
                  (value) => value.transactionsPagination.listItems,
                ),
                hasMore: context.select<TransactionBloc, bool>((value) => value.transactionsPagination.hasMore),
              );
            },
          ),
        ),
      ],
    );
  }
}
