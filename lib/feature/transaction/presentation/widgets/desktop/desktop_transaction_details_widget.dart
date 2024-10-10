import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/presentation/blocs/transaction_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../transaction_details_list_widget.dart';

class DesktopTransactionDetailsWidget extends StatelessWidget {
  final Transaction transaction;
  List<int> selectedDetailsIds = [];

  DesktopTransactionDetailsWidget({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        title: S.current.transactionDetails,
        child: ScrollableWidget(
          scrollViewPadding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    S.current.cashier,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(transaction.userName,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.gray))),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.transactionNo,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(transaction.transactionNo.toString(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.gray))),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.transactionOfflineId,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(transaction.offlineTransactionId.toString(),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.gray))),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.voucher,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(transaction.voucher.toString(),
                          textAlign: TextAlign.end, style: context.textTheme.titleSmall)),
                ],
              ),
              Visibility(
                visible: transaction.worker.trim().isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    context.sizedBoxHeightExtraSmall,
                    Row(
                      children: [
                        Text(
                          S.current.worker,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Text(transaction.worker,
                                textAlign: TextAlign.end, style: context.textTheme.titleSmall)),
                      ],
                    ),
                  ],
                ),
              ),
              ...[transaction.param1Object, transaction.param2Object, transaction.param3Object]
                  .map(
                    (e) => Visibility(
                      visible: e.isEnabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            children: [
                              Text(
                                e.paramHeader,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(e.paramValue,
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleSmall)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.payment,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(transaction.payment,
                          textAlign: TextAlign.end, style: context.textTheme.titleSmall)),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.discount,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                          '${transaction.discountAmount} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                          textAlign: TextAlign.end,
                          style: context.textTheme.titleSmall)),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.deliveryFee,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                          '${transaction.deliveryFinalPrice} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                          textAlign: TextAlign.end,
                          style: context.textTheme.titleSmall)),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.deliveryDiscount,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                          '${transaction.deliveryDiscountPrice} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                          textAlign: TextAlign.end,
                          style: context.textTheme.titleSmall)),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.price,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                          '${transaction.price.toStringAsFixed(2)} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                          textAlign: TextAlign.end,
                          style: context.textTheme.titleSmall)),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.tax,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                          '${transaction.tax.toStringAsFixed(2)} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                          textAlign: TextAlign.end,
                          style: context.textTheme.titleSmall)),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.total,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                          '${transaction.total.toStringAsFixed(2)} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                          textAlign: TextAlign.end,
                          style: context.textTheme.titleSmall)),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Divider(
                color: AppColors.gray,
                thickness: 0.5,
              ),
              context.sizedBoxHeightExtraSmall,
              BlocBuilder<TransactionBloc, TransactionState>(
                  buildWhen: (previous, current) =>
                      current is GetTransactionDetailSuccessState ||
                      current is GetTransactionDetailsLoadingState,
                  builder: (context, state) => (state is GetTransactionDetailSuccessState)
                      ? TransactionProductsListWidget(
                          details: state.transactionDetails,
                          showWorker: transaction.worker.trim().isEmpty,
                          onProductSelection: (selectedPIds) {
                            selectedDetailsIds = selectedPIds;
                          },
                          isScrollable: false,
                        )
                      : const LoadingWidget()),
              /*      context.sizedBoxHeightExtraSmall,
               Visibility(
                visible: hideForThisV,
                child: RoundedBtnWidget(
                    onTap: () {
                      context.read<TransactionBloc>().add(ClaimTransactionRequestEvent(
                          transaction.transactionNo.toInt(), selectedDetailsIds));
                      Get.back();
                    },
                    btnText: S.current.claimPartially,
                    width: 350,
                    height: 35),
              ),*/
            ],
          ),
        ));
  }
}
