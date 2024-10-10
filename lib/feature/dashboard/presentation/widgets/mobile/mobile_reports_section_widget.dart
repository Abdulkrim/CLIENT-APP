import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/app_ink_well_widget.dart';
import '../../../../../widgets/profile_generator_image_widget.dart';
import '../../../data/models/entities/cashier_report.dart';
import '../../blocs/dashboard_bloc.dart';

class MobileReportsSectionWidget extends StatelessWidget {
  const MobileReportsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CashierReport> cashiers = context.select<DashboardBloc, List<CashierReport>>((value) => value.cashiers);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        context.sizedBoxHeightExtraSmall,
        Row(
          children: [
            SvgPicture.asset(
              Assets.iconsCashierMachine,
              width: 20,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              S.current.cashierSales,
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cashiers.length,
              itemBuilder: (context, index) => _CashierReportItemWidget(
                name: cashiers[index].cashierName,
                amount: cashiers[index].sumPrice,
              ),
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              buildWhen: (previous, current) =>
                  current is GetReportsLoadingState || current is GetReportsFailedState || current is GetReportsSuccessState,
              builder: (context, state) => Visibility(
                  visible: state is GetReportsLoadingState,
                  child: const Center(
                    child: LoadingWidget(),
                  )),
            )
          ],
        ),
      ],
    );
  }
}

class _CashierReportItemWidget extends StatelessWidget with ProfileBGColorGenerator {
  const _CashierReportItemWidget({required this.name, required this.amount});

  final String name;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ProfileGeneratorImageWidget(height: 50, width: 50, itemLabel: name, itemColorIndex: randomColorPos),
            context.sizedBoxWidthSmall,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                context.sizedBoxHeightMicro,
                Text(
                    '${amount.toString().getSeparatedNumber} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
