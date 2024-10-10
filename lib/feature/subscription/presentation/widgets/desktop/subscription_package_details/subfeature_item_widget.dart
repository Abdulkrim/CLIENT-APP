import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart';

import '../../../../../../widgets/app_dividers.dart';
import '../../../../../../widgets/app_status_toggle_widget.dart';
import '../../../../data/models/entity/package_features_with_culture.dart';

class SubFeatureItemWidget extends StatefulWidget {
  const SubFeatureItemWidget({super.key, required this.feature, required this.rowHeight});

  final double rowHeight;
  final PackageFeaturesWithCulture feature;

  @override
  State<SubFeatureItemWidget> createState() => _SubFeatureItemWidgetState();
}

class _SubFeatureItemWidgetState extends State<SubFeatureItemWidget> {
  late bool _isOpen = widget.feature.isInTheSelectedPackage ?? false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.rowHeight,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                '    ${widget.feature.featureName}',
                style: context.textTheme.labelMedium,
              )),
          appVerticalDivider(),
          Expanded(
              child: Center(
            child: widget.feature.isSubFeatureSelected
                ? const Icon(Icons.check_circle, color: Colors.green)
                : AppSwitchToggle(
                    scale: .6,
                    currentStatus: _isOpen,
                    onStatusChanged: (status) {
                      /// If isInTheSelectedPackage == true, then it shouldn't change by the user
                      if(widget.feature.isInTheSelectedPackage ?? false) return;

                      setState(() => _isOpen = status);
                      if (status) {
                        context.read<SelectPlanCubit>().selectedAddonItems.addIf(
                            !context.read<SelectPlanCubit>().selectedAddonItems.contains(widget.feature.id), widget.feature.id);
                      } else {
                        context.read<SelectPlanCubit>().selectedAddonItems.remove(widget.feature.id);
                      }

                      context.read<SelectPlanCubit>().getSelectedPlanCalculate();
                    },
                  ),
          )),
          appVerticalDivider(),
          Expanded(
              child: Text(
            (widget.feature.isSubFeatureSelected || _isOpen)
                ? widget.feature.featurePricingWithCulture?.subFeaturePrice.toString() ?? '-'
                : '-',
            style: context.textTheme.labelMedium,
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
