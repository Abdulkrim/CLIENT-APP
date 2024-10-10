import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/credit_history/credit_history_cubit.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../injection.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../transaction/presentation/blocs/transaction_bloc.dart';
import '../../../data/models/entity/customer_credit_history.dart';
import '../../../data/models/entity/customer_list_info.dart';
import '../transaction_details_dialog.dart';

class MobileCustomerCreditHistoriesScreen extends StatelessWidget {
  const MobileCustomerCreditHistoriesScreen({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            S.current.creditHistory,
            style: context.textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateRangePickerWidget(
                height: 50,
                width: 450,
                initialFromDate: context.select<CreditHistoryCubit, String>((value) => value.fromDate),
                initialToDate: context.select<CreditHistoryCubit, String>((value) => value.toDate),
                onDateRangeChanged: (String fromDate, String toDate) {
                  context
                      .read<CreditHistoryCubit>()
                      .getCreditHistoriesOfCustomer(customerId: customer.id, rFromDate: fromDate, rToDate: toDate);
                },
              ),
              context.sizedBoxHeightExtraSmall,
              Expanded(
                  child: BlocBuilder<CreditHistoryCubit, CreditHistoryState>(
                      builder: (context, state) => (state is GetCustomerCreditHistories && state.isLoading)
                          ? const LoadingWidget()
                          : ListView.builder(
                              itemCount: context.read<CreditHistoryCubit>().customerCreditHistories.length,
                              itemBuilder: (context, index) => _MobileCreditHistoryItemWidget(
                                  context.read<CreditHistoryCubit>().customerCreditHistories[index]),
                            )))
            ],
          ),
        ));
  }
}

class _MobileCreditHistoryItemWidget extends StatelessWidget {
  const _MobileCreditHistoryItemWidget(this.creditHistory);

  final CustomerCreditHistory creditHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppStyles.boxShadow,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: '${S.current.date}\n', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      TextSpan(
                          text: creditHistory.dateTime,
                          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                  )),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: AppColors.gray2,
          ),
          context.sizedBoxHeightExtraSmall,
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: '${S.current.type}\n', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      TextSpan(
                          text: creditHistory.type, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                  )),
              Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: '${S.current.amount}\n', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      TextSpan(
                          text: creditHistory.amount.toString(),
                          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                  )),
              Expanded(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: '${S.current.balance}\n', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  TextSpan(
                      text: creditHistory.balance.toString(),
                      style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                ]),
              )),
            ],
          ),
          context.sizedBoxHeightExtraSmall,
          Visibility(
            visible: creditHistory.isTransactionType,
            child: RoundedBtnWidget(
              bgColor: Colors.white,
              boxBorder: Border.all(color: Colors.black , width: .5),
              borderRadios: 10,
              btnTextColor: Colors.black,
              btnPadding: const EdgeInsets.symmetric(vertical: 10),
              onTap: () {
                Get.to(BlocProvider.value(
                  value: getIt<TransactionBloc>()..add(GetTransactionDetailsEvent(creditHistory.id)),
                  child: const TransactionDetailsDialog(),
                ));
              },
              btnText: S.current.viewDetails,
            ),
          ),
        ],
      ),
    );
  }
}
