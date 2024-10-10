import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/worker_report.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/profile_generator_image_widget.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../blocs/dashboard_bloc.dart';

class MobileWorkerSalesSectionWidget extends StatelessWidget {
  const MobileWorkerSalesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<WorkerReport> cashiers = context.select<DashboardBloc, List<WorkerReport>>((value) => value.workers);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        context.sizedBoxHeightExtraSmall,
        Row(
          children: [
            SvgPicture.asset(
              Assets.iconsUsersMenu,
              width: 20,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              S.current.workerSales,
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
              itemBuilder: (context, index) => _WorkerReportItemWidget(
                name: cashiers[index].workerName,
                amount: cashiers[index].sumPrice,
              ),
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              buildWhen: (previous, current) => current is GetWorkersStates,
              builder: (context, state) => Visibility(
                  visible: state is GetWorkersStates && state.isLoading,
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

class _WorkerReportItemWidget extends StatelessWidget with ProfileBGColorGenerator {
  const _WorkerReportItemWidget({required this.name, required this.amount});

  final String name;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
