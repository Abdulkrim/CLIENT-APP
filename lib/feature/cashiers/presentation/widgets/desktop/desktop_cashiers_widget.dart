import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/blocs/cashier_bloc.dart';
import 'package:merchant_dashboard/feature/cashiers/presentation/widgets/desktop/desktop_cashiers_list_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/shimmer.dart';

import '../cashier_details_widget.dart';

class DesktopCashiersWidget extends StatelessWidget {
  const DesktopCashiersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Visibility(
            visible: context.select<CashierBloc, bool>((value) => value.cashierRoles.isNotEmpty),
            child: RoundedBtnWidget(
              onTap: () {
                Get.dialog(BlocProvider.value(
                  value: BlocProvider.of<CashierBloc>(context),
                  child: const CashierDetailsWidget(),
                ));
              },
              btnIcon: SvgPicture.asset(Assets.iconsUserIcon, color: Colors.white),
              btnText: S.current.addOperator,
              width: 150,
              height: 35,
              btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        context.sizedBoxHeightMicro,
        Expanded(
          child: BlocBuilder<CashierBloc, CashierState>(
            builder: (context, state) {
              if (state is CashierListLoadingState) {
                return ShimmerWidget(width: Get.width, height: Get.height);
              }
              return DesktopCashiersListWidget(
                cashiers:
                    context.select<CashierBloc, List<Cashier>>((value) => value.cashierPagination.listItems),
              );
            },
          ),
        )
      ],
    );
  }
}
