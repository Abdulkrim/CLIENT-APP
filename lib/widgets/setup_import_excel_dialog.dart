import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_checkbox.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import 'drop_down_zone_widget.dart';

class SetupImportExcelDialog extends StatelessWidget {
  const SetupImportExcelDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      width: 450,
      height: 400,
      title: S.current.importProduct,
      child: ScrollableWidget(
        scrollViewPadding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: S.current.downloadA, style: context.textTheme.bodyMedium),
              TextSpan(text:S.current.csvTemp, style: context.textTheme.bodyMedium?.copyWith(color: Colors.blue)),
            ])),
            context.sizedBoxHeightExtraSmall,
            DropDownZoneWidget(
              fileUploaded: (name, mime, url, byte) {},
            ),
            context.sizedBoxHeightExtraSmall,
            RoundedCheckBoxWidget(
              onChnageCheck: (check) => debugPrint(
                check.toString(),
              ),
              textStyle: context.textTheme.bodyMedium,
              text: S.current.publishNewPro,
            ),
            context.sizedBoxHeightExtraSmall,
            RoundedCheckBoxWidget(
              onChnageCheck: (check) => debugPrint(
                check.toString(),
              ),
              textStyle: context.textTheme.bodyMedium,
              text: S.current.replaceProduct,
            ),
            context.sizedBoxHeightExtraSmall,
            Row(
              children: [
                Expanded(
                    child: RoundedBtnWidget(
                  onTap: () {},
                  height: 40,
                  bgColor: Colors.white,
                  btnTextColor: Colors.black,
                  boxBorder: Border.all(color: Colors.black),
                  btnText: S.current.cancel,
                )),
                context.sizedBoxWidthMicro,
                Expanded(
                    child: RoundedBtnWidget(
                  onTap: () {},
                  height: 40,
                  btnText: S.current.import,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
