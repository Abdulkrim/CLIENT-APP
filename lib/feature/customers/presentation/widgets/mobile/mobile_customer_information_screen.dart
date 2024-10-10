import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_list_info.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/credit_history/credit_history_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../injection.dart';
import '../../blocs/payment/customer_payment_cubit.dart';
import '../customer_create_payment_dialog.dart';
import 'mobile_customer_credit_histories_screen.dart';

class MobileCustomerInformationScreen extends StatelessWidget {
  const MobileCustomerInformationScreen({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
        title: S.current.customerInformation,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    S.current.customerName,
                    style: context.textTheme.bodyMedium,
                  ),
                  Expanded(
                      child: Text(customer.name,
                          textAlign: TextAlign.right,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.phoneNumber,
                    style: context.textTheme.bodyMedium,
                  ),
                  Expanded(
                      child: Text(customer.phoneNumber,
                          textAlign: TextAlign.right,
                          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold))),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              Row(
                children: [
                  Text(
                    S.current.creditBalance,
                    style: context.textTheme.bodyMedium,
                  ),
                  Expanded(
                      child: Text(customer.balanceWithCurrency,
                          textAlign: TextAlign.right,
                          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold))),
                ],
              ),
              context.sizedBoxHeightSmall,
              RoundedBtnWidget(
                onTap: () => Get.dialog(BlocProvider<CustomerPaymentCubit>(
                  create: (context) => getIt<CustomerPaymentCubit>()..getBranchPaymentModeTypes(),
                  child: CustomerCreatePaymentDialog(
                    customerId: customer.id,
                    totalCreditBalance: customer.balance,
                  ),
                )),
                width: 280,
                btnPadding: const EdgeInsets.symmetric(vertical: 10),
                btnText: S.current.createPayment,
                btnIcon: SvgPicture.asset(Assets.iconsCreatePayIcon, width: 20,)
              ),
              context.sizedBoxHeightMicro,
              RoundedBtnWidget(
                onTap: () {
                  Get.to(BlocProvider<CreditHistoryCubit>.value(
                    value: BlocProvider.of<CreditHistoryCubit>(context)..getCreditHistoriesOfCustomer(customerId: customer.id),
                    child: MobileCustomerCreditHistoriesScreen(
                      customer: customer,
                    ),
                  ));
                },
                width: 280,
                btnPadding: const EdgeInsets.symmetric(vertical: 10),
                btnText: S.current.viewCreditHistory,
                bgColor: Colors.white,
                btnIcon: SvgPicture.asset(Assets.iconsCreditHistoriesIcon , width: 20,),
                btnTextColor: context.colorScheme.primaryColor,
                boxBorder: Border.all(color: context.colorScheme.primaryColor),
              ),
            ],
          ),
        ));
  }
}
