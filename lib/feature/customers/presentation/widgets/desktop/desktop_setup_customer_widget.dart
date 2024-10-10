import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/customers/customer_bloc.dart';
import 'package:merchant_dashboard/feature/customers/presentation/widgets/customer_details_dialog.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/scrollable_widget.dart';

class DesktopSetupCustomerWidget extends StatelessWidget {
  const DesktopSetupCustomerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          context.sizedBoxHeightDefault,
          Row(
            children: [
              context.sizedBoxWidthExtraSmall,
              const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
              context.sizedBoxWidthMicro,
              Text(
               S.current.addCustomer,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          context.sizedBoxHeightDefault,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
            margin: const EdgeInsets.all(32),
            height: 400,
            width: 700,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Color(0x0f000000),
                offset: Offset(0, 4),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ], color: AppColors.white, borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: ScrollableWidget(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.iconsEmptyCustomersIcon,
                      width: 100,
                    ),
                    context.sizedBoxHeightSmall,
                    Text(
                     S.current.addCustomer,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    ),
                    context.sizedBoxHeightMicro,
                    Text(
                      S.current.addCustomerDesc,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    context.sizedBoxHeightSmall,
                    RoundedBtnWidget(
                      onTap: () => Get.dialog(BlocProvider.value(
                        value: BlocProvider.of<CustomerBloc>(context),
                        child: const CustomerDetailsDialog(),
                      )),
                      width: 170,
                      btnText: S.current.addCustomer,
                      btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      btnPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      btnIcon: SvgPicture.asset(
                        Assets.iconsCustomersIcon,
                        width: 18,
                        color: Colors.white,
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
