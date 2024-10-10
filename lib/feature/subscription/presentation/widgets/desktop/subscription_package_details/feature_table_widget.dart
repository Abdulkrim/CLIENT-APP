import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../../widgets/app_dividers.dart';
import '../../../../../../widgets/loading_widget.dart';
import '../../../blocs/select_plan/cubit/select_plan_cubit.dart';
import 'package_feature_item_widget.dart';
import 'selected_features_costs_widget.dart';

class FeaturesTableWidget extends StatelessWidget {
  const FeaturesTableWidget({super.key, required this.rowHeight, required this.goPlanDetailsPage});

  final double rowHeight;
  final Function() goPlanDetailsPage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectPlanCubit, SelectPlanState>(
      listener: (context, state) {
        if (state is GetSubscriptionPackgeDetailsState && state.errorMessage.isNotEmpty) {}
      },
      buildWhen: (previous, current) => current is GetSubscriptionPackgeDetailsState,
      builder: (context, state) {
        if (state is GetSubscriptionPackgeDetailsState && state.isLoading) {
          return const LoadingWidget();
        } else if (state is GetSubscriptionPackgeDetailsState && state.packageDetails != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          S.current.features,
                          style: context.textTheme.titleSmall,
                        )),
                    Expanded(
                        child: Text(
                      S.current.status,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall,
                    )),
                    Expanded(
                        child: Text(
                      S.current.price,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall,
                    )),
                  ],
                ),
              ),
              context.sizedBoxHeightExtraSmall,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0f000000),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...state.packageDetails!
                        .map((e) => PackageFeatureItemWidget(
                            feature: e, rowHeight: rowHeight, isOpenByDefault: e.isInTheSelectedPackage))
                        .toList(),
                    appHorizontalDivider(),
                    SelectedFeaturesCostsWidget(
                      rowHeight: rowHeight,
                      goPlanDetailsPage: goPlanDetailsPage,
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
