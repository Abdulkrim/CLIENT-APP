import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_dividers.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../../generated/l10n.dart';
import '../../../blocs/payment/payment_status_cubit.dart';

class PaymentResultScreen extends StatelessWidget {
  const PaymentResultScreen({super.key, required this.onContinueTapped, required this.payId});

  final String payId;
  final Function() onContinueTapped;

  @override
  Widget build(BuildContext context) {
    final payStatusData = context.select((PaymentStatusCubit bloc) => bloc.paymentStatus);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(Assets.logoCatalogakLogo, width: 200,),
              ),
              Center(
                child: payStatusData == null || !payStatusData.isValidStatus
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (payStatusData.isSuccess)
                              ? Lottie.asset(Assets.animsSuccessPaymentAnimation, height: 150)
                              : SvgPicture.asset(Assets.iconsCancelIcon, height: 100),
                          context.sizedBoxHeightExtraSmall,
                          Text(
                            (payStatusData.isSuccess) ? S.current.successfullyPayment : S.current.failedPayment,
                            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            (payStatusData.isSuccess)
                                ? S.current.successfullyPaymentDescription
                                : S.current.failedPaymentDescription,
                            style: context.textTheme.titleMedium,
                          ),
                          Container(
                            width: 500,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: AppStyles.boxShadow,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(S.current.invoiceNo, style: context.textTheme.titleMedium),
                                    Expanded(
                                      child: Text(
                                        payStatusData.invoiceId,
                                        textAlign: TextAlign.right,
                                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                context.sizedBoxHeightExtraSmall,
                                appHorizontalDivider(),
                                context.sizedBoxHeightExtraSmall,
                                Row(
                                  children: [
                                    Text(S.current.branchName, style: context.textTheme.titleMedium),
                                    Expanded(
                                      child: Text(
                                        payStatusData.branchName,
                                        textAlign: TextAlign.right,
                                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                context.sizedBoxHeightExtraSmall,
                                appHorizontalDivider(),
                                context.sizedBoxHeightExtraSmall,
                                Row(
                                  children: [
                                    Text(
                                      S.current.amount,
                                      style: context.textTheme.titleMedium,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: payStatusData.amount.toString(),
                                            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text: ' ${payStatusData.currency}', style: context.textTheme.bodySmall),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          RoundedBtnWidget(
                            onTap: () {
                              Get.back();

                              onContinueTapped();
                            },
                            btnText: S.current.continuee,
                            width: 150,
                            height: 30,
                          ),
                        ],
                      ),
              ),
              Center(
                  child: BlocBuilder<PaymentStatusCubit, PaymentStatusState>(
                builder: (context, state) =>
                    Visibility(visible: state is PaymentStatusResultState && state.isLoading, child: const LoadingWidget()),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
