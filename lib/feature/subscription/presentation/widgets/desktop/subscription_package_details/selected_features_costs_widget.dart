import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/enums/subscription_periods.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../../utils/mixins/mixins.dart';
import '../../../../../../widgets/app_dividers.dart';
import '../checkout/select_subscription_payment_mode_dialog.dart';

class SelectedFeaturesCostsWidget extends StatelessWidget with DownloadUtils {
  const SelectedFeaturesCostsWidget({super.key, required this.rowHeight, required this.goPlanDetailsPage});

  final double rowHeight;
  final Function() goPlanDetailsPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: rowHeight,
          child: Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                  child: Text(
                S.current.basePrice,
                style: context.textTheme.labelMedium,
                textAlign: TextAlign.center,
              )),
              appVerticalDivider(),
              Expanded(
                  child: Text(
                '${context.read<SelectPlanCubit>().selectedSubscriptionPeriod == SubscriptionPeriods.monthly ? context.read<SelectPlanCubit>().selectedPlan!.packagePricingWithCulture.monthlyPriceWithDiscount.toString() : context.read<SelectPlanCubit>().selectedPlan!.packagePricingWithCulture.yearlyPriceWithDiscount.toString()} ${context.read<SelectPlanCubit>().selectedPlan!.packagePricingWithCulture.currency.name}',
                style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        appHorizontalDivider(),
        SizedBox(
          height: rowHeight,
          child: Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                  child: Text(
                S.current.addOnCharges,
                style: context.textTheme.labelMedium,
                textAlign: TextAlign.center,
              )),
              appVerticalDivider(),
              Expanded(
                  child: Text(
                '${context.select((SelectPlanCubit bloc) => bloc.selectedPackageCalculation?.extraFeaturesPrice ?? '-')} ${context.read<SelectPlanCubit>().selectedPackageCalculation?.currency.name ?? '-'}',
                style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        appHorizontalDivider(),
        SizedBox(
          height: rowHeight,
          child: Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                  child: Text(
                S.current.tax,
                style: context.textTheme.labelMedium,
                textAlign: TextAlign.center,
              )),
              appVerticalDivider(),
              Expanded(
                  child: Text(
                '${context.select((SelectPlanCubit bloc) => bloc.selectedPackageCalculation?.taxPrice ?? '-')} ${context.read<SelectPlanCubit>().selectedPackageCalculation?.currency.name ?? '-'}',
                style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        appHorizontalDivider(dividerWidth: 1, color: AppColors.black),
        SizedBox(
          height: rowHeight,
          child: Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                child: Text(
                  S.current.totalPrice,
                  style: context.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              appVerticalDivider(),
              Expanded(
                  child: Text(
                '${context.select((SelectPlanCubit bloc) => bloc.selectedPackageCalculation?.finalPrice ?? '-')} ${context.read<SelectPlanCubit>().selectedPackageCalculation?.currency.name ?? '-'}',
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        appHorizontalDivider(dividerWidth: 1, color: AppColors.black),
        SizedBox(
          height: rowHeight,
          child: Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              const Expanded(child: SizedBox()),
              appVerticalDivider(),
              Expanded(
                  child: BlocConsumer<SelectPlanCubit, SelectPlanState>(
                listener: (context, state) {
                  if (state is SubscribeToPackageState && state.isSuccessed) {
                    /*context.showCustomeAlert(S.current.subscribedSuccessfully, SnackBarType.success);
                    goPlanDetailsPage();*/

                    // Get.dialog(SuccessfulPaymentDialog(onContinueTapped: (){}));
                  } else if (state is SubscribeToPackageState && state.errorMessage.isNotEmpty) {
                    context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                  }
                },
                builder: (context, state) => (state is SubscribeToPackageState && state.isLoading)
                    ? const LoadingWidget()
                    : RoundedBtnWidget(
                        btnMargin: const EdgeInsets.all(8),
                        bgColor: Colors.green,
                        onTap: () {
                          Get.dialog(SelectSubscriptionPaymentModeDialog(
                            onOnlinePayTapped: () => context.read<SelectPlanCubit>().subscribeToPackage(payTypeId: 2),
                          ));
                        },
                        btnText: S.current.checkout,
                      ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
