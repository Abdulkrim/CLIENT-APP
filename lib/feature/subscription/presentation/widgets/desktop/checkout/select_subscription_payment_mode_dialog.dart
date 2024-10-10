import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';

import '../../../../../../generated/l10n.dart';

class SelectSubscriptionPaymentModeDialog extends StatelessWidget {
  const SelectSubscriptionPaymentModeDialog({super.key, required this.onOnlinePayTapped});

  final Function() onOnlinePayTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
          width: 400,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: SvgPicture.asset(
                    Assets.iconsCancelIcon,
                    width: 20,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
              Text(
                S.current.choosePaymentMode,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                      child: AppInkWell(
                    onTap: (){
                      Get.back();
                      onOnlinePayTapped();

                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration:
                          const BoxDecoration(color: Color(0x14F89800), borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.iconsOnlinePayment,
                            width: 50,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            S.current.onlinePayment,
                            style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: AppInkWell(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration:
                              const BoxDecoration(color: Color(0x140077FF), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.iconsBankTransfer,
                                width: 40,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                S.current.bankTransfer,
                                style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                      AppInkWell(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                          decoration:
                              const BoxDecoration(color: Color(0x1400AE23), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.iconsCashPayment,
                                width: 30,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                S.current.cashPayment,
                                style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
