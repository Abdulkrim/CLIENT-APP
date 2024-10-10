import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../../../../widgets/setup_import_excel_dialog.dart';

class DesktopSetupStockWidget extends StatelessWidget {
  const DesktopSetupStockWidget({super.key});

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
               S.current.addStock,
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
                      Assets.iconsStocksEmptyBox,
                      width: 100,
                    ),
                    context.sizedBoxHeightSmall,
                    Text(
                     S.current.whatStockAdd,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    ),
                    context.sizedBoxHeightMicro,
                    Text(
                     S.current.addSomeStocks,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    context.sizedBoxHeightSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedBtnWidget(
                          onTap: () {
                            Get.dialog(const SetupImportExcelDialog());
                          },
                          btnText: S.current.import,
                          width: 170,
                          btnTextColor: context.colorScheme.primaryColor,
                          btnTextStyle:
                              context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          boxBorder: Border.all(color: context.colorScheme.primaryColor),
                          bgColor: Colors.transparent,
                          btnPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                          btnIcon: SvgPicture.asset(
                            Assets.iconsExcelIcon,
                            width: 18,
                          ),
                        ),
                        context.sizedBoxWidthMicro,
                        RoundedBtnWidget(
                          onTap: () {},
                          width: 170,
                          btnText: S.current.addStock,
                          btnTextStyle:
                              context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          btnPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          btnIcon: SvgPicture.asset(
                            Assets.iconsStock,
                            width: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
