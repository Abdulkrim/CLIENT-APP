
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/widgets/desktop/subscription_package_details/subfeature_item_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../../theme/theme_data.dart';
import '../../../../../../widgets/app_dividers.dart';
import '../../../../../../widgets/app_status_toggle_widget.dart';
import '../../../../data/models/entity/subscription_package_details.dart';

class PackageFeatureItemWidget extends StatefulWidget {
  const PackageFeatureItemWidget(
      {super.key, required this.feature, required this.rowHeight, required this.isOpenByDefault});

  final SubscriptionPackageDetails feature;
  final double rowHeight;
  final bool isOpenByDefault;

  @override
  State<PackageFeatureItemWidget> createState() => _PackageFeatureItemWidgetState();
}

class _PackageFeatureItemWidgetState extends State<PackageFeatureItemWidget> {
  late bool _isOpen = widget.isOpenByDefault;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: widget.rowHeight,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Icon(
                        !_isOpen ? Icons.circle : Icons.check_circle,
                        color: !_isOpen ? AppColors.gray : null,
                        size: 15,
                      ),
                      context.sizedBoxWidthMicro,
                      Text(
                        widget.feature.featureGroupName,
                        style: context.textTheme.titleSmall
                            ?.copyWith(color: !_isOpen ? null : context.colorScheme.primaryColor),
                      ),
                    ],
                  )),
              appVerticalDivider(),
              Expanded(
                  child: Center(
                child: AppSwitchToggle(
                  scale: .6,
                  currentStatus: _isOpen,
                  onStatusChanged: (status) => setState(() => _isOpen = status),
                ),
              )),
              appVerticalDivider(),
              Expanded(
                  child: Text(
                widget.feature.totalPrice.toString(),
                textAlign: TextAlign.center,
                style: context.textTheme.titleSmall,
              )),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            height: _isOpen ? null : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.feature.featuresWithCulture
                  .map(
                    (e) => SubFeatureItemWidget(feature: e, rowHeight: widget.rowHeight),
                  )
                  .toList(),
            ),
          ),
        ),
        appHorizontalDivider(),
      ],
    );
  }
}
