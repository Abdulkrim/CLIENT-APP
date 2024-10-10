import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/settings/presentation/widgets/desktop/desktop_support_request_dialog.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

class SupportDialog extends StatelessWidget {
  const SupportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 500,
          height: 350,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        Assets.iconsCancelIcon,
                        width: 20,
                      ),
                    )),
                SvgPicture.asset(
                  Assets.iconsSupportManIcon,
                  width: 100,
                ),
                context.sizedBoxHeightExtraSmall,
                Text(S.current.support, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                context.sizedBoxHeightMicro,
                Text(S.current.setupWithSupport,
                    textAlign: TextAlign.center, style: context.textTheme.bodyMedium),
                context.sizedBoxHeightExtraSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedBtnWidget(
                      onTap: () {},
                      btnText: S.current.setupMySelf,
                      btnPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                    RoundedBtnWidget(
                      onTap: () => Get.dialog(DesktopSupportRequestDialog()),
                      btnText: S.current.needSupport,
                      bgColor: Colors.white,
                      btnPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      btnTextColor: Colors.black,
                      boxBorder: Border.all(color: context.colorScheme.primaryColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
