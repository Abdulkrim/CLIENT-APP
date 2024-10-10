import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class SMSNotificationParameter extends MerchantBranchParameter {
  String notificationId = '';
  String notificationType = '';
  String notificationEvent = '';
  String text = '';

  SMSNotificationParameter.add({
    required this.notificationType,
    required this.notificationEvent,
    required this.text,
  });

  SMSNotificationParameter.edit({
    required this.notificationId,
    required this.notificationType,
    required this.notificationEvent,
    required this.text,
  });

  SMSNotificationParameter.delete({
    required this.notificationId,
  });

  Map<String, dynamic> toAddJson() => {"notificationTypeId": notificationType, "notificationEventId": notificationEvent, "text": text};

  Map<String, dynamic> notificationIdJson() => {"notificationId": notificationId};
}
