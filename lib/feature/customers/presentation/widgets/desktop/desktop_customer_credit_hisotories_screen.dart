import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_list_info.dart';
import 'package:merchant_dashboard/feature/customers/presentation/widgets/desktop/desktop_customer_credit_histories_table_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../injection.dart';
import '../../../../../widgets/date_picker_widget/date_range_picker_widget.dart';
import '../../blocs/credit_history/credit_history_cubit.dart';
import '../../blocs/payment/customer_payment_cubit.dart';
import '../customer_create_payment_dialog.dart';

class DesktopCustomerCreditHistoriesScreen extends StatefulWidget {
  const DesktopCustomerCreditHistoriesScreen({super.key, required this.customer, required this.onBackTap});

  final Customer customer;
  final Function() onBackTap;

  @override
  State<DesktopCustomerCreditHistoriesScreen> createState() => _DesktopCustomerCreditHistoriesScreenState();
}

class _DesktopCustomerCreditHistoriesScreenState extends State<DesktopCustomerCreditHistoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CreditHistoryCubit>().getCreditHistoriesOfCustomer(
        customerId: widget.customer.id, rFromDate: Defaults.startDateRange, rToDate: Defaults.endDateRange);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: widget.onBackTap,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            context.sizedBoxWidthMicro,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.current.creditHistory,
                  style: context.textTheme.titleLarge,
                ),
                context.sizedBoxWidthMicro,
                IconButton(
                    onPressed: () {
                      context.read<CreditHistoryCubit>().getCreditHistoriesOfCustomer(customerId: widget.customer.id);
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.black,
                    )),
              ],
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              child: RoundedBtnWidget(
                  onTap: () => Get.dialog(BlocProvider<CustomerPaymentCubit>(
                        create: (context) => getIt<CustomerPaymentCubit>()..getBranchPaymentModeTypes(),
                        child: CustomerCreatePaymentDialog(
                          customerId: widget.customer.id,
                          totalCreditBalance: widget.customer.balance,
                        ),
                      )),
                  width: 280,
                  btnPadding: const EdgeInsets.symmetric(vertical: 10),
                  btnText: S.current.createPayment,
                  btnIcon: SvgPicture.asset(
                    Assets.iconsCreatePayIcon,
                    width: 20,
                  )),
            ))
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: DateRangePickerWidget(
            height: 50,
            width: 450,
            initialFromDate: context.select<CreditHistoryCubit, String>((value) => value.fromDate),
            initialToDate: context.select<CreditHistoryCubit, String>((value) => value.toDate),
            onDateRangeChanged: (String fromDate, String toDate) {
              context
                  .read<CreditHistoryCubit>()
                  .getCreditHistoriesOfCustomer(customerId: widget.customer.id, rFromDate: fromDate, rToDate: toDate);
            },
          ),
        ),
        context.sizedBoxHeightSmall,
        Expanded(
            child: BlocBuilder<CreditHistoryCubit, CreditHistoryState>(
                builder: (context, state) => (state is GetCustomerCreditHistories && state.isLoading)
                    ? const LoadingWidget()
                    : DesktopCustomerCreditHistoriesTableWidget(
                        creditHistories: context.read<CreditHistoryCubit>().customerCreditHistories)))
      ],
    );
  }
}
