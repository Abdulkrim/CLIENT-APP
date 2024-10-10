import 'package:merchant_dashboard/feature/notifications/data/models/entity/text_notification.dart';

class NotificationsResponse {
  final List<NotificationsItemResponse> items;

  NotificationsResponse(this.items);

  NotificationsResponse.fromJson(List<dynamic>? json) : items = json?.map((e) => NotificationsItemResponse.fromJson(e)).toList() ?? [];

  List<TextNotification> toEntity() => items
      .map((e) => TextNotification(
          notificationBaseID: e.notificationBaseID ?? '',
          notificationTypeId: e.notificationTypeId ?? '',
          notificationEventId: e.notificationEventId ?? '',
          notificationEvent: e.notificationEvent ?? '',
          notificationType: e.notificationType ?? '',
          text: e.text ?? ''))
      .toList();
}

class NotificationsItemResponse {
  String? notificationBaseID;
  String? branchId;
  String? notificationTypeId;
  String? notificationType;
  String? notificationEventId;
  String? notificationEvent;
  String? text;
  bool? isDeleted;

  NotificationsItemResponse(
      {this.notificationBaseID,
      this.branchId,
      this.notificationTypeId,
      this.notificationType,
      this.notificationEventId,
      this.notificationEvent,
      this.text,
      this.isDeleted});

  NotificationsItemResponse.fromJson(Map<String, dynamic> json) {
    notificationBaseID = json['notificationBaseID'];
    branchId = json['branchId'];
    notificationTypeId = json['notificationTypeId'];
    notificationType = json['notificationType'];
    notificationEventId = json['notificationEventId'];
    notificationEvent = json['notificationEvent'];
    text = json['text'];
    isDeleted = json['isDeleted'];
  }
}
