import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/notifications/data/models/entity/text_notification.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/empty_box_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import 'notification_item_widget.dart';
import '../blocs/notifications_bloc.dart';
import 'notification_details_dialog_widget.dart';
import 'sms_settings_widget.dart';

class NotificationsListWidget extends StatefulWidget {
  const NotificationsListWidget({super.key});

  @override
  State<NotificationsListWidget> createState() => _NotificationsListWidgetState();
}

class _NotificationsListWidgetState extends State<NotificationsListWidget> {
  @override
  void initState() {
    super.initState();

  /*  if (getIt<MainScreenBloc>().selectedMerchantBranch.hasData) {

    }*/

    context.read<NotificationsBloc>()
      ..add(const GetAllSavedNotifications())
      ..add(const GetNotificationSettings());
  }

  @override
  Widget build(BuildContext context) {
    final textNotifications =
        context.select<NotificationsBloc, List<TextNotification>>((NotificationsBloc bloc) => bloc.textNotifications);

    final smsNotificationSettings = context.watch<NotificationsBloc>().smsNotification;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                S.current.smsNotification,
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            RoundedBtnWidget(
              onTap: () => (!context.isPhone ? Get.dialog : Get.to)(BlocProvider.value(
                value: BlocProvider.of<NotificationsBloc>(context),
                child: const NotificationDetailsDialogWidget(),
              )),
              btnText: S.current.addSMS,
              bgColor: Colors.white,
              btnPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
              btnIcon: const Icon(
                Icons.mark_email_read,
                size: 15,
              ),
              btnTextColor: context.colorScheme.primaryColor,
              boxBorder: Border.all(
                color: context.colorScheme.primaryColor,
              ),
            )
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        const SmsSettingsWidget(),
        (textNotifications.isEmpty)
            ? EmptyBoxWidget(
                showBtn: false,
                descriptionText: S.current.addNotification,
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: textNotifications.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) => NotificationItemWidget(
                  bgColor: ((!(smsNotificationSettings?.smsAllowed ?? true) || smsNotificationSettings?.smsBalance == 0) &&
                          textNotifications[index].notificationType.toLowerCase() == 'sms')
                      ? const Color(0xffededed)
                      : null,
                  textNotification: textNotifications[index],
                  onEditTap: () => (!context.isPhone ? Get.dialog : Get.to)(BlocProvider.value(
                    value: BlocProvider.of<NotificationsBloc>(context),
                    child: NotificationDetailsDialogWidget(textNotification: textNotifications[index]),
                  )),
                  onDeleteTap: () => context
                      .read<NotificationsBloc>()
                      .add(DeleteNotificationEvent(notificationId: textNotifications[index].notificationBaseID)),
                ),
              ),
      ],
    );
  }
}
