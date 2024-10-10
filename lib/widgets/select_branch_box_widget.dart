import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../feature/main_screen/presentation/widgets/desktop/desktop_branches_dropdown_widget.dart';

class SelectBranchBoxWidget extends StatelessWidget {
  const SelectBranchBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            S.current.plzSelectBranch,
            style: context.textTheme.titleLarge,
          ),
          context.sizedBoxHeightSmall,
          SizedBox(width: Get.width, child: DesktopBranchesDropDownWidget()),
          context.sizedBoxHeightSmall,
        ],
      ),
    );
  }
}
