import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/entity/merchant_info.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';

class BranchItemWidget extends StatelessWidget {
  final bool isSelected;
  final MerchantInfo item;

  const BranchItemWidget({
    Key? key,
    required this.isSelected,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              color: AppColors.transparentPrimaryColor,
            ),
      child: Text(
        item.merchantName,
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
