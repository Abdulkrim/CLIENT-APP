import 'package:merchant_dashboard/feature/notifications/data/models/entity/sms_notification.dart';

class NotificationSettingsResponse {
  bool? smsAllowed;
  num? smsBalance;


  NotificationSettingsResponse.fromJson(Map<String, dynamic> json)
      : smsAllowed = json['smsAllowed'],
        smsBalance = json['smsBalance'];

  SMSNotification toEntity() => SMSNotification(smsAllowed: smsAllowed ?? false, smsBalance: smsBalance ?? 0);
}
