import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import 'edit_url_dialog.dart';

class URLBoxWidget extends StatelessWidget {
  const URLBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Mcdonalds.catalogak',
            style: context.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
          context.sizedBoxWidthMicro,
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            onTap: () {
              Get.dialog(const EditURLDialog());
            },
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Text(
                  S.current.edit,
                  style: context.textTheme.titleSmall,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
