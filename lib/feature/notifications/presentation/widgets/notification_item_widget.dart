import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../theme/theme_data.dart';
import '../../data/models/entity/text_notification.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
    required this.textNotification,
    required this.onDeleteTap,
    required this.onEditTap,
    required this.bgColor,
  });

  final TextNotification textNotification;
  final Function() onEditTap;
  final Function() onDeleteTap;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(boxShadow: AppStyles.boxShadow, color: bgColor ?? AppColors.white, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  child: (context.isPhone ? _getNotificationItemsFoMobile : _getNotificationItemsForWeb)(
                      context, textNotification.notificationType, textNotification.notificationEvent, textNotification.text)),
              IconButton(
                  onPressed: onEditTap,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: onDeleteTap,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getNotificationItemsFoMobile(BuildContext context, String notificationType, String notificationEvent, String text) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: '${S.current.type}\n', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(text: notificationType, style: context.textTheme.bodyMedium),
          ]),
        ),
        context.sizedBoxHeightExtraSmall,
        RichText(
          text: TextSpan(children: [
            TextSpan(text: '${S.current.event}\n', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(text: notificationEvent, style: context.textTheme.bodyMedium),
          ]),
        ),
        context.sizedBoxHeightExtraSmall,
        RichText(
          text: TextSpan(children: [
            TextSpan(text: '${S.current.text}\n', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(text: text, style: context.textTheme.bodyMedium),
          ]),
        )
      ]);

  Widget _getNotificationItemsForWeb(BuildContext context, String notificationType, String notificationEvent, String text) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '${S.current.type}\n\n', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: notificationType, style: context.textTheme.bodyMedium),
              ]),
            ),
          ),
          Expanded(
            flex: 1,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '${S.current.event}\n\n', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: notificationEvent, style: context.textTheme.bodyMedium),
              ]),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '${S.current.text}\n\n', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: text, style: context.textTheme.bodyMedium),
              ]),
            ),
          )
        ]),
      );
}
