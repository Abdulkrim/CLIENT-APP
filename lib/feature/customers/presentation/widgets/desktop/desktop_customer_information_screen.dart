import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/data/models/entity/customer_list_info.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/customers/customer_bloc.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/payment/customer_payment_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../customer_create_payment_dialog.dart';

class DesktopCustomerInformationScreen extends StatefulWidget {
  const DesktopCustomerInformationScreen(
      {super.key,
      required this.customer,
      required this.onCreditHistoriesTap,
      required this.onBackTap,
      required this.onLoyaltyHistoryTap});

  final Customer customer;
  final Function() onCreditHistoriesTap;
  final Function() onBackTap;
  final Function() onLoyaltyHistoryTap;

  @override
  State<DesktopCustomerInformationScreen> createState() => _DesktopCustomerInformationScreenState();
}

class _DesktopCustomerInformationScreenState extends State<DesktopCustomerInformationScreen> {
  final double _boxWidth = 150;

  final double _boxHeight = 160;

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(GetCustomerDetails(widget.customer.id));
  }

  @override
  Widget build(BuildContext context) {
    final customerDetails = context.select((CustomerBloc bloc) => bloc.foundCustomer);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: widget.onBackTap,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                context.sizedBoxWidthMicro,
                Text(
                  S.current.customerInformation,
                  style: context.textTheme.titleLarge,
                ),
              ],
            ),
            context.sizedBoxHeightExtraSmall,
            Expanded(
                child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RoundedBtnWidget(
                      onTap: () => Get.dialog(BlocProvider<CustomerPaymentCubit>(
                            create: (context) => getIt<CustomerPaymentCubit>()..getBranchPaymentModeTypes(),
                            child: CustomerCreatePaymentDialog(
                              customerId: widget.customer.id,
                              totalCreditBalance: widget.customer.balance,
                            ),
                          )),
                      width: 250,
                      btnPadding: const EdgeInsets.symmetric(vertical: 10),
                      btnText: S.current.createPayment,
                      btnIcon: SvgPicture.asset(
                        Assets.iconsCreatePayIcon,
                        width: 20,
                      )),
                  RoundedBtnWidget(
                    onTap: () {
                      widget.onCreditHistoriesTap();
                    },
                    width: 250,
                    btnPadding: const EdgeInsets.symmetric(vertical: 10),
                    btnText: S.current.viewCreditHistory,
                    bgColor: Colors.white,
                    btnIcon: SvgPicture.asset(
                      Assets.iconsCreditHistoriesIcon,
                      width: 20,
                    ),
                    btnTextColor: context.colorScheme.primaryColor,
                    boxBorder: Border.all(color: context.colorScheme.primaryColor),
                  ),
                ],
              ),
            ))
          ],
        ),
        Wrap(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 350),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: .5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${S.current.customerName}\n',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      TextSpan(
                          text: widget.customer.name,
                          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  context.sizedBoxHeightExtraSmall,
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${S.current.phoneNumber}\n',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      TextSpan(
                          text: widget.customer.phoneNumber,
                          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  context.sizedBoxHeightExtraSmall,
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${S.current.creditBalance}\n',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      TextSpan(
                          text: widget.customer.balanceWithCurrency,
                          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              width: _boxWidth,
              height: _boxHeight,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: .5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.iconsCustomerOrders),
                  const SizedBox(height: 10),
                  Text(S.current.orders, style: context.textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Text(customerDetails?.lastOrderDateFormatted ?? '', style: context.textTheme.bodySmall),
                  const SizedBox(height: 10),
                  Text(customerDetails?.ordersCount.toString() ?? '-',
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              width: _boxWidth,
              height: _boxHeight,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: .5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.iconsCustomerTransactions),
                  const SizedBox(height: 10),
                  Text(S.current.transactions, style: context.textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Text(customerDetails?.lastTransactionDateFormatted ?? '', style: context.textTheme.bodySmall),
                  const SizedBox(height: 10),
                  Text(customerDetails?.transactionsCount.toString() ?? '-',
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              width: _boxWidth,
              height: _boxHeight,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: .5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.iconsCustomerAddresses),
                  const SizedBox(height: 10),
                  Text(S.current.addresses, style: context.textTheme.bodyMedium),
                  const SizedBox(height: 10),
                  Text(customerDetails?.addressesCount.toString() ?? '-',
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
     /*       AppInkWell(
              onTap: widget.onLoyaltyHistoryTap,
              child: Container(
                width: _boxWidth,
                height: _boxHeight,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gray, width: .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.iconsCustomerLoyalty),
                    const SizedBox(height: 10),
                    Text(S.current.loyalty, style: context.textTheme.bodyMedium),
                    const SizedBox(height: 10),
                    Text(customerDetails?.loyaltyPointCount.toString() ?? '-',
                        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ],
    );
  }
}
