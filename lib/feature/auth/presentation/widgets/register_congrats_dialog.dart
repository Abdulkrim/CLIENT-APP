import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../generated/assets.dart';
import '../../../../theme/theme_data.dart';
import '../../../../widgets/rounded_btn.dart';

class RegisterCongratsWidget extends StatelessWidget {
  final Function() onTap;
  const RegisterCongratsWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            width: Get.width * .8,
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            height: 500,
            decoration: BoxDecoration(color: AppColors.white, borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  Assets.animsCongrats2,
                  width: 200,
                ),
                context.sizedBoxHeightMicro,
                Text(S.current.congratulation, style: context.textTheme.titleLarge),
                context.sizedBoxHeightExtraSmall,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(S.current.registrationCompleted,
                    style: context.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                context.sizedBoxHeightSmall,
                RoundedBtnWidget(
                  onTap: onTap,
                  btnText: S.current.continuee,
                  width: 300,
                  btnTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
                  btnPadding: const EdgeInsets.symmetric(vertical: 7),
                ),
              ],
            )),
      ),
    );
  }
}
