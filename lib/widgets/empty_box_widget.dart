import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../generated/assets.dart';

class EmptyBoxWidget extends StatelessWidget {
  const EmptyBoxWidget({
    super.key,
    this.showBtn = true,
    this.btnText = 'Reset Filter',
    this.btnTap,
    this.descriptionText = 'Try adjusting the filters to view your transaction',
    this.title = 'No result found',
  });

  final bool showBtn;
  final String title;
  final String descriptionText;
  final String btnText;
  final Function? btnTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: const BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.iconsEmptyFolder,
                color: Colors.grey,
                width: 45,
              ),
              context.sizedBoxHeightExtraSmall,
              Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(color: Colors.grey),
              ),
              context.sizedBoxHeightMicro,
              Text(
                descriptionText,
                style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              Visibility(
                visible: showBtn,
                child: RoundedBtnWidget(
                  onTap: () => (btnTap != null)
                      ? btnTap!()
                      : () {
                          debugPrint('empty box btn tapped!');
                        },
                  btnText: btnText,
                  width: 300,
                  height: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
